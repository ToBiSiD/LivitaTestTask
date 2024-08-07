//
//  ContentView.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var navViewModel: NavigationFlowViewModel = .init()
    
    var body: some View {
        contentView()
    }
}

private extension ContentView {
    func contentView() -> some View {
        ZStack {
            Color.black
                .opacity(0.8)
                .ignoresSafeArea()
            
            VStack {
                headerView()
                bodyView()
            }
        }
    }
    
    func headerView() -> some View {
        NavBarView(vm: navViewModel)
    }
    
    func bodyView() -> some View {
        VStack {
            switch navViewModel.viewTab {
            case .posts(let userId):
                PostsView(
                    userId: userId,
                    onOpenComment: navViewModel.onOpenComment(for:)
                )
            case .comments(let postId): 
                CommentsView(postId: postId)
            case .user(let currentId): 
                UsersView(onChangeUser: navViewModel.onChangeUser(_:))
            }
        }
    }
}
