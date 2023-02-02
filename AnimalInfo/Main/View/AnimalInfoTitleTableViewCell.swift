//
//  AnimalInfoTitleTableViewCell.swift
//  AnimalInfo
//
//  Created by  on 2021/8/26.
//

import UIKit

protocol AnimalInfoTitleTableViewCellProtocol: AnyObject {
    func didClickButton(url: String)
}

class AnimalInfoTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mButton: UIButton!
    
    var mUrl: String = ""
    public weak var delegate: AnimalInfoTitleTableViewCellProtocol?
    
    static var nib: UINib {
        return UINib(nibName: "AnimalInfoTitleTableViewCell", bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(_ text: String, _ sub: String) {
        titleLabel.attributedText = attributedString(text, sub)
        mButton.isUserInteractionEnabled = false
    }
    
    func webConfig(_ text: String, _ sub: String, url: String) {
        mUrl = url
        titleLabel.attributedText = webAttributedString(text, sub)
        mButton.isUserInteractionEnabled = true
        mButton.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
    }
    
    @objc func didClickButton() {
        delegate?.didClickButton(url: mUrl)
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
    
    private func webAttributedString(_ text: String, _ sub: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text + sub, attributes: [
                .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
                .foregroundColor: #colorLiteral(red: 0.2196078431, green: 0.3882352941, blue: 0.8549019608, alpha: 1),
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
