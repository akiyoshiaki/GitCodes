//
//  Sa；。え.swift
//  FlashNotes
//
//  Created by denjo on 2015/09/15.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.
// 関係クラス
// FingerBoardController

import Foundation
import UIKit
import SpriteKit

//いろいろプロトコルを使います
class App1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate, NSURLSessionDataDelegate{
    
    // 定数をいろいろ定義します
    let myItems: NSArray = ["C", "G", "Am"]
    let videoUrlHead: String = "https://www.youtube.com/watch?v="
    let chordJsonUrlHead: String = "https://widget.songle.jp/api/v1/song/chord.json?url="
    //var videoId: String = "o1jAMSQyVPc" //メルト
    var videoId: String = "Eze6-eHmtJg" //チェリー
    
    // クラス内どこでも使えるChordBookHelperを保持しておきます
    var chordBookHelper: ChordBookHelper?
    
    // JSON保持用
    var json: JSON?
    
    
    // 表示用の配列(型を明示すること)
    // var chordItems: NSArray = []
    var chordItems: [AnyObject] = []
    
    var fingerBoardScene: FingerBoardController?
    var GameView: SKView!
    var tableView: UITableView!
    
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
        右側7割の画面にGameViewを作りたいです
        そしてGameViewの大きさいっぱいにGameSceneを貼りたいです
        */

        // GameViewの矩形を指定します
        let gameViewFrame: CGRect = CGRectMake(superFrame.size.width * 0.3, statusBarHeight + navigationBarHeight, superFrame.size.width * 0.7, superFrame.size.height - statusBarHeight - navigationBarHeight)
        
        // GameViewというSKViewを作ってルートビューに追加します
        GameView = SKView(frame: gameViewFrame)
        self.view.addSubview(GameView)
        
        // 適当に設定します
        GameView.showsFPS = true
        GameView.showsNodeCount = true
        

        
        //続いてGameSceneのFingerBoardControllerを作ります
        fingerBoardScene = FingerBoardController()
        
        //短い辺に大きさを合わせます(もしかして不要)
        fingerBoardScene?.scaleMode = .AspectFill
        
        //fingerBoardSceneの大きさをGameViewの大きさに合わせます
        fingerBoardScene?.size = GameView!.frame.size
        
        //GameViewにfingerBoardSceneを表示します
        GameView.presentScene(fingerBoardScene!)

        
        /*
        tableViewを貼る前に、コードリストを取得したいです
        1. まずAPIを使用してコードのJSONを取得します
        2. 次にJSONをパースしてNSArrayに格納します
        */

        // APIからJSONを入手します
        // ちなみに外部ライブラリを使ってます
        json = JSON(url: chordJsonUrlHead + videoUrlHead + videoId)
        
        // JSONからコードの部分だけを抜き出し、Arrayに追加していきます
        for (_, value) in json!["chords"] {

            let name:String = value["name"].asString!

            // コード名なしのところは飛ばします
            if name != "N" {
                //print(name)
                chordItems.append(name)
            }
        }
      
 
        //この手順を踏まないとファイル読み込みできない
        //覚えておけ.
        if let fileName = NSBundle.mainBundle().pathForResource("0003", ofType: "JSON") {
            print(fileName)
            var fileString: String!
            do{
                fileString = try String(contentsOfFile: fileName, encoding: NSUTF8StringEncoding)
            }catch _ as NSError{
                
            }
            if let json_tmp: JSON = JSON(fileString) {
                print(json_tmp)
            }

        }
    


        
        /*
        左下にtableViewを配置したいです
        */
        

        // tableViewを貼るべき領域の大きさを計算して取得します
        // 幅は30%、高さは50%にしたいです
        //let tableViewWidth: CGFloat = self.view.frame.width - GameView!.frame.width
        let tableViewWidth: CGFloat = self.view.frame.width * 0.3
        let tableViewHeight: CGFloat = (self.view.frame.height - statusBarHeight - navigationBarHeight) * 0.5
        
        // 貼るべき矩形領域を指定します
        //var frame = CGRect(x: GameView!.frame.width, y: statusBarHeight + navigationBarHeight + tableViewHeight, width: tableViewWidth, height: tableViewHeight)
        let frame = CGRect(x: 0, y: statusBarHeight + navigationBarHeight + tableViewHeight, width: tableViewWidth, height: tableViewHeight)
        //print(frame)
        //tableViewを生成します
        tableView = UITableView(frame: frame)
  

        // tableにCell名の登録をおこなう.
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // このへんの設定も必須です.
        tableView.dataSource = self
        tableView.delegate = self
        
        // ViewにtableViewを追加します.
        self.view.addSubview(tableView)

        
        /*
        右上にはinformation Viewを設置したいです
        */
        
        
        
