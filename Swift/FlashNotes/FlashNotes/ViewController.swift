//
//  ViewController.swift
//  FlashNotes
//
//  Created by denjo on 2015/08/23.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    var scene: GameScene?

    //ここに静的メンバ変数として保持しておけば任意の箇所でアクセス可能
    //(型プロパティ)
    static var level: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        
        //シーン作成
        //あとは全てGameSceneがやります
        scene = GameScene()
       
        //Viewを直す！！
        let view = self.view as! SKView
        
        view.showsFPS = true
        view.showsNodeCount = true
        //なんかうまく大きさ調節できない。
        scene!.size = view.frame.size
        //scene?.scaleMode = SKSceneScaleMode.AspectFit
        view.presentScene(scene)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

