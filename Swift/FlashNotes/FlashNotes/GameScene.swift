//
//  GameScene.swift
//  FlashNotes
//
//  Created by denjo on 2015/08/23.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.
//

import Foundation
import SpriteKit
import Darwin

/* TODOリスト
    * タイマーを使ってゲームを進めているが、それ以外の逐次的に進める方法はないのか？
    済 * レベルを選択してハイレベルの選択ができるように
        * そのためには最初に1枚画面用意せねば...
    * ライフ、というよりもタイマーで区切った方がいいのでは？
    済 * ライフは♡で表示
    * 音符表示
*/
class GameScene: SKScene {
  
    
    //カウンター(ゴミコード)
    var _counter: Int = 0
    
    //タイマー
    var _quizTimer: NSTimer?
    var _limitTimer: NSTimer?
    
    //残り時間
    var _time: Int = 0
    
    //背景
    var _bg: SKSpriteNode?
    
    //五線譜
    var _stuff: SKSpriteNode?
    
    //OK,NGマーク
    var _ok: SKSpriteNode?
    var _ng: SKSpriteNode?
    
    //tap to restart
    var _start: SKSpriteNode?
    //鳴っている音をタッチしてね
    var _ringing: SKSpriteNode?
    //GAMEOVER
    var _gameover: SKSpriteNode?
    //back
    var _back: SKSpriteNode?
    
    //音が鳴っているかを管理するフラグ
    var _toneId: Int = -1
    
    //gameoverフラグ
    var _isGameOver: Bool = false

    //音の数
    var _toneNumber: Int = 0
    
    //クイズの間隔
    var _interval: Double = 4
    
    //ランダムで音かぶりしないようにするための変数
    var _index: Int = -1
    var _preIndex: Int = -1
    
    //正解フラグ(正解1, 不正解0, その他-1)
    var _state: Int = 0
 
    //スコアとライフのプロパティ
    var _score = 0
    var _scoreLabel: SKLabelNode?
    var _life = 3
    var _timerLabel: SKLabelNode?
    
    //音名たち
    let _TONES: [String] = ["DO", "RE", "MI", "FA", "SOL", "LA", "TI"]
    
    //宣言に注意...
    var _toneNodes: Array<SKSpriteNode?> = [nil, nil, nil, nil, nil, nil, nil]
    var _hearts: Array<SKSpriteNode?> = [nil, nil, nil]

    
    //ボタンの大きさを持っておくタプル
    //var _toneSize: (x: CGFloat?, y: CGFloat?)
    
    //ボタンの大きさに関連する変数を持つタプル
    var _tonePosition: (upper: CGFloat?, lower: CGFloat?, width: CGFloat?, height: CGFloat?)
    
    
    override func didMoveToView(view: SKView) {
        
        //背景設定
        let bg = SKSpriteNode(imageNamed: "bg")
        bg.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        bg.size = self.size
        self.addChild(bg)
        self._bg = bg
        
        //五線譜
        let stuff = SKSpriteNode(imageNamed: "stuff")
        stuff.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        stuff.size = CGSize(width: self.size.width*0.98, height: self.size.height*0.23)
        self.addChild(stuff)
        self._stuff = stuff
        
        //先にマルとバツも作って透明にしておく
        let ok = SKSpriteNode(imageNamed: "OK")
        ok.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        //stuff.size = CGSize(width: self.size.width*0.98, height: self.size.height*0.23)
        ok.alpha = 0.01
        self.addChild(ok)
        self._ok = ok
        
        let ng = SKSpriteNode(imageNamed: "NG")
        ng.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        //stuff.size = CGSize(width: self.size.width*0.98, height: self.size.height*0.23)
        ng.alpha = 0.01
        self.addChild(ng)
        self._ng = ng

        //わりと重要？
        ViewController.level == "easy" ? (_toneNumber = 4) : (_toneNumber = 7)
        
        //先にボタン作って透明にしておく
        for i in 0..<self._toneNodes.count {
            //let i = self._counter
            let tone = SKSpriteNode(imageNamed: "\(self._TONES[i]).png")
            var tmp1, tmp2: CGFloat //このへんキャストはまりやすい...
            //ボタンの位置づくり
            if i <= 3 {
                tmp1 = 0.20 + 0.20 * CGFloat(i)
                tmp2 = 0.30
            } else {
                tmp1 = 0.30 + 0.20 * CGFloat(i - 4)
                tmp2 = 0.20
            }
            tone.position = CGPoint(x: self.size.width * tmp1, y: self.size.height * tmp2)
            tone.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.05)
            //透明にしておく
            tone.alpha = 0.01
            self.addChild(tone)
            self._toneNodes[i] = tone
        }
        
