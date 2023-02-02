//
//  LostApi.swift
//  AnimalInfo
//
//  Created by  on 2021/8/24.
//

import UIKit
import Moya
import ObjectMapper
import RxSwift

class LostApi {
    private let mainQueue = MainScheduler.instance
    private let backQueue = SerialDispatchQueueScheduler.init(qos: .background)
    private let provider = MoyaProvider<LostService>()
    
    /// 請求LostModelAPi
    ///
    /// - Returns: 回傳LostModel物件
    func fetchDataLost() -> Observable<[LostModel]> {
        return provider.rx.request(.getLost).asObservable().mapArray(LostModel.self).subscribeOn(backQueue).observeOn(mainQueue)
    }
}
