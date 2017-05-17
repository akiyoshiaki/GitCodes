//
//  FingerBoard.swift
//  FlashNotes
//
//  Created by denjo on 2015/09/15.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.
// 関係クラス

import Foundation
import SpriteKit


class FingerBoardController: SKScene {

    // タイル配列
    // これは辞書の方がいいのでは...
    var tileMap = [Tile]()
    
    // タッチすべきポジション配列
    var touchMarkMap = [TouchMark]()
    var muteMap = [TouchMark]()
    
    // 貼りたいテクスチャ
    let smileTexture = SKTexture(imageNamed: "smile")
    let muteTexture = SKTexture(imageNamed: "mute")
    
    // 初期値が何を意味しているのか不明
    var tileSize = CGSize(width: 10.0, height: 10.0) //これは後で変えまくろう

    // マネして作っていますµ
    var touchMarkSize = CGSize(width: 10.0, height: 10.0)

    var mapWidth = 0
    var mapHeight = 0
    
    override func didMoveToView(view: SKView) {
    
        /*
        //背景設定としてfingerboardを表示
        let fingerBoard = SKSpriteNode(imageNamed: "fingerboard")

        //このSKSceneは大きさがGameViewに合っているので、中央画面いっぱいに表示しておけばよいです
        fingerBoard.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        fingerBoard.size = self.size // (224.0, 416.0)
        self.addChild(fingerBoard)
        */
        
        self.drawMap()
    }
    
    
    func drawMap(){
        //ファイル読み込みとあれこれ
        if let fileName = NSBundle.mainBundle().pathForResource("map", ofType: "csv") {
            self.loadMapData(fileName)
        }

        //最終描画
        for tile in self.tileMap{
            self.addChild(tile)
        }
        
        
    }
    
    /*
    FingerBoard描画のコアな部分
    */
    //大半はCSVのパースとサイズ合わせです
    func loadMapData(fileName: String){
        
        //CSVの内容を文字列として取り込み
        // swift2.0からError Handlingをする必要が...
        var fileString: String!
        do{
            fileString = try String(contentsOfFile: fileName, encoding: NSUTF8StringEncoding)
        }catch _ as NSError{
            
        }
        //改行区切りでsplit
        let lineList = fileString.componentsSeparatedByString("\n")

        //縦に並ぶタイル数
        self.mapHeight = lineList.count
        
        var index = 0
        
        //1行ずつ読み込み
        for line in lineList {
            //1行をカンマ区切り
            let tileStringList = line.componentsSeparatedByString(",")
            
            if self.mapWidth == 0 {
                //横に並ぶタイル数 = 6
                self.mapWidth = tileStringList.count
                
                // 1枚のタイルサイズは 画面の大きさ 割る タイルの枚数
                // self.frame = (224.0, 416.0)
                let tileWidth = Double(self.frame.width) / Double(self.mapWidth)

                //今はなんとなく大きさ有ってるけど、他機種対応ならheightもきちんと考えるべき
                self.tileSize = CGSize(width: tileWidth, height: tileWidth * 2)
                print("tilesize:")
                print(self.tileSize)
                print("self.frame.size: ")
                print(self.frame.size)
            }
            // 1文字ずつ.
            for tileString in tileStringList {
                // 数字読み込み
                let value = Int(tileString)
                
                // よく分からんがunwrapしているらしい
                if let type = TileType(rawValue: value!) {
                    
                    //index -> Int(x,y) で何番目のタイルか得る
                    let position: TilePosition = self.getTilePositionByIndex(index)
                    
                    //SpriteNode
                    //なんかimageNamedはmemory warningでるらしい...
                    //対策はinitWithContentesOfFileを使えとのこと.
                    let tile = Tile(imageNamed: tileString)
                    
                    // 実際にtile.positionに入れる時は、CGPointに変換が必要
                    tile.position = self.getPointByTilePosition(position)
                    tile.size = self.tileSize
                    tile.type = type
                    
//                    print(index)
//                    print(" posi: ")
//                    print(position.x)
//                    print(", ")
//                    print(position.y)

                    //mapというか配列?に追加
                    self.tileMap.append(tile)
                    
                }
                //忘れずにインクリメント
                index++
            }

        }

    }
    
    
    /*
     Int(index) -> Int(x,y)として順番が得られる
     ex.) タイルが横3枚、縦5枚の場合
     index = 7 -> TilePosition = (1, 3)
     すなわち、7番目のタイルは 3行目 の 1+1=2 列目 ですよ
    */
    func getTilePositionByIndex(index: Int) -> TilePosition {
        return TilePosition(x: index % self.mapWidth, y: index / self.mapHeight)
    }
    
