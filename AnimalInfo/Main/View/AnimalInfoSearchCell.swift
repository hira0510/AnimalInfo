//
//  AnimalInfoSearchCell.swift
//  AnimalInfo
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

protocol AnimalInfoSearchCellProtocol: AnyObject {
    func search(title: String)
}

class AnimalInfoSearchCell: UICollectionViewCell {

    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var historyCollectionView: UICollectionView!
    
    internal weak var delegate: AnimalInfoSearchCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
        searchButton.layer.cornerRadius = 8
        historyLabel.text = UserDefaults.standard.stringArray(forKey: "SearchHistory") == nil ? "历史搜索： 尚无" : "历史搜索："
    }

    static var nib: UINib {
        return UINib(nibName: "AnimalInfoSearchCell", bundle: nil)
    }

    private func setupCollection() {
        historyCollectionView.dataSource = self
        historyCollectionView.delegate = self
        historyCollectionView.register(AnimalInfoSearchLittleCell.nib, forCellWithReuseIdentifier: "AnimalInfoSearchLittleCell")
        historyCollectionView.reloadData()

        searchTextField.delegate = self
        searchTextField.enablesReturnKeyAutomatically = true

        searchButton.addTarget(self, action: #selector(didClickSearchBtn), for: .touchUpInside)
    }

    private func saveSearchText(text: String) {
        historyLabel.text = "历史搜索："
        guard var history = UserDefaults.standard.stringArray(forKey: "SearchHistory") else {
            UserDefaults.standard.setValue([text], forKey: "SearchHistory")
            return
        }
        if history.contains(text) {
            for (i, value) in history.enumerated() {
                if value == text {
                    history.remove(at: i)
                    break
                }
            }
        }
        history.insert(text, at: 0)
        UserDefaults.standard.setValue(history, forKey: "SearchHistory")
        self.historyCollectionView.reloadData()
        self.historyCollectionView.scrollToItem(at: IndexPath.init(), at: .left, animated: false)
    }

    @objc private func didClickSearchBtn() {
        guard let text = searchTextField.text, text != "" else { return }
        FireBaseManager.shard.reportFirebase(domain: "SearchEvent", msg: "点击搜寻", text: text)
        saveSearchText(text: text)
        delegate?.search(title: text)
    }
}

// MARK: - UICollectionViewDelegate
extension AnimalInfoSearchCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let history = UserDefaults.standard.stringArray(forKey: "SearchHistory") else { return 0 }
        return history.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalInfoSearchLittleCell", for: indexPath) as! AnimalInfoSearchLittleCell
        guard let history = UserDefaults.standard.stringArray(forKey: "SearchHistory") else { return cell }
        cell.configCell(title: history[indexPath.item], select: true)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let history = UserDefaults.standard.stringArray(forKey: "SearchHistory"), history.count > indexPath.item else { return }
        let text = history[indexPath.item]
        FireBaseManager.shard.reportFirebase(domain: "SearchEvent", msg: "点击历史", text: text)
        saveSearchText(text: text)
        delegate?.search(title: text)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let history = UserDefaults.standard.stringArray(forKey: "SearchHistory"), history.count > indexPath.item else { return .zero }
        let textWidth = history[indexPath.item].textSize(font: UIFont.systemFont(ofSize: 17), maxSize: CGSize(width: 150, height: 25)).width
        return CGSize(width: textWidth + 20, height: 25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15)
    }
}

// MARK: - UITextFieldDelegate
extension AnimalInfoSearchCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = searchTextField.text, text != "" else { return true }
        FireBaseManager.shard.reportFirebase(domain: "SearchEvent", msg: "点击搜寻", text: text)
        saveSearchText(text: text)
        delegate?.search(title: text)
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.search(title: "")
        return true
    }
}

extension String {
    
    /// 計算文字Label長度
    ///
    /// - Parameters:
    ///   - font: 字體樣式
    ///   - maxSize: 最大size
    /// - Returns: 回傳CGSize
    func textSize(font: UIFont, maxSize: CGSize) -> CGSize {
        return self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil).size
    }
}
