//
//  PostView.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import SwiftUI

struct DetailsView: View {
    let title: String
    var message: String? = nil
    var onClick: (() -> Void)? = nil
    
    private let horizontalOffset: CGFloat = 10
    
    var body: some View {
        VStack {
            Button {
                onClick?()
            } label: {
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Group {
                        Text(title)
                            .font(.title3)
                            .lineLimit(1)
                        
                        if let message = message {
                            Text(message)
                                .font(.subheadline)
                                .lineLimit(2)
                                .opacity(0.8)
                        }
                    }
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, horizontalOffset)
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(.black)
                        .frame(height: 1)
                        .padding(.leading, horizontalOffset)
                }
                .foregroundStyle(.white)
            }
        }
    }
}
