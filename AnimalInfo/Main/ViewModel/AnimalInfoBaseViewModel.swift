//
//  AnimalInfoBaseViewModel.swift
//  AnimalInfo
//
//  Created by  on 2021/7/29.
//

import UIKit
import RxCocoa
import RxSwift

enum AnimalInfoType {
    case adopt
    case lost
    case animal
}

class AnimalInfoBaseViewModel: NSObject {
    
    public let adoptApi = AdoptApi()
    public let lostApi = LostApi()
    public let animalApi = AnimalApi()
    
}
