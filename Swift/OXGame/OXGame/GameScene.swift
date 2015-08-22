//
//  GameScene.swift
//  OXGame
//
//  Created by denjo on 2015/08/21.
//  Copyright (c) 2015年 denjo. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
 
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }

    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0, y: 0) //座標
        
        //静止画像の表示
        let background = SKSpriteNode(imageNamed: "bg")
        background.position = CGPoint(x: 30, y: 30)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        
        //自分自身に画像オブジェクトをaddChildして表示される
        addChild(background)
        
    }
    
}


