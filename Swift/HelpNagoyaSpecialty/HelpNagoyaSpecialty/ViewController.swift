//
//  ViewController.swift
//  HelpNagoyaSpecialty
//
//  Created by denjo on 2015/08/22.
//  Copyright (c) 2015年 denjo. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
        //シーンの作成
        let scene = GameScene()
        
        //ViewControllerのViewをSKViewとして取り出す
        let view = self.view as! SKView
        
        //FPSの表示
        view.showsFPS = true
        //ノード数の表示
        view.showsNodeCount = true
        
        //シーンのサイズをビューに合わせる
        scene.size = view.frame.size
        
        //ビュー上にシーンを表示
        view.presentScene(scene)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

