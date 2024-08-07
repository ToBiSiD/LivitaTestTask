//
//  NavBarView.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import SwiftUI

struct NavBarView: View {
    @StateObject private var navViewModel: NavigationFlowViewModel
    
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
            
            Text(navViewModel.title)
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
}
