//
//  LostService.swift
//  AnimalInfo
//
//  Created by  on 2021/8/24.
//

import UIKit
import Moya

enum LostService {
    case getLost
}

extension LostService: TargetType {

    var baseURL: URL {
        return URL(string: "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=IFJomqVzyB0i")!
    }

    var path: String {
        switch self {
        case .getLost:
            return ""
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return nil
    }
}

