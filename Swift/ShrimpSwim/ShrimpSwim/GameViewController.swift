//
//  GameViewController.swift
//  ShrimpSwim
//
//  Created by denjo on 2015/08/24.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.
//

import UIKit
import SpriteKit

//SKNodeを削除

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //シーン作成
        let scene = GameScene()
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        scene.size = skView.frame.size
        
        skView.presentScene(scene)
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    //複数デバイス対応するならここ
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
