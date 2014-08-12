//
//  ViewController.swift
//  SwiftSQLite
//
//  Created by Tetsuya Shiraishi on 2014/08/12.
//  Copyright (c) 2014年 mushikago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushButton(sender: AnyObject) {
        println("push")
        let _dbfile:NSString = "sqlite.db"
        let _dir:AnyObject = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask,
            true)[0]
        let fileManager:NSFileManager = NSFileManager.defaultManager()
        let _path:String = _dir.stringByAppendingPathComponent(_dbfile)
        
        println(_path)
        
        if(!fileManager.fileExistsAtPath(_path)){
            //ファイルがない場合はDBファイル作成（最初の押下）
            let _db = FMDatabase(path: _path)
            let _sql = "CREATE TABLE test (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT);"
            
            _db.open()
            
            var _result = _db.executeStatements(_sql)
            println(_result)
            
            _db.close()
            
        }else{
            //ファイルがすでに存在する場合（２回目以降の押下）
            let _db = FMDatabase(path: _path)
            
            let _sql_insert = "insert into test (title) values (?);"
            let _sql_select = "SELECT title FROM test WHERE id = ?"
            
            
            _db.open()
            
            var _result_insert = _db.executeUpdate(_sql_insert, withArgumentsInArray: ["あいうえお"])
            var _rows = _db.executeQuery(_sql_select, withArgumentsInArray: [1])
            
            
            while(_rows.next()){
                var _title = _rows.stringForColumn("title")
                println(_title)
            }
            
            _db.close()
        }
    }

}

