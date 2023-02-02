//
//  AnimalMainInfoViewModel.swift
//  AnimalInfo
//
//  Created by  on 2021/8/26.
//

import UIKit

enum AnimalMainInfoSection {
    case image
    case info
    case sub1
    case sub2
    case sub3
}

class AnimalMainInfoViewModel: AnimalInfoBaseViewModel {
    public var tableViewSection: [AnimalMainInfoSection] = [
        .image,
        .info,
        .sub1,
        .sub2,
        .sub3
    ]
}
