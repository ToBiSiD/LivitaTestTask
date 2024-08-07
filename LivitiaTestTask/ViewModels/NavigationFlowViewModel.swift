//
//  NavigationFlowViewModel.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

final class NavigationFlowViewModel: ObservableObject {
    @Published private(set) var viewTab: ViewTab = .posts(user: 1) { didSet { updateViewTab() } }
    @Published var title: String = ""
    
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
            viewTab = .posts(user: currentUserId)
        }
    }
    
    func openUserTab() {
        viewTab = .user(id: currentUserId)
    }
    
    func onChangeUser(_ newId: Int) {
        viewTab = .posts(user: newId)
    }
    
    func onOpenComment(for postId: Int) {
        viewTab = .comments(post: postId)
    }
}

private extension NavigationFlowViewModel {
    func updateViewTab() {
        switch viewTab {
        case .posts(_):
            title = viewTab.defaultTitle
        case .user(let id):
            currentUserId = id
        default: return
        }
    }
}
