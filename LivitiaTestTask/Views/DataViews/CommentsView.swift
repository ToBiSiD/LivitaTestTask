//
//  CommentsView.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import SwiftUI

struct CommentsView: View {
    @StateObject private var viewModel: CommentsViewModel = .init()
    
    init(postId: Int = 1) {
        self._viewModel = StateObject(wrappedValue:  .init(postId))
    }
    
    var body: some View {
        contentView()
    }
}

private extension CommentsView {
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
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.comments) { comment in
                    DetailsView(title: comment.email, message: comment.body)
                }
            }
        }
    }
}
