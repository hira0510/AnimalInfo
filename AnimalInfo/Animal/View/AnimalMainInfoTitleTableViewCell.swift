//
//  AnimalMainInfoTitleTableViewCell.swift
//  AnimalInfo
//
//  Created by  on 2021/8/26.
//

import UIKit

class AnimalMainInfoTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameChLabel: UILabel!
    @IBOutlet weak var nameEnLabel: UILabel!
    @IBOutlet weak var phylumLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: "AnimalMainInfoTitleTableViewCell", bundle: Bundle(for: self))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(model: AnimalModel) {
        nameChLabel.attributedText = attributedString("名称：", model.chName.gb)
        nameEnLabel.attributedText = attributedString("英文名称：", model.enName)
        locationLabel.attributedText = attributedString("地点：", model.location.gb)
        phylumLabel.attributedText = attributedString("门：", model.phylum.gb)
        classLabel.attributedText = attributedString("纲：", model.classs.gb)
        orderLabel.attributedText = attributedString("目：", model.order.gb)
        familyLabel.attributedText = attributedString("科：", model.family.gb)
    }
    
    private func attributedString(_ text: String, _ sub: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text + sub, attributes: [
                .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
                .foregroundColor: #colorLiteral(red: 0.1107181886, green: 0.1162549492, blue: 0.1245600901, alpha: 1),
                .kern: -0.33
            ])
        attributedString.addAttributes([
                .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
                .foregroundColor: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1),
                .kern: -0.33
            ], range: NSRange(location: 0, length: text.count))
        return attributedString
    }
}
