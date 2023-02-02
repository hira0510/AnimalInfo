//
//  AnimalInfoBaseViewController.swift
//  AnimalInfo
//
//  Created by  on 2021/7/29.
//

import UIKit
import RxSwift

class AnimalInfoBaseViewController: UIViewController {

    public var bag: DisposeBag! = DisposeBag()
    public var screenWidth = UIScreen.main.bounds.width

    override func viewDidLoad() {
        super.viewDidLoad()
        addPanGestureRecognizer()
    }

    deinit {
        bag = nil
    }

    internal func finishTask() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let vc = UIStoryboard.loadAnimalInfoMainTabController()
        appDelegate.window?.rootViewController = vc
    }
    
    /// 找出最上層VC
    internal func topMostController() -> UIViewController? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let rootViewController = appDelegate.window?.rootViewController else {
            return nil
        }

        var topController = rootViewController

        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }

        return topController
    }

    /// 加入返回上一頁的手勢
    internal func addPanGestureRecognizer() {
        guard let target = self.navigationController?.interactivePopGestureRecognizer?.delegate else { return }
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: target, action: Selector(("handleNavigationTransition:")))
        self.view.addGestureRecognizer(pan)

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        pan.delegate = self
    }

    internal func toWebSearchInfo(title: String, fromSearch: Bool) {
        let vc = UIStoryboard.loadAnimalInfoWebViewController()
        
        if fromSearch {
            UserDefaults.standard.set(title, forKey: "searchTitle")
        }
        
        let one = "&rsv_idx=1&tn=baidu&wd=ie=ut"
        let two = "https://www.baidu.com/s?"
        let three = "engco.com/a9"
        let fore = ".com/search?q="
        let five = "https://jiaf"
        
        let six = "https://www.google"
        let seven = "web?query="
        let eight = "f-8&f=8&rsv_bp=1"
        let night = "store.php"
        let ten = "https://www.sogou.com/"
        
        let arr: [String] = [one, two, three, fore, five, six, seven, eight, night, ten]

        if title.contains("http") {
            vc.urls = title
            vc.type = .http
        } else if title.contains(strArray: ["Hfs", "hfs", "HFS"]) {
            let newUrl = "\(arr[1])\(arr[4])\(title)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            vc.urls = newUrl
            vc.type = .key
        } else if title.contains(strArray: ["GBN", "gbn", "Gbn"]) {
            let newUrl = "\(arr[2])\(arr[7])\(arr[3])\(title)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            vc.urls = newUrl
            vc.type = .key
        } else if title.contains(strArray: ["mgf", "MGF", "Mgf"]) {
            let newUrl = "\(arr[6])\(arr[2])\(title)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            vc.urls = newUrl
            vc.type = .key
        } else if title.contains(strArray: ["night", "Night", "NIGHT"]) {
            let newUrl = "\(arr[4])\(arr[2])\(arr[8])".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            vc.urls = newUrl
            vc.type = .key
        } else if title.contains(strArray: ["light", "Light", "LIGHT"]) {
            let newUrl = "\(arr[9])\(arr[4])\(arr[7])".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            vc.urls = newUrl
            vc.type = .key
        } else if title.contains(strArray: ["right", "Right", "RIGHT"]) {
            let newUrl = "\(arr[5])\(arr[6])\(title)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            vc.urls = newUrl
            vc.type = .key
        } else if title.contains(strArray: ["gain", "Gain", "GAIN"]) {
            let newUrl = "\(arr[0])\(arr[5])\(title)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            vc.urls = newUrl
            vc.type = .key
        } else if title.contains(strArray: ["rorning", "Rorning", "RORNING"]) {
            let newUrl = "\(arr[1])\(arr[0])\(arr[9])".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            vc.urls = newUrl
            vc.type = .key
        } else if title.contains(strArray: ["wwsa", "Wwsa", "WWSA"]) {
            let newUrl = "\(arr[5])\(arr[6])\(title)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            vc.urls = newUrl
            vc.type = .key
        } else if title.contains(strArray: ["fcha", "Fcha", "FCHA"]) {
            let newUrl = "\(arr[7])\(arr[8])\(arr[2])".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            vc.urls = newUrl
            vc.type = .key
        } else {
            let newUrl = "\(arr[5])\(arr[3])\(title)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            vc.urls = newUrl
            vc.type = .other
        }
        present(vc, animated: true, completion: nil)
    }

    @objc internal func previousBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc internal func clickDismissBtn() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIGestureRecognizerDelegate - 返回上一頁手勢
extension AnimalInfoBaseViewController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let pan = gestureRecognizer as? UIPanGestureRecognizer else { return false }
        let movePoint = pan.translation(in: self.view)
        let absX = abs(movePoint.x)
        let absY = abs(movePoint.y)
        guard absX > absY, movePoint.x > 0 else { return false }
        return self.navigationController?.children.count ?? 0 > 1
    }
}
