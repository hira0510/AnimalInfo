//
//  LostInfoViewController.swift
//  AnimalInfo
//
//  Created by on 2021/8/26.
//

import UIKit

class LostInfoViewController: AnimalInfoBaseViewController {
    
    public var lostModel: LostModel?
    private var isFavorite: Bool = false
    private let lostSqlite = LostSQLite()
    private let viewModel = LostInfoViewModel()

    @IBOutlet var views: LostInfoViews!
    
    @IBAction func didClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func didClickFavor(_ sender: Any) {
        guard let model = lostModel else { return }
        isFavorite = !isFavorite
        isFavorite ? views.favoriteBtn.setImage(UIImage(named: "favor_on"), for: .normal) : views.favoriteBtn.setImage(UIImage(named: "favor_off"), for: .normal)
        isFavorite ? lostSqlite.insertData(_data: model) : lostSqlite.delData(_id: model.subid)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setXib()
    }

    func setXib() {
        views.mTableView.delegate = self
        views.mTableView.dataSource = self
        views.mTableView.register(AnimalMainInfoImageTableViewCell.nib, forCellReuseIdentifier: "AnimalMainInfoImageTableViewCell")
        views.mTableView.register(LostInfoTitleTableViewCell.nib, forCellReuseIdentifier: "LostInfoTitleTableViewCell")
        views.mTableView.register(AnimalInfoTitleTableViewCell.nib, forCellReuseIdentifier: "AnimalInfoTitleTableViewCell")
        views.mTableView.reloadData()

        guard let model = lostModel else { return }
        let favor = lostSqlite.searchCollect(_id: model.subid) > 0
        isFavorite = favor
        favor ? views.favoriteBtn.setImage(UIImage(named: "favor_on"), for: .normal) : views.favoriteBtn.setImage(UIImage(named: "favor_off"), for: .normal)
    }
}

// MARK: - UITableViewDelegate
extension LostInfoViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.tableViewSection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.tableViewSection[indexPath.section]
        switch section {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalMainInfoImageTableViewCell", for: indexPath) as! AnimalMainInfoImageTableViewCell
            guard let model = lostModel else { return cell }
            cell.config(imgArr: [model.albumFile])
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LostInfoTitleTableViewCell", for: indexPath) as! LostInfoTitleTableViewCell
            guard let model = lostModel else { return cell }
            cell.config(model: model)
            return cell
        case .sub1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalInfoTitleTableViewCell", for: indexPath) as! AnimalInfoTitleTableViewCell
            guard let model = lostModel else { return cell }
            cell.config("特徵：", model.remark.gb)
            return cell
        case .sub2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalInfoTitleTableViewCell", for: indexPath) as! AnimalInfoTitleTableViewCell
            guard let model = lostModel else { return cell }
            cell.config("晶片号码：", model.subid.gb)
            return cell
        case .sub3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalInfoTitleTableViewCell", for: indexPath) as! AnimalInfoTitleTableViewCell
            guard let model = lostModel else { return cell }
            cell.webConfig("遗失地点：", model.address.gb, url: model.address)
            cell.delegate = self
            return cell
        case .sub4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalInfoTitleTableViewCell", for: indexPath) as! AnimalInfoTitleTableViewCell
            guard let model = lostModel else { return cell }
            cell.config("连络电话：", model.tel.gb)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = viewModel.tableViewSection[indexPath.section]
        switch section {
        case .image:
            return GlobalUtil.calculateWidthScaleWithSize(width: 260)
        case .info:
            return GlobalUtil.calculateWidthScaleWithSize(width: 145)
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - AnimalInfoTitleTableViewCellProtocol
extension LostInfoViewController: AnimalInfoTitleTableViewCellProtocol {
    func didClickButton(url: String) {
        toWebSearchInfo(title: url, fromSearch: false)
    }
}