        //スコアラベル作成
        var scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.position = CGPoint(x: self.size.width*0.93, y: self.size.height * 0.79)
        scoreLabel.text = "スコア: 0"
        scoreLabel.fontSize = 26
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right //右寄せ
        scoreLabel.fontColor = UIColor.blueColor()
        self.addChild(scoreLabel)
        self._scoreLabel = scoreLabel

        //タイマーラベル作成(最初は難易度を書いておく)
        var timerLabel = SKLabelNode(fontNamed: "Helvetica")
        timerLabel.position = CGPoint(x: self.size.width*0.06, y: self.size.height * 0.79)
        timerLabel.text = "\(ViewController.level)"
        timerLabel.fontSize = 26
        timerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left //左寄せ
        timerLabel.fontColor = UIColor.blueColor()
        self.addChild(timerLabel)
        self._timerLabel = timerLabel
        
        //tap to startを透明で
        let start = SKSpriteNode(imageNamed: "tap")
        start.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.15)
        start.size = CGSize(width: self.size.width*0.6, height: self.size.height*0.1)
        //透明にしておく
        start.alpha = 0.01
        self.addChild(start)
        self._start = start

        //「鳴っている音をタップ！」を透明で
        let ringing = SKSpriteNode(imageNamed: "ringing")
        ringing.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.65)
        ringing.size = CGSize(width: self.size.width*0.8, height: self.size.height*0.10)
        ringing.alpha = 0.01
        self.addChild(ringing)
        self._ringing = ringing
        
        // please back to titleを透明で
        let back = SKSpriteNode(imageNamed: "back")
        back.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.65)
        back.size = CGSize(width: self.size.width*0.8, height: self.size.height*0.10)
        back.alpha = 0.01
        self.addChild(back)
        self._back = back
        
        //レベルに応じて間隔を変える
        switch ViewController.level {
            case "easy":
                _interval = 5.0
            case "normal":
                _interval = 4.0
            case "hard":
                _interval = 2.4
            default:
                _interval = 4.0
        }
        
        
        //タイマー生成してサンプルの音鳴らすしかないか...
        //1:間隔、2:ターゲットオブジェクト、3:呼び出すメソッド、4:任意のオブジェクトをメソッドに渡すもの、5:繰り返すのか否か
        self._counter = 0
        self._quizTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "makeSoundNode", userInfo: nil, repeats: true)
        
    }

    //結局ボタン作るのと音出すのを同じようにやることに
    //alpha値を切り替えてうまくできそう。
    func makeSoundNode() {
        
        //toneNumberまで来たら鳴らすのやめる
        if self._counter >= _toneNumber {
            //タイマーを止める
            self.paused = true
            self._quizTimer?.invalidate()

            //tap to start
            _start?.alpha = 1.0
            
            //ボタンの位置に関連する変数を格納
            self._tonePosition.upper = self._toneNodes[0]!.position.y
            self._tonePosition.lower = self._toneNodes[4]!.position.y
            self._tonePosition.width = self._toneNodes[0]!.size.width
            self._tonePosition.height = self._toneNodes[0]!.size.height
            
            
        //ドからシまで
        } else{
            let i = self._counter
            let sound = SKAction.playSoundFileNamed("\(self._TONES[i]).mp3", waitForCompletion: false)
            self.runAction(sound, completion: ({
                self.soundCorrespond(self._toneNodes[i]!) //音鳴らして透明解除?
            }))
            self._counter += 1
        }
    }

    /*
     * ゲームに関すること
     */
    func playGame(){
        
        /*
         * もし正解フラグが立っていない状態でplayGameが呼ばれたら、時間切れで不正解とする。
         */
        if _state < 0 { //回答せずに呼ばれたら時間切れ不正解とする
            self.wrongAction()
            //この時の時間処理はどうする...?
        }
        else{//前状態が正解 or 不正解ならタッチを受け付ける

            _state = -1
            
            //タイマー再開
            if _limitTimer?.valid == false{
                _limitTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: true)
            }
            //ゲームが始まった時にマルバツを消す
            self._ok?.alpha = 0.01
            self._ng?.alpha = 0.01
            
            //レベルに応じた乱数
            _index = Int(arc4random_uniform((UInt32) (_toneNumber)))
            while _index == _preIndex {
                _index = Int(arc4random_uniform((UInt32) (_toneNumber)))
            }
            _preIndex = _index
            
            //プロパティに格納
            self._toneId = _index
            
            
            //音鳴らす
            let sound = SKAction.playSoundFileNamed("\(self._TONES[_index]).mp3", waitForCompletion: false)
            self.runAction(sound, completion: ({
                //self.soundCorrespond(self._toneNodes[index]!)
            }))

        }
        

    }
    
    //カウントダウンするだけ
    func countDown() {

        _time += -1
        
        //ラベル更新
        _timerLabel?.text = "タイム:\(_time)"
        
        //時間切れでゲームオーバー
        if _time <= 0 {
            self.gameOver()
        }
    }
    
    //3秒待たせた後にタイマー再開
    func wait(){
        _quizTimer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "playGame", userInfo: nil, repeats: true)
    }
    
    //色をつけるアニメーション
    func soundCorrespond(tone: SKSpriteNode) {
        //let rotate = SKAction.rotateByAngle(CGFloat(M_PI)*2, duration: 2)
        //tone.runAction(rotate)
        tone.alpha = 1.0
        let colorize = SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 3, duration: 0.1)
        tone.runAction(colorize)
    }
    
    //色を戻すアニメーション
    func resetColor(tone: SKSpriteNode){
        let colorize = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 3, duration: 0.1)
        tone.runAction(colorize)
    }
    
    //正解時に行いたい動作
    func correctAction(){
        //タイマー止める
        _limitTimer?.invalidate()
        //_quizTimer?.invalidate()
        
        //画像表示と音を鳴らす
        self._ok?.alpha = 1.0
        let sound = SKAction.playSoundFileNamed("OK.mp3", waitForCompletion: true)
        self.runAction(sound, completion: ({
            //
            sleep(2)
        }))
        //正解フラグ
        _state = 1
        //スコア計算と更新
        self._score += 1
        self._scoreLabel?.text = "スコア: \(self._score)"
        
    }
    
    //不正解時に行いたい動作
    func wrongAction(){
        //タイマー止める
        _limitTimer?.invalidate()
        //_quizTimer?.invalidate()
        
        //3秒待たせる
        //_quizTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "wait", userInfo: nil, repeats: true)
        
        //画像表示と音を鳴らす
        self._ng?.alpha = 1.0
        let sound = SKAction.playSoundFileNamed("NG.mp3", waitForCompletion: true)
        self.runAction(sound, completion: ({
            //鳴り終わってから2秒待つ
            sleep(2)

        }))
        //不正解フラグ
        _state = 0
        
        //ライフを減らす
        self._life += -1
        
        //ライフ消す
        if _life >= 0 {
            let fade = SKAction.fadeOutWithDuration(0.8)
            _hearts[_life]?.runAction(fade)
            
        }else{ //ライフが0になったらゲームオーバー
            self.gameOver()
            
        }
   
    }
    
    //ライフが0、もしくは時間切れでゲームオーバー
    func gameOver() {
        let gameover = SKSpriteNode(imageNamed: "gameover")
        gameover.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        self.addChild(gameover)
        self._gameover = gameover
        
        _back?.alpha = 1.0
        _ringing?.alpha = 0.01
        
        //いろいろ止める
        self.paused = true
        //タイマー止まんない...
        _quizTimer?.invalidate()
        _limitTimer?.invalidate()

        //フラグ
        _isGameOver = true
    }
    
    
    //タッチ開始時の座標が引数になってる(マルチタッチ対応なのでSetになってる)
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //指1本分の座標取得
        if let touch: AnyObject = touches.first {
            /*
             * ゲームスタート
             * ゲームオーバー時は前の画面に戻らせたい
             */
            if self.paused == true {
                
                if _isGameOver == true {
                    
                }
                else {
                    
                    self.paused = false
                    for t in self._toneNodes {
                        resetColor(t!)
                    }
                    //startは消す
                    _start?.alpha = 0.01
                    
                    //gameoverも消す
                    _gameover?.alpha = 0.01
                    
                    //「鳴っている音をタップ」出す
                    _ringing?.alpha = 1.0
                    
                    //ライフも出す
                    let texture = SKTexture(imageNamed: "heart")
                    var tmp: CGFloat
                    for i in 0..<_hearts.count {
                        tmp = 0.35 + 0.15 * CGFloat(i)
                        _hearts[i] = SKSpriteNode(texture: texture)
                        _hearts[i]!.position = CGPoint(x: self.size.width * tmp, y: self.size.height * 0.1)
                        self.addChild(_hearts[i]!)
                    }
                    
                    //スコアとライフを初期化する
                    self._score = 0
                    self._life = 3
                    self._scoreLabel?.text = "スコア: \(self._score)"
                    
                    //タイマーでゲームやるしかもう分からん
                    //playGameを繰り返させる
                    //難易度ごとに時間を変えたい！
                    playGame()
                    self._quizTimer = NSTimer.scheduledTimerWithTimeInterval(_interval, target: self, selector: "playGame", userInfo: nil, repeats: true)

                    //30秒間のタイマー発動
                    _time = 10
                    self._limitTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: true)
                    
                }
                //通常のタッチ時
            } else {
                
                //ゲーム始まってタッチされたら考える
                if self._toneId >= 0{
                    let location = touch.locationInNode(self)
                    let index = detectPosition(location.x, y: location.y)
                    
                    //音ノードをタッチされた場合
                    if index >= 0{
                        
                        //タッチされた音をまず鳴らす
                        let sound = SKAction.playSoundFileNamed("\(self._TONES[index]).mp3", waitForCompletion: false)
                        self.runAction(sound, completion: ({
                            //
                        }))
                        
                        /*
                         * Idが一致したら正解,違えば不正解
                         */
                        if index == self._toneId {
                            self.correctAction()
                        }else{
                            self.wrongAction()
                        }
                    }
                }
            }
        }
    }
    
    //押された位置を検出してindexを返す
    func detectPosition(x: CGFloat, y: CGFloat)-> Int {
        //正解 or 不正解がわかっている時は入力を受け付けない
        if _state >= 0 {
            return -1
        } else{
            
            //上の列
            if y > self._tonePosition.upper! - self._tonePosition.height! * 0.5 && y < self._tonePosition.upper! + self._tonePosition.height! * 0.5 {
                if x > self._toneNodes[0]!.position.x - self._tonePosition.width! * 0.5 && x < self._toneNodes[0]!.position.x + self._tonePosition.width! * 0.5{
                    print(self._TONES[0])
                    return 0
                }
                else if x > self._toneNodes[1]!.position.x - self._tonePosition.width! * 0.5 && x < self._toneNodes[1]!.position.x + self._tonePosition.width! * 0.5{
                    print(self._TONES[1])
                    return 1
                }
                else if x > self._toneNodes[2]!.position.x - self._tonePosition.width! * 0.5 && x < self._toneNodes[2]!.position.x + self._tonePosition.width! * 0.5{
                    print(self._TONES[2])
                    return 2
                }
                else if x > self._toneNodes[3]!.position.x - self._tonePosition.width! * 0.5 && x < self._toneNodes[3]!.position.x + self._tonePosition.width! * 0.5{
                    print(self._TONES[3])
                    return 3
                }
                else { //その他
                    return -1
                }
            }
            //easyなら上の列だけでいいや
            if ViewController.level != "easy" {
                if y > self._tonePosition.lower! - self._tonePosition.height! * 0.5 && y < self._tonePosition.lower! + self._tonePosition.height! * 0.5{
                    if x > self._toneNodes[4]!.position.x - self._tonePosition.width! * 0.5 && x < self._toneNodes[4]!.position.x + self._tonePosition.width! * 0.5{
                        print(self._TONES[4])
                        return 4
                    }
                    else if x > self._toneNodes[5]!.position.x - self._tonePosition.width! * 0.5 && x < self._toneNodes[5]!.position.x + self._tonePosition.width! * 0.5{
                        print(self._TONES[5])
                        return 5
                    }
                    else if x > self._toneNodes[6]!.position.x - self._tonePosition.width! * 0.5 && x < self._toneNodes[6]!.position.x + self._tonePosition.width! * 0.5{
                        print(self._TONES[6])
                        return 6
                    }
                    else { //その他
                        return -1
                    }
                }
                else { //その他
                    return -1
                }
            }
            else {//easyでは下の段いらない
                return -1
            }
        }
    }
}