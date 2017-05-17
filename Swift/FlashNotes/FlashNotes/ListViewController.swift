//
//  ListViewController.swift
//  FlashNotes
//
//  Created by denjo on 2015/11/09.
//  Copyright © 2015年 Shunya Ariga. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    // JSON保持用
    //var jsonArray: [JSON] = [JSON]()
    var songInfoArray:[SongInfo] = [SongInfo]()
    
    
    // storyboardで作成したtableView
    // storyboardでもデリゲートしてるし問題あるかも
    @IBOutlet weak var myTable: UITableView!
    
    // 画面の大きさとか.
    var superFrame: CGRect!
    var statusBarHeight: CGFloat!
    var navigationBarHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // まずルートビューの画面の大きさ(正しいやつ)を取得します
        superFrame = self.view.frame
        
        // 次に画面上のバーの高さを取得してプロパティに保持します
        statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        navigationBarHeight = self.navigationController!.navigationBar.frame.size.height
        
        
        
        /*
        tableViewを貼る前に、コードリストを取得したいです
        1. まずAPIを使用してコードのJSONを取得します
        2. 次にJSONをパースしてNSArrayに格納します
        */
        
        // JSONからコードの部分だけを抜き出し、Arrayに追加していきます
//        for (_, value) in json!["chords"] {
//            
//            let name:String = value["name"].asString!
//            
//            // コード名なしのところは飛ばします
//            if name != "N" {
//                //print(name)
//                chordItems.append(name)
//            }
//        }
        
        
        //JSONファイルを開いていく
        //JSONの読み込み、string指定子が必要
        //とりあえずSongInfoだけ取り出しておく
        
        var yonketa: String
        
        for i in 1...1301{
        
            yonketa = NSString(format: "%04d", i) as String

            if let fileName = NSBundle.mainBundle().pathForResource(yonketa, ofType: "JSON") {

                var rowData: String!
                do{
                    rowData = try String(contentsOfFile: fileName, encoding: NSUTF8StringEncoding)
                }catch _ as NSError{
                    
                }
                
                if let tmpJson: JSON = JSON(string: rowData) {
                    let tmpJsonSong = tmpJson["song"]
                    //強制キャスト方法が変わった
                    let tmpId: Int = tmpJsonSong["id"].asInt!
                    let tmpTitle: String = tmpJsonSong["title"].asString!
                    let tmpArtist: String = tmpJsonSong["artist"].asString!
                    let tmpTonic: String = tmpJsonSong["tonic"].asString!
                    //metreはまだ入れてなかったので飛ばす
                    //let tmpMetre: String = tmpJsonSong["metre"].asString!
                    let tmpMetre = ""
                    let tmpSongInfo: SongInfo = SongInfo(id: tmpId, title: tmpTitle, artist: tmpArtist, tonic: tmpTonic, metre: tmpMetre)
                    songInfoArray.append(tmpSongInfo)
                    
                }
                
            }
            
        }
        
        
        /*
        上2割のスペースを残してtableを貼ります
        */
        
        
        // tableViewを貼るべき領域の大きさを計算して取得します
        // 幅は30%、高さは50%にしたいです
        let tableViewWidth: CGFloat = superFrame.width
        let tableViewHeight: CGFloat = (superFrame.height - statusBarHeight - navigationBarHeight) * 0.85
        
        // 貼るべき矩形領域を指定します
        //右寄せから左下寄せに変えました
        //var frame = CGRect(x: GameView!.frame.width, y: statusBarHeight + navigationBarHeight + tableViewHeight, width: tableViewWidth, height: tableViewHeight)
        let frame = CGRect(x: 0, y: superFrame.height - tableViewHeight, width: tableViewWidth, height: tableViewHeight)
        //print(frame)
        //tableViewを生成します
        // myTable = UITableView(frame: frame)
        
        myTable.frame = frame
        
        // tableにCell名の登録をおこなう.
        // myTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SongCell")
        
        // このへんの設定も必須です.
         myTable.dataSource = self
         myTable.delegate = self
        
        ///
        ///カスタムデータのセットアップ
        // self.setupTmp()
        
        // ViewにtableViewを追加します.
        // self.view.addSubview(myTable)
        
        
        /*
        右上にはinformation Viewを設置したいです
        */
        
        

    }
    
    // これは必要っぽい
    override func viewDidAppear(animated: Bool) {
        //これ真偽どっちを書くべきか分からない
        //これは必須です
        super.viewDidAppear(false)
        
        print("viewDidAppear")
        
        // 最初に1列目を選択状態にします
        let indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        myTable.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Bottom)
        
        //高さ調節をやってくれるらしい
        self.myTable.rowHeight = UITableViewAutomaticDimension
        
    }
    
    //private let myItems: NSArray = ["TEST1", "TEST2", "TEST3"]
    //var myItems:[SongInfo] = [SongInfo]()
    
    func setupTmp(){
        let cell1 = SongInfo(id: 1, title: "hey", artist: "you", tonic: "C", metre: "9/8")
        songInfoArray.append(cell1)
        let cell2 = SongInfo(id: 2, title: "ypaaaa", artist: "you", tonic: "D", metre: "9/8")
        songInfoArray.append(cell2)
        
    }

    /*
    Cellが選択された際に呼び出されるデリゲートメソッド.
    ここをいろいろ拡張しないと
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(songInfoArray[indexPath.row])")
    }
    
    /*
    Cellの総数を返すデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 変えるの忘れないように!!
        return songInfoArray.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("SongCell", forIndexPath: indexPath) as! SongListCell
        
        // Cellに値を設定する.
        //cell.textLabel!.text = "\(myItems[indexPath.row])"
        cell.setCell(songInfoArray[indexPath.row])
        
        return cell
    }



    
}