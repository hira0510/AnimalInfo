//
//  FavoriteViewController.swift
//  AnimalInfo
//
//  Created by  on 2020/6/1.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

enum FavoriteType {
    case adopt
    case lost
    case animal
}

class FavoriteViewController: AnimalInfoBaseViewController {

    @IBOutlet var views: FavoriteViews!
    
    public var favorType: FavoriteType = .adopt
    private let viewModel = FavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let _ = self.views.mCollectionView else { return }
        setData()
    }

    private func setupCollection() {        
        views.mCollectionView.dataSource = self
        views.mCollectionView.delegate = self
        views.mCollectionView.register(AnimalInfoBaseCell.nib, forCellWithReuseIdentifier: "AnimalInfoBaseCell")
        views.mCollectionView.register(AnimalMainCell.nib, forCellWithReuseIdentifier: "AnimalMainCell")
        setData()
    }
    
    private func setData() {
        switch favorType {
        case .adopt:
            let data = viewModel.adoptSqlite.readData()
            viewModel.adoptModel = data
            views.noDataLabel.isHidden = data.count > 0
        case .lost:
            let data = viewModel.lostSqlite.readData()
            viewModel.lostModel = data
            views.noDataLabel.isHidden = data.count > 0
        case .animal:
            let data = viewModel.animalSqlite.readData()
            viewModel.animalModel = data
            views.noDataLabel.isHidden = data.count > 0
        }
        views.mCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch favorType {
        case .adopt:
            return viewModel.adoptModel.count > 0 ? viewModel.adoptModel.count : 0
        case .lost:
            return viewModel.lostModel.count > 0 ? viewModel.lostModel.count : 0
        case .animal:
            return viewModel.animalModel.count > 0 ? viewModel.animalModel.count : 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch favorType {
        case .adopt:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalInfoBaseCell", for: indexPath) as! AnimalInfoBaseCell
            guard viewModel.adoptModel.count > indexPath.item else { return cell }
            cell.configAdoptCell(adopt: viewModel.adoptModel[indexPath.item])
            return cell
        case .lost:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalInfoBaseCell", for: indexPath) as! AnimalInfoBaseCell
            guard viewModel.lostModel.count > indexPath.item else { return cell }
            cell.configAdoptCell(adopt: nil, lost: viewModel.lostModel[indexPath.item])
            return cell
        case .animal:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalMainCell", for: indexPath) as! AnimalMainCell
            guard viewModel.animalModel.count > indexPath.item else { return cell }
            cell.config(model: viewModel.animalModel[indexPath.item])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch favorType {
        case .adopt:
            guard viewModel.adoptModel.count > indexPath.item else { return }
            let vc = UIStoryboard.loadAdoptInfoViewController(model: viewModel.adoptModel[indexPath.item])
            self.navigationController?.pushViewController(vc, animated: true)
        case .lost:
            guard viewModel.lostModel.count > indexPath.item else { return }
            let vc = UIStoryboard.loadLostInfoViewController(model: viewModel.lostModel[indexPath.item])
            self.navigationController?.pushViewController(vc, animated: true)
        case .animal:
            guard viewModel.animalModel.count > indexPath.item else { return }
            let vc = UIStoryboard.loadAnimalMainInfoViewController(model: viewModel.animalModel[indexPath.item])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch favorType {
        case .adopt:
            return CGSize(width: GlobalUtil.calculateWidthScaleWithSize(width: 100), height: GlobalUtil.calculateWidthScaleWithSize(width: 150))
        case .lost:
            return CGSize(width: GlobalUtil.calculateWidthScaleWithSize(width: 100), height: GlobalUtil.calculateWidthScaleWithSize(width: 150))
        case .animal:
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
        switch favorType {
        case .adopt, .lost:
            return UIEdgeInsets(top: 15, left: 20, bottom: 20, right: 20)
        case .animal:
            return UIEdgeInsets(top: 15, left: 10, bottom: 20, right: 10)
        }
    }
}
