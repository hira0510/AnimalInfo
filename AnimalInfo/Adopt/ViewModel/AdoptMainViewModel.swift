//
//  AdoptMainViewModel.swift
//  AnimalInfo
//
//  Created by  on 2021/8/25.
//

import RxCocoa
import RxSwift
import Foundation

enum AdoptCollectionSection {
    case search
    case banner
    case filter
    case info
}

enum selectType {
    case all
    case cat
    case dog
    case search
}

class AdoptMainViewModel: AnimalInfoBaseViewModel {

    internal var adoptSequence = BehaviorRelay<[AdoptModel]>(value: [])
    internal var catSequence: [AdoptModel] = []
    internal var dogSequence: [AdoptModel] = []
    internal var searchSequence: [AdoptModel] = []
    internal var selectType: selectType = .all
    internal var oldSelectType: selectType = .all
    internal var collectionSection: [AdoptCollectionSection] = [
            .search,
            .banner,
            .filter,
            .info
    ]

    func requestAdoptData() -> Observable<Bool> {
        return adoptApi.fetchDataAdopt().flatMap { (object) -> Observable<Bool> in
            guard object.count > 0 else { return Observable.just(false) }
            let model: [AdoptModel] = object
            let data: [AdoptModel] = model.filter { $0.albumFile != "" } + model.filter { $0.albumFile == "" }
            for adopt in data {
                if adopt.kind.contains(find: "貓") {
                    self.catSequence.append(adopt)
                } else {
                    self.dogSequence.append(adopt)
                }
            }
            self.adoptSequence.accept(data)
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
            if v.address.contains(title) || v.address.contains(title2) || v.remark.contains(title) || v.remark.contains(title2) {
                searchSequence.append(v)
            }
        }
    }

    func filterData() -> [AdoptModel] {
        switch selectType {
        case .all:
            return adoptSequence.value
        case .cat:
            return catSequence
        case .dog:
            return dogSequence
        case .search:
            return searchSequence
        }
    }
}
