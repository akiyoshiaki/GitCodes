////
////  ViewController.swift
////  MyOmikujiApp
////
////  Created by denjo on 2015/08/19.
////  Copyright (c) 2015年 denjo. All rights reserved.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var myLabel: UILabel!
//    @IBAction func getOmikuji(sender: AnyObject) {
//        let results = [
//            "大吉",
//            "吉",
//            "中吉",
//            "凶",
//            "大凶"
//        ]
//        //乱数を生成 0~4
//        let random = arc4random_uniform(UInt32(results.count))
//        println(results[Int(random)])
//        self.myLabel.text = results[Int(random)]
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//}
//
//
//  ViewController.swift
//  MyOmikujiApp
//
//  Created by Gen Taguchi on 2014/10/21.
//  Copyright (c) 2014年 Dotinstall. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var myLabel: UILabel!
    @IBAction func getOmikuji(sender: AnyObject) {
        let results = [
            "大吉",
            "吉",
            "中吉",
            "凶",
            "大凶"
        ]
        // 乱数を生成 0 - 4
        // 0 - n
        // arc4random_uniform(n + 1)
        let random = arc4random_uniform(UInt32(results.count))
        
        // results[乱数]をmylabelに表示
        self.myLabel.text = results[Int(random)]
        
        //大吉のときに赤文字
        if random == 0 {
            self.myLabel.textColor = UIColor.redColor()
        } else {
            self.myLabel.textColor = UIColor.blackColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


