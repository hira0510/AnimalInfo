//
//  LostModel.swift
//  AnimalInfo
//
//  Created by  on 2021/8/24.
//

import UIKit
import ObjectMapper

class LostModel: Mappable {

    var subid: String = ""
    var kind: String = ""
    var sex: String = ""
    var bodyType: String = ""
    var colour: String = ""
    var remark: String = ""
    var openDate: String = ""
    var name: String = ""
    var albumFile: String = ""
    var address: String = ""
    var tel: String = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        subid <- map["晶片號碼"]
        kind <- map["寵物別"]
        sex <- map["性別"]
        bodyType <- map["品種"]
        colour <- map["毛色"]
        remark <- map["特徵"]
        openDate <- map["遺失時間"]
        name <- map["寵物名"]
        albumFile <- map["PICTURE"]
        address <- map["遺失地點"]
        tel <- map["連絡電話"]
    }
}
