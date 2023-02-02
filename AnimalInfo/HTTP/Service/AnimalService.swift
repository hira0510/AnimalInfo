//
//  AnimalService.swift
//  AnimalInfo
//
//  Created by  on 2021/8/24.
//

import UIKit
import Moya

enum AnimalService {
    case getAnimal
}

extension AnimalService: TargetType {

    var baseURL: URL {
        return URL(string: "https://data.taipei/api/v1/dataset/a3e2b221-75e0-45c1-8f97-75acbd43d613?scope=resourceAquire")!
    }

    var path: String {
        switch self {
        case .getAnimal:
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
