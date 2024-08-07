//
//  DataHandlerError.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

enum DataHandlerError: LocalizedError {
    case invalidData
    case emptyData
    
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return NSLocalizedString("Invalid data.", comment: "")
        case .emptyData:
            return NSLocalizedString("Empty data.", comment: "")
        }
    }
}
