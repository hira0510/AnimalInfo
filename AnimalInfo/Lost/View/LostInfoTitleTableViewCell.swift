//
//  LostInfoTitleTableViewCell.swift
//  AnimalInfo
//
//  Created by  on 2021/8/26.
//

import UIKit

class LostInfoTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subidLabel: UILabel!
    @IBOutlet weak var openDateEnLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var bodyTypeLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: "LostInfoTitleTableViewCell", bundle: Bundle(for: self))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(model: LostModel) {
        subidLabel.attributedText = attributedString("宠物名：", model.subid.gb)
        openDateEnLabel.attributedText = attributedString("遗失时间：", model.openDate.gb)
        colourLabel.attributedText = attributedString("品种：", model.bodyType.gb)
        kindLabel.attributedText = attributedString("种类：", model.kind.gb)
        sexLabel.attributedText = attributedString("性别：", animalSexString(str: model.sex.gb))
        bodyTypeLabel.attributedText = attributedString("毛色：", model.colour.gb)
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
