//
//  AnimalInfoFilterCell.swift
//  AnimalInfo
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

class AnimalInfoFilterCell: UICollectionViewCell {

    @IBOutlet weak var btmView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: "AnimalInfoFilterCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btmView.layer.cornerRadius = 3
    }
    
    func config(title: String, isSelect: Bool) {
        titleLabel.text = title.gb
        titleLabel.text = title.gb
        btmView.backgroundColor = isSelect ? #colorLiteral(red: 0.2705882353, green: 0.9882352941, blue: 0.8196078431, alpha: 1) : .clear
        titleLabel.textColor = isSelect ? #colorLiteral(red: 0.2705882353, green: 0.9882352941, blue: 0.8196078431, alpha: 1) : #colorLiteral(red: 0.3176470588, green: 0.7137254902, blue: 0.8196078431, alpha: 1)
    }
}