        /*
         ChordBookHelperの用意をします.
        */
        chordBookHelper = ChordBookHelper()
        chordBookHelper?.setAllChords()
        chordBookHelper?.chordBook["F"]?.showContents()
        
    }

    // これは必要っぽい
    override func viewDidAppear(animated: Bool) {
        //これ真偽どっちを書くべきか分からない
        //これは必須です
        super.viewDidAppear(false)
        
        print("viewDidAppear")

        // 最初に1列目を選択状態にします
        let indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Bottom)

        // 1行目のコードもタッチさせたことにしたい
        let name = chordItems[0] as! String
        let firstChord = chordBookHelper?.chordBook[name]?.getChord()
        fingerBoardScene?.touchedTableViewCell(firstChord!)
        
        // ここからFingerBoardの各タイルにpitchを無理やり持たせられないだろうか
        // ロジックはどうする? そんなものないか...?
        // pitchの上下関係が分かれば楽なんだけど...
        self.setPitchOnTile()
        
    }
    
    /*
    Cellが選択された際に呼び出されるデリゲートメソッド.
    ここをいろいろ拡張しないと
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let num = indexPath.row
        let name = chordItems[num] as! String
        
        // ここからFingerBoardにアクセスしたいです
        // まずはタッチされたコードを検索しましょう
        var selectedChord: Chord?
        selectedChord = chordBookHelper?.chordBook[name]?.getChord()
        
        // 渡してみます
        if selectedChord != nil {
            fingerBoardScene?.touchedTableViewCell(selectedChord!)
        }
        
    }
    
    /*
    Cellの総数を返すデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 変えるの忘れないように!!
        return chordItems.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) 
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(chordItems[indexPath.row])"
        
        return cell
    }
    
    
    
    // FingerBoardの各タイルにpitchを無理やり持たせるメソッド
    // 脳筋ﾌﾟﾖｸﾞﾗﾐﾝﾕ
    func setPitchOnTile(){
        if let fbs = fingerBoardScene {
            
            // 開放弦
            fingerBoardScene?.tileMap[0].pitch  = chordBookHelper!.E2
            fingerBoardScene?.tileMap[1].pitch  = chordBookHelper!.A2
            fingerBoardScene?.tileMap[2].pitch  = chordBookHelper!.D3
            fingerBoardScene?.tileMap[3].pitch  = chordBookHelper!.G3
            fingerBoardScene?.tileMap[4].pitch  = chordBookHelper!.B3
            fingerBoardScene?.tileMap[5].pitch  = chordBookHelper!.E4
            
            // 1ポジ
            fingerBoardScene?.tileMap[6].pitch  = chordBookHelper!.F2
            fingerBoardScene?.tileMap[7].pitch  = chordBookHelper!.As2
            fingerBoardScene?.tileMap[8].pitch  = chordBookHelper!.Ds3
            fingerBoardScene?.tileMap[9].pitch  = chordBookHelper!.Gs3
            fingerBoardScene?.tileMap[10].pitch  = chordBookHelper!.C4
            fingerBoardScene?.tileMap[11].pitch  = chordBookHelper!.F4

            // 2ポジ
            fingerBoardScene?.tileMap[12].pitch  = chordBookHelper!.Fs2
            fingerBoardScene?.tileMap[13].pitch  = chordBookHelper!.B2
            fingerBoardScene?.tileMap[14].pitch  = chordBookHelper!.E3
            fingerBoardScene?.tileMap[15].pitch  = chordBookHelper!.A3
            fingerBoardScene?.tileMap[16].pitch  = chordBookHelper!.Cs4
            fingerBoardScene?.tileMap[17].pitch  = chordBookHelper!.Fs4
            
            // 3ポジ
            fingerBoardScene?.tileMap[18].pitch  = chordBookHelper!.G2
            fingerBoardScene?.tileMap[19].pitch  = chordBookHelper!.C3
            fingerBoardScene?.tileMap[20].pitch  = chordBookHelper!.F3
            fingerBoardScene?.tileMap[21].pitch  = chordBookHelper!.As3
            fingerBoardScene?.tileMap[22].pitch  = chordBookHelper!.D4
            fingerBoardScene?.tileMap[23].pitch  = chordBookHelper!.G4

            // 4ポジ
            fingerBoardScene?.tileMap[24].pitch  = chordBookHelper!.Gs2
            fingerBoardScene?.tileMap[25].pitch  = chordBookHelper!.Cs3
            fingerBoardScene?.tileMap[26].pitch  = chordBookHelper!.Fs3
            fingerBoardScene?.tileMap[27].pitch  = chordBookHelper!.B3
            fingerBoardScene?.tileMap[28].pitch  = chordBookHelper!.Ds4
            fingerBoardScene?.tileMap[29].pitch  = chordBookHelper!.Gs4
            
            //5ポジ
            fingerBoardScene?.tileMap[30].pitch  = chordBookHelper!.A2
            fingerBoardScene?.tileMap[31].pitch  = chordBookHelper!.D3
            fingerBoardScene?.tileMap[32].pitch  = chordBookHelper!.G3
            fingerBoardScene?.tileMap[33].pitch  = chordBookHelper!.C4
            fingerBoardScene?.tileMap[34].pitch  = chordBookHelper!.E4
            fingerBoardScene?.tileMap[35].pitch  = chordBookHelper!.A4
         
            for tile in fbs.tileMap {
                tile.pitch.showPitch()
                
            }
        }
    }
    
    
}