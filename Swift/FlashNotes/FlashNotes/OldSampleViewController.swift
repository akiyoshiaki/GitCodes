//
//  SampleViewController.swift
//  FlashNotes
//
//  Created by denjo on 2015/09/08.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.
//


import UIKit


//プロトコル追加
//※プロトコル内のoptionalが付いているメソッドは実装しなくてもよい
//ていうかこの2つのプロトコルは全部optional
//プロトコルは親クラスの後に書く

//デリゲート：あるクラスでは処理できない命令を、そのクラスの代わりに行うクラスのこと


//ノート的な感じで残しておきます
class OldSampleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func launchCamera(sender: UIBarButtonItem) {
        
        //画像の取得方法
        let camera = UIImagePickerControllerSourceType.Camera
        
        //カメラついた実機じゃないと撮れないょ
        if UIImagePickerController.isSourceTypeAvailable(camera) {
            
            //モーダルビューコントローラ作成
            let picker = UIImagePickerController()
            picker.sourceType = camera

            //このプロパティは上記2つのプロトコルを批准してないとダメ
            picker.delegate = self
            
            //delegateプロパティにselfを代入すると、ViewControllerクラスのインスタンスが
            //UIImagePickerControllerの代理人となる
            

            //
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    //写真撮影終了時に呼び出される
    //引数のinfoに画像が格納されてる
    //(プロトコル使えば引数に値が入っていてちょーべんり)
    /*
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        //AnyObjectは真っ先にキャスティングする
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = image
        
        //アルバムに保存
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

        //モーダルビューコントローラを消去する
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}