    //超簡単だけど一応作っておく
    func getIndexByTilePosition(tp: TilePosition) -> Int {
        return tp.x + tp.y * mapWidth
    }
    
    /*
     Int(x, y) -> CGPoint(x, y)にする
     spriteKitは左下が原点
     positionはSpriteの位置(中心点)を示すもの.
     ちなみに、マイナス座標にも正しくタイル貼れます
    */
    func getPointByTilePosition(position: TilePosition) -> CGPoint {
        
        //たぶんここを0.5にできたら解決する (CGFloatはよく分からん...)
        let x = ( CGFloat(position.x) + 0.5) * self.tileSize.width

        //今は偶然全画面っぽく見えているだけ.
        let y = self.frame.size.height - CGFloat(position.y) * self.tileSize.height

        return CGPoint(x: x, y: y)
    }
    
    // positionからタイルindexを得る(楽)
    func getIndexByPosition(position: TilePosition) -> Int{
        return position.y * self.mapWidth + position.x
    }
    
    /* 
    pointからtilePisitionを得る
    x: 簡単, pointをタイル幅で割るだけ.
    y: 現状全画面ではない、というか1行目の上半分がはみだしているのでこんな感じか.
    */
    func getTilePositionByPoint(point: CGPoint) -> TilePosition {
        let x = point.x / self.tileSize.width
        
        let y = (self.frame.size.height - point.y + self.tileSize.height / 2) / self.tileSize.height
        
        return TilePosition(x: Int(x), y: Int(y))
    }
    
    // 手前が6弦、奥が1弦なので変換が必要
    func getTilePositionByFretPosition(fp: FretPosition) -> TilePosition{
        return TilePosition(x: 6 - fp.order, y: fp.fret)
    }
    
    
    /*
    baseを基準とした音程差を求める
    */
    func getPitchInterval(base: Pitch, other: Pitch) -> Int{
        
        //うまいこと計算出来る
        //let baseScore = self.getMyToneNumber() + 12 * self.height
        //let otherScore = pitch.getMyToneNumber() + 12 * pitch.height
        let baseScore = base.toneNumber + 12 * base.height
        let otherScore = other.toneNumber + 12 * other.height
        return otherScore - baseScore
    }

