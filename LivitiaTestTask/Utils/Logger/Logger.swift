//
//  Logger.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

struct Logger {
    static var isEnabled: Bool = true
    
    static func printLog(_ items: Any..., place: LogPlace = .none, type: LogType = .none) {
        if !isEnabled {
            return
        }
        
        let info: String = place.title + type.typeIdentifier
        print("\(info)", items)
    }
}

extension Logger {
    static func testPrint() {
        printLog("Success", type: .success)
        printLog("Action", type: .action)
        printLog("Canceled", type: .canceled)
        printLog("Error", type: .error)
        printLog("Warning", type: .warning)
        printLog("None", type: .none)
    }
}
