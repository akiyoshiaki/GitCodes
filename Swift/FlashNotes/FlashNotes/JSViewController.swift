//
//  JSViewController.swift
//  FlashNotes
//
//  Created by denjo on 2015/09/11.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.
//

import UIKit
import SpriteKit

class JSViewController: UIViewController, UIWebViewDelegate, NSURLSessionDelegate, NSURLSessionDataDelegate {
    
    
    var fbc: FingerBoardController!
    var webView: UIWebView!
    
    var myTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        

        //画面の大きさ(正しいやつ)
        let superFrame: CGRect = self.view.frame
        
        //設定したいwebViewの大きさ
        //今は全画面にしています
        let webViewFrame : CGRect = CGRectMake(superFrame.origin.x , 64.0, superFrame.size.width, superFrame.size.height - 64.0)
        //var webViewFrame : CGRect = CGRectMake(superFrame.size.width * 0.7 , 64.0, superFrame.size.width * 0.3, superFrame.size.height)
        
        
        //webViewを追加
        webView = UIWebView(frame: webViewFrame)
        webView.delegate = self
        self.view.addSubview(webView)
        
        //gameSceneも追加してみる...
        /*
        let gameSceneFrame = CGRectMake(superFrame.origin.x , superFrame.origin.y * 0.7 - 64.0, superFrame.size.width, superFrame.size.height * 0.3)
        //シーン作成
        fbc = FingerBoardController()
        fbc.scaleMode = .AspectFill
        fbc.size = view.frame.size
        view.presentScene(fbc)
        */

        
        //とりあえずページを表示してみる
        /*
        let url: NSURL = NSURL(string: "https://www.google.com")!
        let request: NSURLRequest = NSURLRequest(URL: url)
        webView.loadRequest(request)
        */

        //index.htmlを読み込む
        if let url = NSBundle.mainBundle().URLForResource("index", withExtension: "html") {
            webView.loadRequest(NSURLRequest(URL: url))
        }
        
        
        //let url2 = NSURL(string: "https://www.youtube.com/embed/We3uAyJJ9Fo?feature=player_detailpage&playsinline=1")!
        
        //let url2 = NSURL(string: "https://www.youtube.com/embed/o1jAMSQyVPc?feature=player_detailpage&playsinline=1")!
        /*
        let urlRequest: NSURLRequest = NSURLRequest(URL: url2)
        webView.allowsInlineMediaPlayback = true
        webView.loadRequest(urlRequest)
        */
        //スクロール禁止
        //webView.scrollView.scrollEnabled = false
        //webView.scrollView.bounces = false
        
        //JSを呼んでみよう
        //webView.stringByEvaluatingJavaScriptFromString("hogeFunction();")

        
        
        //結果表示用のTextViewを用意
        /*
        myTextView = UITextView(frame: CGRectMake(10, 50, self.view.frame.width - 20, 500))
        
        myTextView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 1, alpha: 1.0)
        myTextView.layer.masksToBounds = true
        myTextView.layer.cornerRadius = 20.0
        myTextView.layer.borderWidth = 1
        myTextView.layer.borderColor = UIColor.blackColor().CGColor
        myTextView.font = UIFont.systemFontOfSize(CGFloat(20))
        myTextView.textColor = UIColor.blackColor()
        myTextView.textAlignment = NSTextAlignment.Left
        myTextView.dataDetectorTypes = UIDataDetectorTypes.All
        myTextView.layer.shadowOpacity = 0.5
        myTextView.layer.masksToBounds = false
        myTextView.editable = false
        
        self.view.addSubview(myTextView)
        
        // 通信用のConfigを生成.
        let myConfig:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        // Sessionを生成.
        let mySession: NSURLSession = NSURLSession(configuration: myConfig, delegate: self, delegateQueue: nil)
        
        // 通信先のURLを生成.
        let myUrl:NSURL = NSURL(string: "https://widget.songle.jp/api/v1/song/chord.json?url=https://www.youtube.com/watch?v=o1jAMSQyVPc")!
        
        // タスクの生成.
        let myTask:NSURLSessionDataTask = mySession.dataTaskWithURL(myUrl, completionHandler: { (data, response, err) -> Void in
            
            // 受け取ったjsonデータを表示.
            dispatch_async(dispatch_get_main_queue(), {
                
                self.myTextView.text = NSString(data: data, encoding: NSUTF8StringEncoding)! as String
            })
            
            // 受け取ったJSONデータをパースする.
            var json:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
            
            // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
            dispatch_async(dispatch_get_main_queue(), {
                
                // パースしたJSONデータへのアクセス.
                for value in json {
                    self.myTextView.text = "\(self.myTextView.text)\n\(value.key) : \(value.value)"
                }
                
            })
        })
        
        // タスクの実行.
        myTask.resume()
        */

        
    }

    
    //この箇所でイベントを受け取る
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let _ = request.URL?.absoluteString.rangeOfString("nativecall") {
            print("add!")
            return false
        }
        //print(request);
        //print(navigationType);

        //JSを呼んでみよう
        //webView.stringByEvaluatingJavaScriptFromString("hogeFunction();")

        //コードをJSONで取ってくる
        //webView.stringByEvaluatingJavaScriptFromString("chordGet('https://widget.songle.jp/api/v1/song/chord.json?url=https://www.youtube.com/watch?v=o1jAMSQyVPc')")
        return true
    }

    
    /*
    //ページが読み終わったときに呼ばれる関数
    func webViewDidFinishLoad(webView: UIWebView) {
        //print("ページ読み込み完了しました！")
    }
    
    //ページを読み始めた時に呼ばれる関数
    func webViewDidStartLoad(webView: UIWebView) {
        //print("ページ読み込み開始しました！")
    }
    */
}


