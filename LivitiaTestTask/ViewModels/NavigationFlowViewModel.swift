//
//  NavigationFlowViewModel.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

final class NavigationFlowViewModel: ObservableObject {
    @Published private(set) var viewTab: ViewTab = .posts(user: 1)
    private(set) var currentUserId: Int = 1
    
    init() {
        currentUserId = 1
        viewTab = .posts(user: currentUserId)
    }
}

extension NavigationFlowViewModel {
    func cancelCurrentTab() {
        switch viewTab {
        case .posts(_): 
            return
        default:
            viewTab = .posts(user: currentUserId)
        }
    }
    
    func openUserTab() {
        viewTab = .user(id: currentUserId)
    }
    
    func onChangeUser(_ newId: Int) {
        currentUserId = newId
        viewTab = .posts(user: newId)
    }
    
    func onOpenComment(for postId: Int) {
        viewTab = .comments(post: postId)
    }
}
