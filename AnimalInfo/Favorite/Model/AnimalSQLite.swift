//
//  AnimalSQLite.swift
//  AnimalInfo
//
//  Created by  on 2021/8/24.
//

import UIKit
import SQLite

struct AnimalSQLite {
    
    private var db: Connection!
    private let collection = Table("Animal") //表名
    private let id = Expression<Int64>("id")  //主键
    private let mId = Expression<Int>("mId") //他的id
    private let chName = Expression<String>("chName") //中文名
    private let enName = Expression<String>("enName") //英文名
    private let phylum = Expression<String>("phylum") //門
    private let classs = Expression<String>("classs") //剛
    private let order = Expression<String>("order") //目
    private let family = Expression<String>("family") //科
    private let location = Expression<String>("location") //地點館
    private let behavior = Expression<String>("behavior") //特性
    private let feature = Expression<String>("feature") //特徵
    private let diet = Expression<String>("diet") //飲食
    private let image1 = Expression<String>("image1")  //圖片1
    private let image2 = Expression<String>("image2") //圖片2
    private let image3 = Expression<String>("image3") //圖片3
    private let image4 = Expression<String>("image4") //圖片4

    init() {
        createdsqlite3()
    }

    //创建数据库文件
    mutating func createdsqlite3(filePath: String = "/Documents")  {

        let sqlFilePath = NSHomeDirectory() + filePath + "/db.sqlite3"
        do {
            db = try Connection(sqlFilePath)
            try db.run(collection.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(mId)
                t.column(chName)
                t.column(enName)
                t.column(phylum)
                t.column(classs)
                t.column(order)
                t.column(family)
                t.column(location)
                t.column(behavior)
                t.column(feature)
                t.column(diet)
                t.column(image1)
                t.column(image2)
                t.column(image3)
                t.column(image4)
            })
        } catch {
            print("db collection error => \(error)")
        }
    }

    //插入数据
    func insertData(_data: AnimalModel) {
        do {
            if searchCollect(_id: _data.id) == 0 && _data.id != 0 {
                let insert = collection.insert(mId <- _data.id, chName <- _data.chName, enName <- _data.enName, phylum <- _data.phylum, classs <- _data.classs, order <- _data.order, family <- _data.family, location <- _data.location, behavior <- _data.behavior, feature <- _data.feature, diet <- _data.diet ,image1 <- _data.image1, image2 <- _data.image2, image3 <- _data.image3, image4 <- _data.image4)
                try db.run(insert)
            }
        } catch {
            print("[DEBUG] insert error => \(error)")
        }
    }

    /// 更新数据
    func upDate(_data: AnimalModel) {
        do {
            if searchCollect(_id: _data.id) != 0 {
                let currUser = collection.filter(mId == _data.id)
                let insertID = currUser.update(mId <- _data.id, chName <- _data.chName, enName <- _data.enName, phylum <- _data.phylum, classs <- _data.classs, order <- _data.order, family <- _data.family, location <- _data.location, behavior <- _data.behavior, feature <- _data.feature, diet <- _data.diet ,image1 <- _data.image1, image2 <- _data.image2, image3 <- _data.image3, image4 <- _data.image4)
                try db.run(insertID)
            }
        } catch {
            print(error)
        }
    }

    //读取数据
    func readData() -> [AnimalModel] {
        var collectionArray: [AnimalModel] = []

        for user in try! db.prepare(collection) {
            var pars = [String: Any]()
            pars["_id"] = user[mId]
            pars["a_name_ch"] = user[chName]
            pars["a_name_en"] = user[enName]
            pars["a_phylum"] = user[phylum]
            pars["a_class"] = user[classs]
            pars["a_order"] = user[order]
            pars["a_family"] = user[family]
            pars["a_location"] = user[location]
            pars["a_behavior"] = user[behavior]
            pars["a_feature"] = user[feature]
            pars["a_diet"] = user[diet]
            pars["a_pic01_url"] = user[image1]
            pars["a_pic02_url"] = user[image2]
            pars["a_pic03_url"] = user[image3]
            pars["a_pic04_url"] = user[image4]
            let collectionData: AnimalModel = AnimalModel(JSON: pars)!
            collectionArray.append(collectionData)
        }
        return collectionArray
    }

    func searchCollect(_id: Int) -> Int {
        do {
            let searchCnt = collection.filter(mId == _id)
            return try db.scalar(searchCnt.count)
        } catch {
            return 0
        }
    }

    //删除数据
    func delData(_id: Int) {
        let currUser = collection.filter(_id == self.mId)
        do {
            try db.run(currUser.delete())
        } catch {
            print(error)
        }
    }
}
