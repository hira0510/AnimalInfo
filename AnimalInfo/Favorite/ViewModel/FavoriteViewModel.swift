//
//  FavoriteViewModel.swift
//  AnimalInfo
//
//  Created by  on 2021/8/27.
//

import UIKit

class FavoriteViewModel: AnimalInfoBaseViewModel {
    
    internal var adoptModel: [AdoptModel] = []
    internal var lostModel: [LostModel] = []
    internal var animalModel: [AnimalModel] = []
    internal let adoptSqlite = AdoptSQLite()
    internal let lostSqlite = LostSQLite()
    internal let animalSqlite = AnimalSQLite()
}
