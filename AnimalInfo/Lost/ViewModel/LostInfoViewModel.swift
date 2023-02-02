//
//  LostInfoViewModel.swift
//  AnimalInfo
//
//  Created by  on 2021/8/26.
//

import UIKit

enum LostInfoSection {
    case image
    case info
    case sub1
    case sub2
    case sub3
    case sub4
}

class LostInfoViewModel: AnimalInfoBaseViewModel {
    public var tableViewSection: [LostInfoSection] = [
        .image,
        .info,
        .sub1,
        .sub2,
        .sub3,
        .sub4
    ]
}
