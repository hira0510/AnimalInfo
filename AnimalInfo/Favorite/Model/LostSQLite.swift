//
//  LostSQLite.swift
//  AnimalInfo
//
//  Created by  on 2021/8/24.
//

import UIKit
import SQLite

struct LostSQLite {
    
    private var db: Connection!
    private let collection = Table("Lost") //表名
    private let id = Expression<Int64>("id") //主键
    private let albumFile = Expression<String>("albumFile") //圖片
    private let subid = Expression<String>("subid")  //他的id
    private let kind = Expression<String>("kind") //寵物別
    private let name = Expression<String>("name") //寵物名
    private let tel = Expression<String>("tel") //連絡電話
    private let sex = Expression<String>("sex") //性別
    private let bodyType = Expression<String>("bodyType") //品種
    private let colour = Expression<String>("colour") //毛色
    private let remark = Expression<String>("remark") //特徵
    private let openDate = Expression<String>("openDate") //遺失時間
    private let address = Expression<String>("address") //遺失地點
    
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
                t.column(albumFile)
                t.column(subid)
                t.column(kind)
                t.column(sex)
                t.column(name)
                t.column(tel)
                t.column(bodyType)
                t.column(colour)
                t.column(remark)
                t.column(openDate)
                t.column(address)
            })
        } catch {
            print("db collection error => \(error)")
        }
    }
    
    //插入数据
    func insertData(_data: LostModel) {
        do {
            if searchCollect(_id: _data.subid) == 0 && !_data.subid.elementsEqual("") {
                let insert = collection.insert(albumFile <- _data.albumFile, subid <- _data.subid, kind <- _data.kind, name <- _data.name, tel <- _data.tel, sex <- _data.sex, bodyType <- _data.bodyType, colour <- _data.colour, remark <- _data.remark, openDate <- _data.openDate, address <- _data.address)
                try db.run(insert)
            }
        } catch {
            print("[DEBUG] insert error => \(error)")
        }
    }
    
    /// 更新数据
    func upDate(_data: LostModel) {
        do {
            if searchCollect(_id: _data.subid) != 0 {
                let currUser = collection.filter(subid == _data.subid)
                let insertVideoID = currUser.update(albumFile <- _data.albumFile, subid <- _data.subid, kind <- _data.kind, name <- _data.name, tel <- _data.tel, sex <- _data.sex, bodyType <- _data.bodyType, colour <- _data.colour, remark <- _data.remark, openDate <- _data.openDate, address <- _data.address)
                try db.run(insertVideoID)
            }
        } catch {
            print(error)
        }
    }
    
    //读取数据
    func readData() -> [LostModel] {
        var collectionArray: [LostModel] = []
        
        for user in try! db.prepare(collection) {
            var pars = [String: Any]()
            pars["PICTURE"] = user[albumFile]
            pars["晶片號碼"] = user[subid]
            pars["寵物別"] = user[kind]
            pars["寵物名"] = user[name]
            pars["連絡電話"] = user[tel]
            pars["性別"] = user[sex]
            pars["品種"] = user[bodyType]
            pars["毛色"] = user[colour]
            pars["特徵"] = user[remark]
            pars["遺失時間"] = user[openDate]
            pars["遺失地點"] = user[address]
            let collectionData: LostModel = LostModel(JSON: pars)!
            collectionArray.append(collectionData)
        }
        return collectionArray
    }
    
    func searchCollect(_id: String) -> Int {
        do {
            let searchCnt = collection.filter(subid == _id)
            return try db.scalar(searchCnt.count)
        } catch {
            return 0
        }
    }
    
    //删除数据
    func delData(_id: String) {
        let currUser = collection.filter(_id == self.subid)
        do {
            try db.run(currUser.delete())
        } catch {
            print(error)
        }
    }
}
