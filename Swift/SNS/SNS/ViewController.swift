//
//  ViewController.swift
//  SNS
//
//  Created by denjo on 2015/09/07.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func showActionView(sender: UIBarButtonItem) {
        
        //アクティビティビューのコントローラ作成
        let controller = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)

        //controllerをモーダルビューコントローラとして表示
        //モーダルビューを表示するにはモーダルビューコントローラをpresentViewControllerの引数にする
        //presentViewControllerの最初の引数のコントローラが持つビューがモーダルになる
        self.presentViewController(controller, animated: true, completion: {println("complete!")})
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

