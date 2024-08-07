//
//  NavBarView.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import SwiftUI

struct NavBarView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var navViewModel: NavigationFlowViewModel
    
    @FetchRequest(
        entity: UserEntity.entity(),
        sortDescriptors: [],
        animation: .default
    )
    private var users: FetchedResults<UserEntity>
    
    @FetchRequest(
        entity: CommentEntity.entity(),
        sortDescriptors: [],
        animation: .default
    )
    private var comments: FetchedResults<CommentEntity>
    
    
    init(vm: NavigationFlowViewModel) {
        self._navViewModel = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        contentView()
    }
}


private extension NavBarView {
    func contentView() -> some View {
        HStack {
            leadingView()
            bodyView()
            trailingView()
        }
        .frame(height: 70)
        .padding(.bottom, 10)
        .padding(.horizontal, 16)
        .foregroundStyle(.white)
        .background(Color.black)
    }
    
    func leadingView() -> some View {
        HStack {
            if navViewModel.viewTab.showBackButton {
                Button {
                    navViewModel.cancelCurrentTab()
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                }
            }
        }
    }
    
    func bodyView() -> some View {
        HStack {
            Spacer()
            
            Text(getTitle())
                .font(.system(size: 24).weight(.medium))
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .frame(height: 32)
            
            Spacer()
        }
    }
    
    func trailingView() -> some View {
        HStack {
            if navViewModel.viewTab.showUserButton {
                Button {
                    navViewModel.openUserTab()
                } label: {
                    Image(.userIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
    
    func getTitle() -> String {
        switch navViewModel.viewTab {
        case .posts(_): 
            return navViewModel.viewTab.defaultTitle
        case .comments(let postId):
            let postComments = comments.filter { $0.postId == Int64(postId) }
            return "Comments (\(postComments.count))"
        case .user(_):
            let user = users.filter { $0.id == Int64(navViewModel.currentUserId) }
            return user.first?.name ?? "Unknown"
        }
    }
}
