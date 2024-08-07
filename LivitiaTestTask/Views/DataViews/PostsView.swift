//
//  PostsView.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import SwiftUI

struct PostsView: View {
    @StateObject private var viewModel: PostsViewModel = .init()
    private var onOpenComment: ((Int) -> Void)?
    
    init(userId: Int = 1, onOpenComment: ((Int) -> Void)? = nil) {
        self.onOpenComment = onOpenComment
        self._viewModel = StateObject(wrappedValue:  .init(userId))
    }
    
    var body: some View {
        contentView()
    }
}

private extension PostsView {
    func contentView() -> some View {
        VStack {
            switch viewModel.state {
            case .ready: dataListView()
            default: LoadingView()
            }
            
            Spacer()
        }
    }
    
    func dataListView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.posts) { post in
                DetailsView(title: post.title, message: post.body) {
                    onOpenComment?(post.id)
                }
            }
        }
    }
}
