//
//  DataHandler.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

protocol DataHandler {
    var decoder: JSONDecoder { get }
    var encoder: JSONEncoder { get }
    func decodeData<T: Decodable>(data: Data) throws -> T
    func encodeData<T: Encodable>(data: T) throws -> Data
}

extension DataHandler {
    func decodeData<T: Decodable>(data: Data) throws -> T {
        do {
            if data.isEmpty {
                Logger.printLog("Decodable data is empty", place: .service(serviceType: "\(self)"), type: .error)
                throw DataHandlerError.emptyData
            }
            
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            Logger.printLog("Throw \(error) while decode", place: .service(serviceType: "\(self)"), type: .error)
            throw DataHandlerError.invalidData
        }
    }
    
    func encodeData<T: Encodable>(data: T) throws -> Data {
        do {
            let encodedData = try encoder.encode(data)
            if encodedData.isEmpty {
                throw DataHandlerError.emptyData
            }
            return encodedData
        } catch {
            throw DataHandlerError.invalidData
        }
    }
}
