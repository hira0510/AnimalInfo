//
//  AnimalModel.swift
//  Animal2
//
//  Created by  on 2019/8/29.
//  Copyright © 2019 . All rights reserved.
//

import UIKit
import ObjectMapper

class AdoptModel: Mappable {

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
        subid <- map["animal_subid"]
        kind <- map["animal_kind"]
        sex <- map["animal_sex"]
        bodyType <- map["animal_bodytype"]
        colour <- map["animal_colour"]
        remark <- map["animal_remark"]
        openDate <- map["animal_opendate"]
        name <- map["shelter_name"]
        albumFile <- map["album_file"]
        address <- map["shelter_address"]
        tel <- map["shelter_tel"]
    }
}
