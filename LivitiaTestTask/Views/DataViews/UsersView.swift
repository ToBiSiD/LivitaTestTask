//
//  UsersView.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import SwiftUI

struct UsersView: View {
    @StateObject private var viewModel: UsersViewModel = .init()
    private var onChangeUser: ((Int) -> Void)?
    
    init(onChangeUser: ((Int) -> Void)?) {
        self.onChangeUser = onChangeUser
        self._viewModel = StateObject(wrappedValue:  .init())
    }
    
    var body: some View {
        contentView()
    }
}

private extension UsersView {
    func contentView() -> some View {
        VStack {
            switch viewModel.state {
            case .ready: usersListView()
            default: LoadingView()
            }
            
            Spacer()
        }
    }
    
    func usersListView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.users) { user in
                DetailsView(title: user.printableName) {
                    onChangeUser?(user.id)
                }
                    .frame(height: 80)
            }
        }
    }
}
