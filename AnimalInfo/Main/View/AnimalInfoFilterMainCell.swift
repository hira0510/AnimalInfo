//
//  AnimalInfoFilterMainCell.swift
//  Delicacy
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

protocol AnimalInfoFilterMainCellProtocol: AnyObject {
    func clickType(index: Int)
}

class AnimalInfoFilterMainCell: UICollectionViewCell {

    @IBOutlet weak var sCollectionView: UICollectionView!
    
    weak var delegate: AnimalInfoFilterMainCellProtocol?
    var title = ["全部", "猫", "狗"]
    var isSelect: Int = 0
    
    static var nib: UINib {
        return UINib(nibName: "AnimalInfoFilterMainCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
    }
    
    func config(text: [String]) {
        title = text
        sCollectionView.reloadData()
    }
    
    private func setupCollection() {
        sCollectionView.dataSource = self
        sCollectionView.delegate = self
        sCollectionView.register(AnimalInfoFilterCell.nib, forCellWithReuseIdentifier: "AnimalInfoFilterCell")
    }
}

// MARK: - UICollectionViewDelegate
extension AnimalInfoFilterMainCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return title.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalInfoFilterCell", for: indexPath) as! AnimalInfoFilterCell
        cell.config(title: title[indexPath.item], isSelect: isSelect == indexPath.item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isSelect = indexPath.item
        delegate?.clickType(index: isSelect)
        sCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / CGFloat(title.count), height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
