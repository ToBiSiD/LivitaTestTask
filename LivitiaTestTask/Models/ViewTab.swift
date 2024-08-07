//
//  ViewTab.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

enum ViewTab {
    case posts(user: Int = 1)
    case comments(post: Int)
    case user(id: Int)
    
    var showBackButton: Bool {
        switch self {
        case .posts(_): false
        default: true
        }
    }
    
    var showUserButton: Bool {
        switch self {
        case .posts(_): true
        default: false
        }
    }
    
    var defaultTitle: String {
        switch self {
        case .posts(_): "Posts"
        case .comments(_): "Comments"
        case .user(_): "Unknown"
        }
    }
}
