//
//  Post.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

struct PostData: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
