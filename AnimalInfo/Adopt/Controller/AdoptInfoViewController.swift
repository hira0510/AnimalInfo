//
//  AdoptInfoViewController.swift
//  AnimalInfo
//
//  Created by  on 2021/8/26.
//

import UIKit

class AdoptInfoViewController: AnimalInfoBaseViewController {
    
    public var adoptModel: AdoptModel?
    private var isFavorite: Bool = false
    private let adoptSqlite = AdoptSQLite()
    private let viewModel = AdoptInfoViewModel()

    @IBOutlet var views: AdoptInfoViews!
    
    @IBAction func didClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func didClickFavor(_ sender: Any) {
        guard let model = adoptModel else { return }
        isFavorite = !isFavorite
        isFavorite ? views.favoriteBtn.setImage(UIImage(named: "favor_on"), for: .normal) : views.favoriteBtn.setImage(UIImage(named: "favor_off"), for: .normal)
        isFavorite ? adoptSqlite.insertData(_data: model) : adoptSqlite.delData(_id: model.subid)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setXib()
    }

    func setXib() {
        views.mTableView.delegate = self
        views.mTableView.dataSource = self
        views.mTableView.register(AnimalMainInfoImageTableViewCell.nib, forCellReuseIdentifier: "AnimalMainInfoImageTableViewCell")
        views.mTableView.register(AdoptInfoTitleTableViewCell.nib, forCellReuseIdentifier: "AdoptInfoTitleTableViewCell")
        views.mTableView.register(AnimalInfoTitleTableViewCell.nib, forCellReuseIdentifier: "AnimalInfoTitleTableViewCell")
        views.mTableView.reloadData()

        guard let model = adoptModel else { return }
        let favor = adoptSqlite.searchCollect(_id: model.subid) > 0
        isFavorite = favor
        favor ? views.favoriteBtn.setImage(UIImage(named: "favor_on"), for: .normal) : views.favoriteBtn.setImage(UIImage(named: "favor_off"), for: .normal)
    }
}

// MARK: - UITableViewDelegate
extension AdoptInfoViewController: UITableViewDataSource, UITableViewDelegate {

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
            guard let model = adoptModel else { return cell }
            cell.config(imgArr: [model.albumFile])
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdoptInfoTitleTableViewCell", for: indexPath) as! AdoptInfoTitleTableViewCell
            guard let model = adoptModel else { return cell }
            cell.config(model: model)
            return cell
        case .sub1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalInfoTitleTableViewCell", for: indexPath) as! AnimalInfoTitleTableViewCell
            guard let model = adoptModel else { return cell }
            cell.config("描述：", model.remark.gb)
            return cell
        case .sub2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalInfoTitleTableViewCell", for: indexPath) as! AnimalInfoTitleTableViewCell
            guard let model = adoptModel else { return cell }
            cell.config("收容所名称：", model.name.gb)
            return cell
        case .sub3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalInfoTitleTableViewCell", for: indexPath) as! AnimalInfoTitleTableViewCell
            guard let model = adoptModel else { return cell }
            cell.webConfig("地址：", model.address.gb, url: model.address)
            cell.delegate = self
            return cell
        case .sub4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalInfoTitleTableViewCell", for: indexPath) as! AnimalInfoTitleTableViewCell
            guard let model = adoptModel else { return cell }
            cell.config("电话：", model.tel.gb)
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
        case .sub1, .sub2, .sub3, .sub4:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - AnimalInfoTitleTableViewCellProtocol
extension AdoptInfoViewController: AnimalInfoTitleTableViewCellProtocol {
    func didClickButton(url: String) {
        toWebSearchInfo(title: url, fromSearch: false)
    }
}
