//
//  NetworkLoadService.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation
import Combine

typealias DataService = Service & DataHandler
typealias NetworkService = DataService & NetworkHandler

protocol NetworkLoadProtocol: NetworkService {
    func fetchData<T: Decodable>(for url: URL?) -> AnyPublisher<T, Error>
    func fetchData<T: Decodable>(for url: URL?) async throws -> T
    func fetchData<T: Decodable>(for request: URLRequest?) -> AnyPublisher<T, Error>
    func fetchData<T: Decodable>(for request: URLRequest?) async throws -> T
    func postData(request: URLRequest?) -> AnyPublisher<Void, Error>
    func postData(request: URLRequest?) async throws
    func resetLoadedData(for url: URL?)
}

final class NetworkLoadService: NetworkLoadProtocol {
    private(set) var decoder: JSONDecoder
    private(set) var encoder: JSONEncoder
    
    private(set) var loadedData: [String: Decodable] = [:]
    
    init() {
        self.decoder = JSONDecoder()
        self.encoder = JSONEncoder()
    }
    
    func resetLoadedData(for url: URL?) {
        guard let url = url else {
            return
        }
        
        loadedData.removeValue(forKey: url.absoluteString)
    }
}

//MARK: - Swift Concurrency workflow
extension NetworkLoadService {
    func fetchData<T: Decodable>(for url: URL?) async throws -> T {
        guard let url = url else {
            throw NetworkError.invalidRequest
        }
        
        if let cachedData = loadedData[url.absoluteString] as? T {
            return cachedData
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try tryCheckResponse(response: response)
        
        let decodedData: T = try decodeData(data: data)
        loadedData[url.absoluteString] = decodedData
        
        return decodedData
    }
    
    func fetchData<T: Decodable>(for request: URLRequest?) async throws -> T {
        guard let request = request else {
            throw NetworkError.invalidRequest
        }
        
        if let cachedData = loadedData[request.url?.absoluteString ?? ""] as? T {
            return cachedData
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        try tryCheckResponse(response: response)
        
        let decodedData: T = try decodeData(data: data)
        loadedData[request.url?.absoluteString ?? ""] = decodedData
        
        return decodedData
    }
    
    func postData(request: URLRequest?) async throws {
        guard let request = request else {
            throw NetworkError.invalidRequest
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        if !(200..<300).contains(httpResponse.statusCode) {
            throw NetworkError.requestError(errorCode: httpResponse.statusCode)
        }
    }
}

//MARK: - Combine workflow
extension NetworkLoadService {
    func fetchData<T: Decodable>(for url: URL?) -> AnyPublisher<T, Error> {
        guard let url = url else {
            return Fail(error: NetworkError.invalidRequest)
                .eraseToAnyPublisher()
        }
        
        if let cachedData = loadedData[url.absoluteString] as? T {
            return Just(cachedData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                try self.tryHandleResponse(response, data: data)
            }
            .handleEvents(receiveOutput: { [weak self] decodedData in
                self?.loadedData[url.absoluteString] = decodedData
            })
            .eraseToAnyPublisher()
    }
    
    func fetchData<T: Decodable>(for request: URLRequest?) -> AnyPublisher<T, Error> {
        guard let request = request else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        
        if let cachedData = loadedData[request.url?.absoluteString ?? ""] as? T {
            return Just(cachedData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                try self.tryHandleResponse(response, data: data)
            }
            .handleEvents(receiveOutput: { [weak self] decodedData in
                self?.loadedData[request.url?.absoluteString ?? ""] = decodedData
            })
            .eraseToAnyPublisher()
    }
    
    func postData(request: URLRequest?) -> AnyPublisher<Void, Error> {
        guard let request = request else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request as URLRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                if (200..<300).contains(httpResponse.statusCode) {
                    return ()
                } else {
                    throw NetworkError.requestError(errorCode: httpResponse.statusCode)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

private extension NetworkLoadService {
    func tryHandleResponse<T: Decodable>(_ response: URLResponse, data: Data) throws -> T {
        try tryCheckResponse(response: response)
        let decodeData: T = try decodeData(data: data)
        return decodeData
    }
}
