//
//  AnimalMainViewController.swift
//  AnimalInfo
//
//  Created by  on 2021/8/24.
//

import UIKit

class AnimalMainViewController: AnimalInfoBaseViewController {
    
    @IBOutlet var views: AnimalMainViews!
    private let viewModel = AnimalMainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        requestAnimalDataToObject()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if let collection = self.views.mCollectionView {
            collection.reloadSections(IndexSet(integer: 0))
        }
    }
    
    private func requestAnimalDataToObject() {
        viewModel.requestAnimalData().subscribe(onNext: { [weak self] (result) in
            guard let `self` = self, result else { return }
            self.views.mCollectionView.reloadData()
        }).disposed(by: bag)
    }
    
    private func setupCollection() {
        views.mCollectionView.dataSource = self
        views.mCollectionView.delegate = self
        views.mCollectionView.register(AnimalInfoSearchCell.nib, forCellWithReuseIdentifier: "AnimalInfoSearchCell")
        views.mCollectionView.register(AnimalInfoBannerTYCycleMianCell.nib, forCellWithReuseIdentifier: "AnimalInfoBannerTYCycleMianCell")
        views.mCollectionView.register(AnimalInfoFilterMainCell.nib, forCellWithReuseIdentifier: "AnimalInfoFilterMainCell")
        views.mCollectionView.register(AnimalMainCell.nib, forCellWithReuseIdentifier: "AnimalMainCell")
        views.toTopButton.addTarget(self, action: #selector(didClickToTop), for: .touchUpInside)
    }
    
    /// 隱藏鍵盤
    @objc private func didClickView() {
        if let cell = self.views.mCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? AnimalInfoSearchCell {
            cell.searchTextField.resignFirstResponder()
        }
    }
    
    @objc private func didClickToTop() {
        self.views.mCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
}

// MARK: - UICollectionViewDelegate
extension AnimalMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.collectionSection.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.collectionSection[section]
        switch section {
        case .search, .banner, .filter: return 1
        case .info:
            let model = viewModel.filterData()
            return model.count > 0 ? model.count : 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sections = viewModel.collectionSection[indexPath.section]
        switch sections {
        case .search:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalInfoSearchCell", for: indexPath) as! AnimalInfoSearchCell
            cell.delegate = self
            cell.historyCollectionView.reloadData()
            return cell
        case .banner:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalInfoBannerTYCycleMianCell", for: indexPath) as! AnimalInfoBannerTYCycleMianCell
            let model = viewModel.filterData()
            cell.configAnimal(vc: self, banners: model)
            return cell
        case .filter:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalInfoFilterMainCell", for: indexPath) as! AnimalInfoFilterMainCell
            cell.config(text: ["全部"])
            cell.delegate = self
            return cell
        case .info:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalMainCell", for: indexPath) as! AnimalMainCell
            let model = viewModel.filterData()[indexPath.item]
            cell.config(model: model)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sections = viewModel.collectionSection[indexPath.section]

        if let cell = self.views.mCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? AnimalInfoSearchCell {
            cell.searchTextField.resignFirstResponder()
        }

        switch sections {
        case .search, .banner, .filter: break
        case .info:
            let model = viewModel.filterData()[indexPath.item]
            let vc = UIStoryboard.loadAnimalMainInfoViewController(model: model)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sections = viewModel.collectionSection[indexPath.section]
        switch sections {
        case .search:
            return CGSize(width: screenWidth, height: 90)
        case .banner:
            return CGSize(width: screenWidth, height: 180)
        case .filter:
            return CGSize(width: screenWidth, height: 40)
        case .info:
            return CGSize(width: GlobalUtil.calculateWidthScaleWithSize(width: 170), height: GlobalUtil.calculateWidthScaleWithSize(width: 230))
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let section = viewModel.collectionSection[section]
        switch section {
        case .search:
            return UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 0)
        case .banner:
            return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        case .filter:
            return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        case .info:
            return UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didClickView()
    }
}

// MARK: - AnimalInfoSearchCellProtocol
extension AnimalMainViewController: AnimalInfoSearchCellProtocol {

    func search(title: String) {
        viewModel.search(title: title)
        if viewModel.searchSequence.isEmpty && title != "" {
            toWebSearchInfo(title: title, fromSearch: true)
            viewModel.selectType = .all
        } else if title == "" {
            viewModel.selectType = .all
        }
        views.mCollectionView.reloadData()
    }
}

// MARK: - AnimalInfoSearchCellProtocol
extension AnimalMainViewController: AnimalInfoFilterMainCellProtocol {
    func clickType(index: Int) {
        viewModel.selectType = .all
        views.mCollectionView.reloadData()
    }
}
