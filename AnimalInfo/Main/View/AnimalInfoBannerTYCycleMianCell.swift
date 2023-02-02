//
//  AnimalInfoBannerTYCycleMianCell.swift
//
//
//  Created by    on 
//  Copyright . All rights reserved.
//

import UIKit
import TYCyclePagerView

class AnimalInfoBannerTYCycleMianCell: UICollectionViewCell {

    @IBOutlet weak var mUIView: UIView!

    private var mController: AnimalInfoBaseViewController?

    private var pagerView: TYCyclePagerView!

    private var mBannersImg: [String] = []
    private var mBannersAdoptData: [AdoptModel] = []
    private var mBannersLostData: [LostModel] = []
    private var mBannersAnimalData: [AnimalModel] = []

    static var nib: UINib {
        return UINib(nibName: "AnimalInfoBannerTYCycleMianCell", bundle: Bundle(for: self))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.pagerView = TYCyclePagerView()
        self.pagerView.isInfiniteLoop = true
        self.pagerView.autoScrollInterval = 3.0
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        self.pagerView.register(AnimalInfoTYCycleCell.classForCoder(), forCellWithReuseIdentifier: "cellId")
        self.pagerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.mUIView.frame.height)
        mUIView.addSubview(self.pagerView)
    }

    public func configAdopt(vc: AnimalInfoBaseViewController, banners: [AdoptModel]) {
        mController = vc
        mBannersImg.removeAll()
        mBannersAdoptData.removeAll()
        
        for banner in banners.shuffled() {
            if mBannersImg.count < 5 && banner.albumFile != "" {
                mBannersImg.append(banner.albumFile)
                mBannersAdoptData.append(banner)
            }
        }
        loadData()
    }
    
    public func configLost(vc: AnimalInfoBaseViewController, banners: [LostModel]) {
        mController = vc
        mBannersImg.removeAll()
        mBannersAdoptData.removeAll()
        
        for banner in banners.shuffled() {
            if mBannersImg.count < 5 && banner.albumFile != "" && URL(string: banner.albumFile) != nil {
                mBannersImg.append(banner.albumFile)
                mBannersLostData.append(banner)
            }
        }
        loadData()
    }
    
    public func configAnimal(vc: AnimalInfoBaseViewController, banners: [AnimalModel]) {
        mController = vc
        mBannersImg.removeAll()
        mBannersAdoptData.removeAll()
        
        for banner in banners.shuffled() {
            if mBannersImg.count < 5 && banner.image1 != "" && URL(string: banner.image1) != nil {
                mBannersImg.append(banner.image1)
                mBannersAnimalData.append(banner)
            }
        }
        loadData()
    }

    private func loadData() {
        self.pagerView.reloadData()
        self.pagerView.layout.layoutType = .linear
        self.pagerView.setNeedUpdateLayout()
    }
}

// MARK: - TYCyclePagerViewDelegate
extension AnimalInfoBannerTYCycleMianCell: TYCyclePagerViewDelegate, TYCyclePagerViewDataSource {
    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        return mBannersImg.count
    }

    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellId", for: index) as! AnimalInfoTYCycleCell
        cell.addImage(url: mBannersImg[index])
        return cell
    }

    func layout(for pageView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let layout = TYCyclePagerViewLayout()
        layout.itemSize = CGSize(width: pagerView.frame.width * 0.8, height: pagerView.frame.height * 0.89)
        layout.itemSpacing = 8
        layout.itemHorizontalCenter = true

        return layout
    }

    func pagerView(_ pageView: TYCyclePagerView, didSelectedItemCell cell: UICollectionViewCell, at index: Int) {
        guard let parentVc = mController else { return }
        if mBannersAdoptData.count > 0 {
            let model: AdoptModel = mBannersAdoptData[index]
            let vc = UIStoryboard.loadAdoptInfoViewController(model: model)
            parentVc.navigationController?.pushViewController(vc, animated: true)
        } else if mBannersLostData.count > 0 {
            let model: LostModel = mBannersLostData[index]
            let vc = UIStoryboard.loadLostInfoViewController(model: model)
            parentVc.navigationController?.pushViewController(vc, animated: true)
        } else if mBannersAnimalData.count > 0 {
            let model: AnimalModel = mBannersAnimalData[index]
            let vc = UIStoryboard.loadAnimalMainInfoViewController(model: model)
            parentVc.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
