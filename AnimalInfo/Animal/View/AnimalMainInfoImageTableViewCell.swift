//
//  AnimalMainInfoImageTableViewCell.swift
//  AnimalInfo
//
//  Created by  on 2021/8/26.
//

import UIKit

class AnimalMainInfoImageTableViewCell: UITableViewCell {

    @IBOutlet weak var mCollectionView: UICollectionView!
    
    var mImage: [String] = []
    
    static var nib: UINib {
        return UINib(nibName: "AnimalMainInfoImageTableViewCell", bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.register(AnimalInfoTYCycleCell.classForCoder(), forCellWithReuseIdentifier: "AnimalInfoTYCycleCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(imgArr: [String]) {
        mImage = imgArr
        mCollectionView.reloadData()
    }
    
}

extension AnimalMainInfoImageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mImage.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalInfoTYCycleCell", for: indexPath) as! AnimalInfoTYCycleCell
        cell.addImage(url: mImage[indexPath.item])
        cell.image.contentMode = .scaleAspectFit
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mCollectionView.frame.width - 30, height: mCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
