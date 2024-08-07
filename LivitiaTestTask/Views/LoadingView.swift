//
//  LoadingView.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        LoadingCircleView(componentsNumber: 7, duration: 2)
            .foregroundStyle(Color(.systemGray2))
            .padding(30)
    }
}

