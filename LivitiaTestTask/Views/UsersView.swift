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
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.users) { user in
                    DetailsView(title: user.printableName) {
                        onChangeUser?(user.id)
                    }
                        .frame(height: 80)
                }
            }
            
            Spacer()
        }
    }
}
