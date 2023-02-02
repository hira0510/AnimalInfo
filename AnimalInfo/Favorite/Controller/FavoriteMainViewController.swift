//
//  FavoriteMainViewController.swift
//  AnimalInfo
//
//  Created by  on 2021/8/24.
//

import UIKit

class FavoriteMainViewController: AnimalInfoBaseViewController {

    @IBOutlet weak var bgView: UIView!
    
    public var pageMenu: CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMenu()
    }

    // MARK: - 私有

    private func setupMenu() {

        var controllerArray: [UIViewController] = []

        let vc1 = UIStoryboard.loadFavoriteViewController(favorType: .adopt)
        vc1.title = "领养"
        controllerArray.append(vc1)

        let vc2 = UIStoryboard.loadFavoriteViewController(favorType: .lost)
        vc2.title = "走失"
        controllerArray.append(vc2)

        let vc3 = UIStoryboard.loadFavoriteViewController(favorType: .animal)
        vc3.title = "小知识"
        controllerArray.append(vc3)

        let parameters: [CAPSPageMenuOption] = [
                .scrollMenuBackgroundColor(UIColor.clear),
                .viewBackgroundColor(UIColor.clear),
                .bottomMenuHairlineColor(UIColor.clear),
                .selectionIndicatorColor(#colorLiteral(red: 0.2705882353, green: 0.9882352941, blue: 0.8196078431, alpha: 1)),
                .selectionIndicatorHeight(3),
                .menuMargin(0.0),
                .menuHeight(42.0),
                .menuItemWidth(self.screenWidth / 3),
                .menuItemFont(UIFont(name: "PingFangTC-Medium", size: 19)!),
                .selectedMenuItemLabelColor(#colorLiteral(red: 0.2705882353, green: 0.9882352941, blue: 0.8196078431, alpha: 1)),
                .unselectedMenuItemLabelColor(#colorLiteral(red: 0.3176470588, green: 0.7137254902, blue: 0.8196078431, alpha: 1)),
                .useMenuLikeSegmentedControl(false),
                .centerMenuItems(true),
                .menuItemSeparatorWidth(0.0),
                .menuItemSeparatorPercentageHeight(0.0),
                .isHiddenMenuItemSeparator(true)
        ]
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 0, width: self.bgView.frame.width, height: self.bgView.frame.height), pageMenuOptions: parameters)

        pageMenu?.delegate = self
        self.addChild(pageMenu!)
        self.bgView.addSubview(pageMenu!.view)
        pageMenu?.didMove(toParent: self)
    }
}

// MARK: - CAPSPageMenuDelegate
extension AnimalInfoBaseViewController: CAPSPageMenuDelegate {
    func didSelectIndex(index: Int) {

    }
}
