//
//  GameScene.swift
//  HelpNagoyaSpecialty
//
//  Created by denjo on 2015/08/22.
//  Copyright (c) 2015年 denjo. All rights reserved.
//

import Foundation
import SpriteKit

//衝突判定も加える
class GameScene: SKScene, SKPhysicsContactDelegate {

    //背景
    var background: SKSpriteNode?
    //どんぶり
    var bowl: SKSpriteNode?
    
    //タイマー
    var timer: NSTimer?
    
    //落下判定用シェイプ
    var lowestShape: SKShapeNode?
    
    //スコアまわりのプロパティ
    var score = 0
    var scoreLabel: SKLabelNode?
    let scoreList = [100, 200, 300, 500, 800, 1000, 1500]
    
    //シーンがビューに表示されたときに呼ばれるメソッド(オブジェクト初期化など)
    override func didMoveToView(view: SKView) {
        //下方向に重力を設定
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)

        //delegateMethodを使用する準備
        self.physicsWorld.contactDelegate = self
        
        //背景スプライトを設定
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        background.size = self.size
        self.addChild(background)
        self.background = background
        
        //落下検知用シェイプノードを追加
        let lowestShape = SKShapeNode(rectOfSize: CGSize(width: self.size.width*3, height: 10))
        lowestShape.position = CGPoint(x: self.size.width*0.5, y: -10)
        
        //シェイプに合わせてPhisicsBody生成
        let physicsBody = SKPhysicsBody(rectangleOfSize: lowestShape.frame.size)
        physicsBody.dynamic = false //落ちないように
        physicsBody.contactTestBitMask = 0x1 << 1 //衝突検知する対象のビットマスクを指定(なんか0以外ならいいらしい)
        lowestShape.physicsBody = physicsBody
        
        self.addChild(lowestShape)
        self.lowestShape = lowestShape
        
        //どんぶり追加
        let bowlTexture = SKTexture(imageNamed: "bowl")
        let bowl = SKSpriteNode(texture: bowlTexture)
        bowl.position = CGPoint(x: self.size.width*0.5, y: 100) //中央下あたり
        bowl.size = CGSize(width: bowlTexture.size().width*0.5, height: bowlTexture.size().height*0.5)
        //PhisicsBody追加
        bowl.physicsBody = SKPhysicsBody(texture: bowlTexture, size: bowl.size)

        //どんぶりは落下しないように
        bowl.physicsBody?.dynamic = false
        
        //プロパティに入れておく
        self.bowl = bowl
        //表示
        self.addChild(bowl)
        
        //スコアラベル作成
        var scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.position = CGPoint(x: self.size.width*0.92, y: self.size.height * 0.78)
        scoreLabel.text = "¥0"
        scoreLabel.fontSize = 32
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right //右寄せ
        scoreLabel.fontColor = UIColor.greenColor()
        self.addChild(scoreLabel)
        self.scoreLabel = scoreLabel
        
        //落下させる
        self.fallNagoyaSpecialty()
        
        //タイマー生成
        //1:間隔、2:ターゲットオブジェクト、3:呼び出すメソッド、4:任意のオブジェクトをメソッドに渡すもの、5:繰り返すのか否か
        self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "fallNagoyaSpecialty", userInfo: nil, repeats: true)
    }
    
    //落下させる
    func fallNagoyaSpecialty() {
        //乱数0~6
        let index = Int(arc4random_uniform(7))
        
        //テクスチャ読み込み
        let texture = SKTexture(imageNamed: "\(index)")

        //スプライトにテクスチャを貼る
        let sprite = SKSpriteNode(texture: texture)

        //スプライト位置はシーンの中央上部、スプライトサイズはテクスチャサイズの半分
        sprite.position = CGPointMake(self.size.width*0.5, self.size.height)
        sprite.size = CGSize(width: texture.size().width*0.5, height: texture.size().height*0.5)
        
        //テクスチャを元にしてPhisicsBodyを作成
        sprite.physicsBody = SKPhysicsBody(texture: texture, size: sprite.size)
        
        //衝突検知用
        sprite.physicsBody?.contactTestBitMask = 0x1 << 1
        
        self.addChild(sprite)
        
        //スコア計算と更新
        self.score += self.scoreList[index]
        self.scoreLabel?.text = "¥\(self.score)"
        
    }
    
    //タッチ開始時の座標が引数になってる(マルチタッチ対応なのでSetになってる)
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

        //指1本分の座標取得
        if let touch: AnyObject = touches.first {
            //スクリーン上の座標データをシーン上の座標に固定
            let location = touch.locationInNode(self)

            //アクション生成、左右のみの動きにする
            let action = SKAction.moveTo(CGPoint(x: location.x, y: 100), duration: 0.2)
            //スプライトで実行
            self.bowl?.runAction(action)
        }
        //リスタート
        if self.paused == true {
            self.removeAllChildren()
            self.paused = false
            self.addChild(self.background!)
            self.addChild(self.bowl!)
            self.score = 0
            self.scoreLabel?.text = "¥\(self.score)"
            self.addChild(scoreLabel!)
            self.addChild(lowestShape!)
            lowestShape?.physicsBody?.contactTestBitMask = 0x1 << 1
            fallNagoyaSpecialty()
            self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "fallNagoyaSpecialty", userInfo: nil, repeats: true)
        }
    }
    
    //こちらはドラッグ時
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        //指1本分の座標取得
        if let touch: AnyObject = touches.first {
            //スクリーン上の座標データをシーン上の座標に固定
            let location = touch.locationInNode(self)
            
            //アクション生成、左右のみの動きにする
            let action = SKAction.moveTo(CGPoint(x: location.x, y: 100), duration: 0.2)
            //スプライトで実行
            self.bowl?.runAction(action)
        }
    }
 
    //衝突開始時(delegate必要)
    func didBeginContact(contact: SKPhysicsContact) {
        //lowestShapeが衝突検知するとき実行
        if contact.bodyA.node == self.lowestShape || contact.bodyB.node == self.lowestShape {
            //GAMEOVERのスプライトを生成して表示
            let sprite = SKSpriteNode(imageNamed: "gameover")
            sprite.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
            self.addChild(sprite)
            
            //現在動いているアクションを全て停止する
            self.paused = true
            
            //タイマー止める
            self.timer?.invalidate()
            
            //tap to restartを表示する
            var restart = SKLabelNode(fontNamed: "Helvetica")
            restart.position = CGPoint(x: self.size.width*0.5, y: self.size.height * 0.4)
            restart.text = "Tap to restart"
            restart.fontSize = 32
            restart.fontColor = UIColor.blueColor()
            self.addChild(restart)
            
        }
    }
    
    
}
