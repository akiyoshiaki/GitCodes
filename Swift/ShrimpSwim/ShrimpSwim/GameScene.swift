//
//  GameScene.swift
//  ShrimpSwim
//
//  Created by denjo on 2015/08/24.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    //各ノード
    var _baseNode: SKNode!
    var _coralNode: SKNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

        //ルートノード作成
        _baseNode = SKNode()
        _baseNode.speed = 1.0
        self.addChild(_baseNode)
        
        //障害物のルートノード
        _coralNode = SKNode()
        _baseNode.addChild(_coralNode)
        
        //背景画像を構築
        self.setupBackgroundSea()
        
        //岩召喚
        self.setupBackgroundRock()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */

    
    }
    
    func setupBackgroundSea() {
        
        //背景画像
        let texture = SKTexture(imageNamed: "background")
        texture.filteringMode = .Nearest //プロパティは処理速度優先で
        
        //必要な画像枚数は...
        //画面の横幅　/ 背景画像の横幅
        let needNumber = 2.0 + (self.frame.size.width / texture.size().width)
        
        //アニメーション作成
        let moveAnim = SKAction.moveByX(-texture.size().width , y: 0.0, duration: NSTimeInterval(texture.size().width / 10.0))
        let resetAnim = SKAction.moveByX(-texture.size().width , y: 0.0, duration: 0.0)
        let repeatForeverAnim = SKAction.repeatActionForever(SKAction.sequence([moveAnim,resetAnim]))
    
        //画像の配置とアニメーションを設定
        //必要な枚数分動かす
        for var i: CGFloat = 0; i < needNumber; ++i {
            let sprite = SKSpriteNode(texture: texture)
            sprite.zPosition = -100.0 //奥行き表現
            sprite.position = CGPoint(x: i * sprite.size.width, y: self.frame.size.height / 2.0) //横にずらしていく
            sprite.runAction(repeatForeverAnim)
            _baseNode.addChild(sprite)
        }
    }
    
    func setupBackgroundRock() {
        //岩山(下)
        let under = SKTexture(imageNamed: "rock_under")
        under.filteringMode = .Nearest
        
        //必要枚数
        var needNumber = 2.0 + (self.frame.size.width / under.size().width)
        
        //アニメーション作成
        let moveUnderAnim = SKAction.moveByX(-under.size().width , y: 0.0, duration: NSTimeInterval(under.size().width / 20.0)) //20ピクセル%秒,背景より速め
        let resetUnderAnim = SKAction.moveByX(under.size().width , y: 0.0, duration: 0.0)
        let repeatForeverUnderAnim = SKAction.repeatActionForever(SKAction.sequence([moveUnderAnim,resetUnderAnim]))

        //画像の配置とアニメーションを設定
        for var i: CGFloat = 0; i < needNumber; ++i {
            let sprite = SKSpriteNode(texture: under)
            sprite.zPosition = -50.0 //背景より手前
            sprite.position = CGPoint(x: i * sprite.size.width, y: self.frame.size.height / 2.0) //横にずらしていく
            sprite.runAction(repeatForeverUnderAnim)
            _baseNode.addChild(sprite)
        }

        //岩山(下)
        let above = SKTexture(imageNamed: "rock_above")
        above.filteringMode = .Nearest
        
        //必要枚数
        needNumber = 2.0 + (self.frame.size.width / above.size().width)
        
        //アニメーション作成
        let moveAboveAnim = SKAction.moveByX(-above.size().width , y: 0.0, duration: NSTimeInterval(above.size().width / 20.0)) //20ピクセル%秒,背景より速め
        let resetAboveAnim = SKAction.moveByX(above.size().width , y: 0.0, duration: 0.0)
        let repeatForeverAboveAnim = SKAction.repeatActionForever(SKAction.sequence([moveAboveAnim,resetAboveAnim]))
        
        //画像の配置とアニメーションを設定
        for var i: CGFloat = 0; i < needNumber; ++i {
            let sprite = SKSpriteNode(texture: above)
            sprite.zPosition = -50.0 //背景より手前
            sprite.position = CGPoint(x: i * sprite.size.width, y: self.frame.size.height - (sprite.size.height / 2.0)) //位置に注意
            sprite.runAction(repeatForeverAboveAnim)
            _baseNode.addChild(sprite)
        }
        
    }
    
}


