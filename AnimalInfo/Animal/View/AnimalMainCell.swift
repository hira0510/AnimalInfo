//
//  AnimalMainCell.swift
//  ZooAnimal
//
//  Created by  on 2021/3/31.
//

import UIKit

class AnimalMainCell: UICollectionViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var animalModel: AnimalModel?
    private var isFavorite: Bool = false
    private let animalSqlite = AnimalSQLite()

    static var nib: UINib {
        return UINib(nibName: "AnimalMainCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        mImageView.layer.cornerRadius = 5
        favoriteButton.layer.cornerRadius = favoriteButton.frame.height / 2
        favoriteButton.addTarget(self, action: #selector(clickFavorite), for: .touchUpInside)
    }

    func config(model: AnimalModel) {
        animalModel = model
        mLabel.text = model.chName.gb
        mImageView.loadImage(url: model.image1, placeholder: UIImage(named: "bg1"), options: nil, completionHandler: nil)
        
        let favor = animalSqlite.searchCollect(_id: model.id) > 0
        isFavorite = favor
        favor ? favoriteButton.setImage(UIImage(named: "favor_on"), for: .normal) : favoriteButton.setImage(UIImage(named: "favor_off"), for: .normal)
    }
    
    @objc func clickFavorite() {
        guard let model = animalModel else { return }
        isFavorite = !isFavorite
        isFavorite ? favoriteButton.setImage(UIImage(named: "favor_on"), for: .normal) : favoriteButton.setImage(UIImage(named: "favor_off"), for: .normal)
        isFavorite ? animalSqlite.insertData(_data: model): animalSqlite.delData(_id: model.id)
    }
}
