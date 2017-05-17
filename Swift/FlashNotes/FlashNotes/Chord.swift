//
//  Chord.swift
//  FlashNotes
//
//  Created by denjo on 2015/09/18.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.
//

import Foundation

//typealias Pitch = (name: String, height: Int)
//typealias FretPosition = (name: Int, fret: Int)


// クラスは大変っぽいので恐らく構造体がベター...?


//ex.) C4, E3, ...
public class Pitch {

    // 音名、音の名前
    var name: String = "N"
    
    // 音高の数字
    var height: Int = 0
    
    // 音名に割り当てる数字
    var toneNumber: Int = 0

    // イニシャライザその1
    init(name: String, height: Int){
        self.name = name
        self.height = height
        
        // toneNumberはイニシャライザで割当可能！
        switch self.name{
        case "C":
            self.toneNumber = 0
        case "Cs":
            self.toneNumber = 1
        case "D":
            self.toneNumber = 2
        case "Ds":
            self.toneNumber = 3
        case "E":
            self.toneNumber = 4
        case "F":
            self.toneNumber = 5
        case "Fs":
            self.toneNumber = 6
        case "G":
            self.toneNumber = 7
        case "Gs":
            self.toneNumber = 8
        case "A":
            self.toneNumber = 9
        case "As":
            self.toneNumber = 10
        case "B":
            self.toneNumber = 11
            
        default:
            self.toneNumber = 0
        }
    }
    
    // イニシャライザその2
    // toneNumberだけから作れたら楽では？
    // でもheightがわからないか...

    func showPitch() {
        print("name : ")
        print(self.name)
        print(", height : ")
        print(self.height)
    }

    // 運指関連のメソッドはFingerBoardControllerに書きました

}


//構造体にしました
public struct FretPosition {
    
    // 弦の名前,Intです(ex. 1 -> 1弦)
    var order: Int

    // フレット,ポジションとも呼ぶ
    var fret: Int
    
    // 開放弦のtoneNumberはFretPositionから得よう
    // 、と思ったけどなんか都合悪くなったのでPitchにがんばってもらおう
    
}


//コードの属性の列挙型
enum ChordType: Int{

    case Free
    case Major
    case Minor
    case Seventh
    case MajorSeventh
    case MinorSeventh
    case OnChord
    
}
    



//コードで鳴らしたい音のクラス
//6~1弦まで登録してしまえば楽なんじゃないの...?
//とはいえChordにContentを持たせるとなると、また初期化の問題がありそうだが...
//固定長配列にすれば大丈夫か?

public class Contents {
    
    var first = Pitch(name: "N", height: 0)
    var second = Pitch(name: "N", height: 0)
    var third = Pitch(name: "N", height: 0)
    var fourth = Pitch(name: "N", height: 0)
    var fifth = Pitch(name: "N", height: 0)
    var sixth = Pitch(name: "N", height: 0)
    
    //まとめたもの
    //この初期化の仕方は覚えておくこと！！！
    var content: Array<Pitch> {
        get{
            var tmp: Array<Pitch> //これは初期化いらんのか???
            tmp = [first, second, third, fourth, fifth, sixth]
            return tmp
            //returnで代入するよ、getterだもん
        }
        set(array){
            if array.count > 0 { first = array[0] }
            if array.count > 1 { second = array[1] }
            if array.count > 2 { third = array[2] }
            if array.count > 3 { fourth = array[3] }
            if array.count > 4 { fifth = array[4] }
            if array.count > 5 { sixth = array[5] }
        }
    }
    

    
}


public class Chord {
    //コード名
    var name: String = "N"

    // コードの属性(初期値はFree)
    var type:ChordType = ChordType.Free

    init(name: String){
        self.name = name

        //こっからうまくパースして、chordTypeを初期化したいなぁ
        
        //まず1文字なら絶対にメジャー.
        //if count(name) == 1{ //swift 1.x
        if name.characters.count == 1 { //swift 2.0
            self.type = ChordType.Major
        }
        else{
            self.type = ChordType.Free
        }
        
        //最後がbならフラット、とか...
    
    }
    
    //contents:コードで鳴らしたい音(not equal 構成音) ピッチで構成される
    //デフォルト初期化だけして、あとはContentクラスに任せる

    var contents = Contents()
    
    func showContents() {
        //Pitch
        for ele in self.contents.content {
            print(ele.name)
            print(" ")
            print(ele.height)
            //print(" ")
            //print(ele.toneNumber)
            
        }
    }

    func getChord() -> Chord{
        return self
    }
    
}

