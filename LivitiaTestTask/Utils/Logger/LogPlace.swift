//
//  LogPlace.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

enum LogPlace {
    case none
    case coreData
    case service(serviceType: String)
    case viewModel(viewModel: String)
}

extension LogPlace {
    var title: String {
        switch self {
        case .none: ""
        case .coreData: "[CoreData] "
        case .service(let serviceType): "[Serice \(serviceType)] "
        case .viewModel(let viewModel): "[VM \(viewModel)] "
        }
    }
}
