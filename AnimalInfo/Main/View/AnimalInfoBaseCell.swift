//
//  AnimalInfoBaseCell.swift
//  Animal
//
//  Created by  on 2019/8/12.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class AnimalInfoBaseCell: UICollectionViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var kindLable: UILabel!
    @IBOutlet weak var sexLable: UILabel!
    @IBOutlet weak var statusLable: UILabel!
    
    private var adoptModel: AdoptModel?
    private var lostModel: LostModel?
    private var isFavorite: Bool = false
    private let adoptSqlite = AdoptSQLite()
    private let lostSqlite = LostSQLite()

    static var nib: UINib {
        return UINib(nibName: "AnimalInfoBaseCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        mImageView.layer.cornerRadius = 5
        favoriteButton.layer.cornerRadius = favoriteButton.frame.height / 2
        favoriteButton.addTarget(self, action: #selector(clickFavorite), for: .touchUpInside)
    }

    public func configAdoptCell(adopt: AdoptModel? = nil, lost: LostModel? = nil) {
        
        var img: String = ""
        var kind: String = ""
        var sex: String = ""
        var subid: String = ""
        
        if let model = adopt {
            self.adoptModel = model
            img = model.albumFile
            kind = "种类:" + model.kind.gb
            sex = "性别:" + animalSexString(str: model.sex).gb
            subid = model.subid.gb
            
            let favor = adoptSqlite.searchCollect(_id: subid) > 0
            isFavorite = favor
            favor ? favoriteButton.setImage(UIImage(named: "favor_on"), for: .normal) : favoriteButton.setImage(UIImage(named: "favor_off"), for: .normal)
        } else if let model = lost {
            self.lostModel = model
            img = model.albumFile.gb
            kind = "名称:" + model.name.gb
            sex = "品种:" + model.bodyType.gb
            subid = model.subid
            
            let favor = lostSqlite.searchCollect(_id: subid) > 0
            isFavorite = favor
            favor ? favoriteButton.setImage(UIImage(named: "favor_on"), for: .normal) : favoriteButton.setImage(UIImage(named: "favor_off"), for: .normal)
        }

        mImageView.loadImage(url: img, placeholder: UIImage(named: "bg1"), options: nil) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(_):
                self.statusLable.text = ""
                self.mImageView.alpha = 1
            case .failure(_):
                self.statusLable.text = "无相片"
                self.mImageView.alpha = 0.5
            }
        }
        kindLable.text = kind
        sexLable.text = sex
    }
    
    @objc func clickFavorite() {
        isFavorite = !isFavorite
        isFavorite ? favoriteButton.setImage(UIImage(named: "favor_on"), for: .normal) : favoriteButton.setImage(UIImage(named: "favor_off"), for: .normal)
        if let model = adoptModel {
            isFavorite ? adoptSqlite.insertData(_data: model): adoptSqlite.delData(_id: model.subid)
        } else if let model = lostModel {
            isFavorite ? lostSqlite.insertData(_data: model): lostSqlite.delData(_id: model.subid)
        }
    }

    private func animalSexString(str: String) -> String {
        var out: String
        if str == "M" || str == "公" {
            out = "男生"
        } else if str == "F" || str == "母" {
            out = "女生"
        } else {
            out = "不明"
        }
        return out
    }
}
