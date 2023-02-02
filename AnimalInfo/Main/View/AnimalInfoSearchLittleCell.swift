//
//  AnimalInfoSearchLittleCell.swift
//  

import UIKit

class AnimalInfoSearchLittleCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 12.5
    }
    
    static var nib: UINib {
        return UINib(nibName: "AnimalInfoSearchLittleCell", bundle: nil)
    }

    func configCell(title: String, select: Bool) {
        titleLabel.text = title.gb
        bgView.backgroundColor = select ? UIColor(0x51B6D1): UIColor(0x5163D1)
    }
}
