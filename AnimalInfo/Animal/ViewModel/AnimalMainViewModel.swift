//
//  AnimalMainViewModel.swift
//  AnimalInfo
//
//  Created by  on 2021/8/26.
//

import RxCocoa
import RxSwift
import Foundation

enum AnimalCollectionSection {
    case search
    case banner
    case filter
    case info
}

class AnimalMainViewModel: AnimalInfoBaseViewModel {

    internal var animalSequence = BehaviorRelay<[AnimalModel]>(value: [])
    internal var searchSequence: [AnimalModel] = []
    internal var selectType: selectType = .all
    internal var collectionSection: [AnimalCollectionSection] = [
            .search,
            .banner,
            .filter,
            .info
    ]

    func requestAnimalData() -> Observable<Bool> {
        return animalApi.fetchDataAnimal().flatMap { (object) -> Observable<Bool> in
            guard let model = object.result, model.results.count > 0 else { return Observable.just(false) }
            self.animalSequence.accept(model.results)
            return Observable.just(true)
        }
    }

    func search(title: String) {
        guard title != "" else {
            searchSequence = []
            return
        }

        let title2 = title.big5
        let model = filterData()
        searchSequence = []
        selectType = .search

        for v in model {
            if v.chName.contains(title) || v.chName.contains(title2) || v.feature.contains(title) || v.feature.contains(title2) {
                searchSequence.append(v)
            }
        }
    }

    func filterData() -> [AnimalModel] {
        switch selectType {
        case .all:
            return animalSequence.value
        default:
            return searchSequence
        }
    }
}
