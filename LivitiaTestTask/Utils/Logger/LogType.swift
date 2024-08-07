//
//  LogType.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

enum LogType: String {
    case none
    case error
    case warning
    case success
    case action
    case canceled
}

extension LogType {
    var typeIdentifier: String {
        switch self {
        case .none: "⚪️"
        case .error: "🔴 Error:"
        case .warning: "🟠 Warning:"
        case .success: "🟢 Success:"
        case .action: "🔵 Action:"
        case .canceled: "🟣 Cancelled:"
        }
    }
}
