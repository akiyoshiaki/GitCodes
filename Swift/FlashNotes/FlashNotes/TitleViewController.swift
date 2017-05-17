//
//  TitleViewController.swift
//  FlashNotes
//
//  Created by denjo on 2015/08/24.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // 表示する値の配列.
    private let myValues: [String] = ["easy","normal","hard"]

    // 難易度(初期位置nilなのでeasy初期化必須)
    var level: String = "easy"
    
    //storyboardからクラス作りたいときは...
    //まずstoryboardにViewControllerを置く
    //で新しいViewControllerのファイルとクラスを作る
    //そしてstoryboardのユーティリティで新しいクラス名を指定する！
    
    @IBOutlet weak var myPicker: UIPickerView!

    //スタートボタン押した時になにかしたければ。
    @IBAction func startGame(sender: AnyObject) {
        //既にstoryboardでセグエを使っているので
        //何も書かずとも画面遷移します
        
    }
    
    //画面遷移でレベルを渡したい
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //遷移先のviewControllerをつくる,必要が無くなった。
//        let viewController: ViewController = segue.destinationViewController as! ViewController
//        //プロパティに入れてあげる, 先では更にレベルをシーンに渡す
//        viewController.level = self.level
        
        ViewController.level = self.level
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ピッカーをつくる
        myPicker.frame = CGRectMake(0,0,self.view.bounds.width, 180.0)
        myPicker.delegate = self
        myPicker.dataSource = self
        self.view.addSubview(myPicker)
        
    }
    
    /*
    pickerに表示する列数を返すデータソースメソッド.
    (実装必須)
    */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
    pickerに表示する行数を返すデータソースメソッド.
    (実装必須)
    */
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myValues.count
    }
    
    /*
    pickerに表示する値を返すデリゲートメソッド.
    表示する文字列を指定
    */
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myValues[row] //as! String
    }
    
    /*
    pickerが選択された際に呼ばれるデリゲートメソッド.
    */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("value: \(myValues[row])")
        level = myValues[row]
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
