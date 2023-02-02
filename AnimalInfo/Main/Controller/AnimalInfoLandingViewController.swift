//
//  AnimalInfoLandingViewController.swift
//  AnimalInfo
//
//  Created by  on 2021/7/29.
//

import UIKit

class AnimalInfoLandingViewController: AnimalInfoBaseViewController {

    @IBOutlet var views: AnimalInfoLandingViews!
    private let viewModel = AnimalInfoLandingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let alert = viewModel.versionUpdate(), let vc = topMostController() {
            DispatchQueue.main.async() {
                vc.present(alert, animated: true, completion: nil)
            }
        } else {
            let mAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            mAnimation.byValue = -Double.pi / 3
            mAnimation.duration = 0.5
            mAnimation.repeatCount = 10
            mAnimation.isRemovedOnCompletion = false
            mAnimation.autoreverses = true
            mAnimation.fillMode = .both
            views.loadingImageView.layer.add(mAnimation, forKey: "rotation_z")
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let `self` = self else { return }
                self.views.mImageView.layer.removeAllAnimations()
                self.finishTask()
            }
        }
    }
}
