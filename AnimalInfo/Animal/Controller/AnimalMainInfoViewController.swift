//
//  AnimalMainInfoViewController.swift
//  ZooAnimal
//
//  Created by  on 2021/3/31.
//

import UIKit

class AnimalMainInfoViewController: AnimalInfoBaseViewController {

    public var animalModel: AnimalModel?
    private var isFavorite: Bool = false
    private let animalSqlite = AnimalSQLite()
    private let viewModel = AnimalMainInfoViewModel()

    @IBOutlet var views: AnimalMainInfoViews!

    @IBAction func didClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func didClickFavor(_ sender: Any) {
        guard let model = animalModel else { return }
        isFavorite = !isFavorite
        isFavorite ? views.favoriteBtn.setImage(UIImage(named: "favor_on"), for: .normal) : views.favoriteBtn.setImage(UIImage(named: "favor_off"), for: .normal)
        isFavorite ? animalSqlite.insertData(_data: model) : animalSqlite.delData(_id: model.id)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setXib()
    }

    func setXib() {
        views.mTableView.delegate = self
        views.mTableView.dataSource = self
        views.mTableView.register(AnimalMainInfoImageTableViewCell.nib, forCellReuseIdentifier: "AnimalMainInfoImageTableViewCell")
        views.mTableView.register(AnimalMainInfoTitleTableViewCell.nib, forCellReuseIdentifier: "AnimalMainInfoTitleTableViewCell")
        views.mTableView.register(AnimalInfoTitleTableViewCell.nib, forCellReuseIdentifier: "AnimalInfoTitleTableViewCell")
        views.mTableView.reloadData()

        guard let model = animalModel else { return }
        let favor = animalSqlite.searchCollect(_id: model.id) > 0
        isFavorite = favor
        favor ? views.favoriteBtn.setImage(UIImage(named: "favor_on"), for: .normal) : views.favoriteBtn.setImage(UIImage(named: "favor_off"), for: .normal)
    }
}

// MARK: - UITableViewDelegate
extension AnimalMainInfoViewController: UITableViewDataSource, UITableViewDelegate {

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
            guard let model = animalModel else { return cell }
            let array: [String] = [model.image1, model.image2, model.image3, model.image4]
            let imgArray = array.filter { $0 != "" }
            cell.config(imgArr: imgArray)
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalMainInfoTitleTableViewCell", for: indexPath) as! AnimalMainInfoTitleTableViewCell
            guard let model = animalModel else { return cell }
            cell.config(model: model)
            return cell
        case .sub1, .sub2, .sub3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalInfoTitleTableViewCell", for: indexPath) as! AnimalInfoTitleTableViewCell
            guard let model = animalModel else { return cell }
            let text: [String] = ["饮食：", "特性：", "特征："]
            let sub: [String] = [model.diet.gb, model.behavior.gb, model.feature.gb]
            cell.config(text[indexPath.section - 2], sub[indexPath.section - 2])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = viewModel.tableViewSection[indexPath.section]
        switch section {
        case .image:
            return GlobalUtil.calculateWidthScaleWithSize(width: 240)
        case .info:
            return GlobalUtil.calculateWidthScaleWithSize(width: 145)
        case .sub1, .sub2, .sub3:
            return UITableView.automaticDimension
        }
    }
}
