//
//  AdoptApi.swift
//  AnimalInfo
//
//  Created by  on 2021/8/24.
//

import UIKit
import Moya
import ObjectMapper
import RxSwift

class AdoptApi {
    private let mainQueue = MainScheduler.instance
    private let backQueue = SerialDispatchQueueScheduler.init(qos: .background)
    private let provider = MoyaProvider<AdoptService>()
    
    /// 請求AdoptModelAPi
    ///
    /// - Returns: 回傳AdoptModel物件
    func fetchDataAdopt() -> Observable<[AdoptModel]> {
        return provider.rx.request(.getAdopt).asObservable().mapArray(AdoptModel.self).subscribeOn(backQueue).observeOn(mainQueue)
    }
}
