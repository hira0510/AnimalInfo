//
//  AnimalModel.swift
//  AnimalInfo
//
//  Created by  on 2021/8/26.
//

import UIKit
import ObjectMapper

class ZooModel: Mappable {
    var result: ZooResultModel?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        result <- map["result"]
    }
}

class ZooResultModel: Mappable {
    var results: [AnimalModel] = []
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        results <- map["results"]
    }
}

class AnimalModel: Mappable {
    
    /// id
    var id: Int = 0
    /// 中文名
    var chName: String = ""
    /// 英文名
    var enName: String = ""
    /// 門
    var phylum: String = ""
    /// 剛
    var classs: String = ""
    /// 目
    var order: String = ""
    /// 科
    var family: String = ""
    /// 地點館
    var location: String = ""
    /// 特性
    var behavior: String = ""
    /// 特徵
    var feature: String = ""
    /// 飲食
    var diet: String = ""
    var image1: String = ""
    var image2: String = ""
    var image3: String = ""
    var image4: String = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["_id"]
        chName <- map["a_name_ch"]
        enName <- map["a_name_en"]
        phylum <- map["a_phylum"]
        classs <- map["a_class"]
        order <- map["a_order"]
        family <- map["a_family"]
        location <- map["a_location"]
        behavior <- map["a_behavior"]
        feature <- map["a_feature"]
        diet <- map["a_diet"]
        image1 <- map["a_pic01_url"]
        image2 <- map["a_pic02_url"]
        image3 <- map["a_pic03_url"]
        image4 <- map["a_pic04_url"]
    }
}