    // ある音のある弦における運指(ポジション)を求めます
    func getFretNumberFromPitchAndOrder(pitch: Pitch, order: Int) -> Int{
        
        //開放弦のtoneNumberを得たい
        //とはいえ、それがこのメソッド内にあるのはおかしい気がする...
        
        //弦ごとに開放弦違いますよね
        var openPitch: Pitch
        
        switch order {
        case 1:
            openPitch = Pitch(name: "E", height: 4)
        case 2:
            openPitch = Pitch(name: "B", height: 3)
        case 3:
            openPitch = Pitch(name: "G", height: 3)
        case 4:
            openPitch = Pitch(name: "D", height: 3)
        case 5:
            openPitch = Pitch(name: "A", height: 2)
        case 6:
            openPitch = Pitch(name: "E", height: 2)
        default:
            return -1
        }
        
        // 開放弦を基準として、自分の音との音程差を求めます
        // それがすなわち押さえるポジションです
        return getPitchInterval(openPitch, other: pitch)
        
        //let random = Int(arc4random_uniform(UInt32(5)))
        //return random
        
    }

    
    /* 
     TableViewから呼び出されるメソッド
     コード無かったらどうすんのｗ？
    */
    func touchedTableViewCell(chord: Chord){
        
        chord.showContents()
        print(chord.type.rawValue)
        
        // touchMapが空でなければノードと要素を消したい
        if touchMarkMap.isEmpty != true {

            // ノードを消す
            for node in touchMarkMap {
                node.removeFromParent()
            }
            // 配列からも消す
            touchMarkMap.removeAll(keepCapacity: true)
        }
        
        // 同様にmuteMapに対しても.
        if muteMap.isEmpty != true {
            for mute in muteMap {
                mute.removeFromParent()
            }
            muteMap.removeAll(keepCapacity: true)
        }
        

        //1弦ずつ見ていく.
        //for (i, pitch) in enumerate(chord.contents.content){
        for (i, pitch) in chord.contents.content.enumerate() {
            // 弦の名前(1~6弦)
            let order = i + 1
            
            // orderにおける運指を得る
            
            if pitch.name != "N" {
                
                //let fretNumber = pitch.getFretNumberFromOrder(order)
                let fretNumber = getFretNumberFromPitchAndOrder(pitch, order: order)
                let fretPosition = FretPosition(order: order , fret: fretNumber)
                
                print("fingering ")
                print(order)
                print(" ")
                print(fretNumber)
                
                /*
                押さえるべきフレットにマークを表示させる
                fret == 0 つまり開放弦の場合は 何も表示させない。
                */
                
                if fretNumber > 0 {
                    // fretPositionから表示すべきタイルの位置を決めよう
                    // まずfretPositionをtilePositionに変換する
                    let position = getTilePositionByFretPosition(fretPosition)
                    
                    // ノードを表示すべき中心点を求めよう
                    let point = getPointByTilePosition(position)
                    
                    // posintにノードを貼り、配列に登録
                    let node = TouchMark(texture: smileTexture)
                    
                    // 位置登録
                    node.position = point
                    
                    // サイズをキメます(サイズは便利そうなのでプロパティに保持している)
                    touchMarkSize.width = tileSize.width * 0.9
                    node.size = CGSize(width: touchMarkSize.width, height: touchMarkSize.width)
                    
                    // TilePositionも保持しとく
                    node.tilePosition = position
                    
                    // 配列に登録する(描画はまとめて行う)
                    touchMarkMap.append(node)
                    
                }

                
            }
                /*
                muteにはmute画像を貼る
                mute = ("N", 0)
                */

            else // chord.name == "N"
            {
                // prprintmute")

                // 表示中心位置は3フレット目
                let position = getTilePositionByFretPosition(FretPosition(order: order, fret: 3))

                //このへん処理が同じだからまとめるべきかも
                let point = getPointByTilePosition(position)
   
                let mute = TouchMark(texture: muteTexture)
                
                // 位置登録
                mute.position = point
                
                // サイズをキメます
                mute.size = CGSize(width: tileSize.width * 0.8, height: tileSize.height * 4.5)
                
                // TilePositionも保持
                mute.tilePosition = position
                
                // 配列に登録する(描画はまとめて行う)
                muteMap.append(mute)

            }
            
        }
        
        //最後にまとめて表示
        for node in touchMarkMap {
            self.addChild(node)
        }
        for mute in muteMap {
            self.addChild(mute)
        }
        
    }
    
    
    func test(){

        print("ypaaaa")
    }
    
    
    //タッチイベント取得
    //    しかし、単純にtapCountによって処理を分けようとすると、"[touch tapCount] == 2"の処理の前に"[touch tapCount] == 1"の処理が動いてしまいます。
    //    touchesEnded:withEvent:が2回呼ばれて、1回目にシングルタップの処理、2回目にダブルタップの処理、という具合に動くからです。
    
    // テスト用のActionNode
    let rotate = SKAction.rotateByAngle(CGFloat(M_PI * 2), duration: 1)
    let fadeOut = SKAction.fadeOutWithDuration(1.0)
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //マルチタッチに対応したいならイテレータ回す
        for touch: AnyObject in touches {

            // pointは左下原点のspriteになっています
            let point: CGPoint = touch.locationInNode(self)
            
            // どのタイルをタッチされているのかを判定.
            let position = getTilePositionByPoint(point)
            let index = getIndexByPosition(position)

            // タッチされたタイルを回転させる
            tileMap[index].runAction(rotate)
            
            // タイルに登録されているピッチの音を鳴らす

            let pitchName = tileMap[index].pitch.name + tileMap[index].pitch.height.description
            
            let sound = SKAction.playSoundFileNamed("\(pitchName).mp3", waitForCompletion: false)
            tileMap[index].runAction(sound, completion: ({
                print(pitchName)
            }))

            
            // 配列に保持しているsmileのpositionと一致したならば、smileを消す
            if touchMarkMap.isEmpty != true {
                for touchMark in touchMarkMap {
                    if position.isEqual(touchMark.tilePosition) {
                        touchMark.runAction(fadeOut)
                    }
                }
            }
            
            
        }
        
        
    }
    
    
}
