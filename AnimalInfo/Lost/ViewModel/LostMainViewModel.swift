//
//  LostMainViewModel.swift
//  AnimalInfo
//
//  Created by  on 2021/8/26.
//

import RxCocoa
import RxSwift
import Foundation

enum LostCollectionSection {
    case search
    case banner
    case filter
    case info
}

class LostMainViewModel: AnimalInfoBaseViewModel {

    internal var lostSequence = BehaviorRelay<[LostModel]>(value: [])
    internal var catSequence: [LostModel] = []
    internal var dogSequence: [LostModel] = []
    internal var searchSequence: [LostModel] = []
    internal var selectType: selectType = .all
    internal var oldSelectType: selectType = .all
    internal var collectionSection: [LostCollectionSection] = [
            .search,
            .banner,
            .filter,
            .info
    ]

    func requestLostData() -> Observable<Bool> {
        return lostApi.fetchDataLost().flatMap { (object) -> Observable<Bool> in
            guard object.count > 0 else { return Observable.just(false) }
            let model: [LostModel] = object
            let data: [LostModel] = model.filter { $0.albumFile != "" && URL(string: $0.albumFile) != nil } + model.filter { $0.albumFile == "" }
            for adopt in data {
                if adopt.kind.contains(find: "貓") {
                    self.catSequence.append(adopt)
                } else {
                    self.dogSequence.append(adopt)
                }
            }
            self.lostSequence.accept(data)
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

    func filterData() -> [LostModel] {
        switch selectType {
        case .all:
            return lostSequence.value
        case .cat:
            return catSequence
        case .dog:
            return dogSequence
        case .search:
            return searchSequence
        }
    }
}
