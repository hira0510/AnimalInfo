//
//  AnimalInfoStoryBoardExtension.swift
//  AnimalInfo
//
//  Created by  on 2021/8/24.
//

import UIKit

extension UIStoryboard {
    
    /// 載入TabController
    ///
    /// - Returns:  回傳MainTabController
    static func loadAnimalInfoMainTabController() -> AnimalInfoMainTabController {
        let vc = UIStoryboard(name: "AnimalInfo", bundle: nil).instantiateViewController(withIdentifier: "AnimalInfoMainTabController") as! AnimalInfoMainTabController
        return vc
    }
    
    /// 載入web頁
    ///
    /// - Returns:  回傳AnimalInfoWebViewController
    static func loadAnimalInfoWebViewController() -> AnimalInfoWebViewController {
        let vc = UIStoryboard.init(name: "AnimalInfo", bundle: nil).instantiateViewController(withIdentifier: "AnimalInfoWebViewController") as! AnimalInfoWebViewController
        return vc
    }
    
    /// 載入Adopt資訊頁
    ///
    /// - Returns:  回傳AdoptInfoViewController
    static func loadAdoptInfoViewController(model: AdoptModel) -> AdoptInfoViewController {
        let vc = UIStoryboard.init(name: "Adopt", bundle: nil).instantiateViewController(withIdentifier: "AdoptInfoViewController") as! AdoptInfoViewController
        vc.hidesBottomBarWhenPushed = true
        vc.adoptModel = model
        return vc
    }
    
    /// 載入Lost資訊頁
    ///
    /// - Returns:  回傳LostInfoViewController
    static func loadLostInfoViewController(model: LostModel) -> LostInfoViewController {
        let vc = UIStoryboard.init(name: "Lost", bundle: nil).instantiateViewController(withIdentifier: "LostInfoViewController") as! LostInfoViewController
        vc.hidesBottomBarWhenPushed = true
        vc.lostModel = model
        return vc
    }
    
    /// 載入Animal資訊頁
    ///
    /// - Returns:  回傳AnimalMainInfoViewController
    static func loadAnimalMainInfoViewController(model: AnimalModel) -> AnimalMainInfoViewController {
        let vc = UIStoryboard.init(name: "Animal", bundle: nil).instantiateViewController(withIdentifier: "AnimalMainInfoViewController") as! AnimalMainInfoViewController
        vc.hidesBottomBarWhenPushed = true
        vc.animalModel = model
        return vc
    }
    
    /// 載入收藏頁
    ///
    /// - Returns:  回傳FavoriteViewController
    static func loadFavoriteViewController(favorType: FavoriteType) -> FavoriteViewController {
        let vc = UIStoryboard.init(name: "Favorite", bundle: nil).instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
        vc.favorType = favorType
        return vc
    }
}

extension String {

    /// 是否包含字串
    ///
    /// - Parameter find: 要找的文字陣列
    /// - Returns: 回傳文字
    func contains(strArray: [String]) -> Bool {
        for str in strArray {
            if self.contains(str) {
                return true
            }
        }
        return false
    }
}

