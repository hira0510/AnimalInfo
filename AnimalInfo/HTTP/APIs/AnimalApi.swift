//
//  AnimalApi.swift
//  AnimalInfo
//
//  Created by  on 2021/8/24.
//

import UIKit
import Moya
import ObjectMapper
import RxSwift

class AnimalApi {
    private let mainQueue = MainScheduler.instance
    private let backQueue = SerialDispatchQueueScheduler.init(qos: .background)
    private let provider = MoyaProvider<AnimalService>()
    
    /// 請求AnimalModelAPi
    ///
    /// - Returns: 回傳LostModel物件
    func fetchDataAnimal() -> Observable<ZooModel> {
        return provider.rx.request(.getAnimal).asObservable().mapObject(ZooModel.self).subscribeOn(backQueue).observeOn(mainQueue)
    }
}
