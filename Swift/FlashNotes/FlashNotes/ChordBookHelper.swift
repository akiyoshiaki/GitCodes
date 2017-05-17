//
//  ChordBookHelper.swift
//  FlashNotes
//
//  Created by denjo on 2015/09/18.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.

// まずコードクラスを作ります



import Foundation

// ピッチのインスタンスを持っておきたい
// pitchHelperを作らずともchordBookHelperに書いちゃえばいいか...


//コードブックに弾かせたいコードを登録していきたい
public class ChordBookHelper {

    //というか、クラス内に書いた変数は全てプロパティになる
    //注意せよ！！！
    
    // ピッチを大量登録
    var E2 = Pitch(name: "E", height: 2)
    var F2 = Pitch(name: "F", height: 2)
    var Fs2 = Pitch(name: "Fs", height: 2)
    var G2 = Pitch(name: "G", height: 2)
    var Gs2 = Pitch(name: "Gs", height: 2)
    var A2 = Pitch(name: "A", height: 2)
    var As2 = Pitch(name: "As", height: 2)
    var B2 = Pitch(name: "B", height: 2)

    var C3 = Pitch(name: "C", height: 3)
    var Cs3 = Pitch(name: "Cs", height: 3)
    var D3 = Pitch(name: "D", height: 3)
    var Ds3 = Pitch(name: "Ds", height: 3)
    var E3 = Pitch(name: "E", height: 3)
    var F3 = Pitch(name: "F", height: 3)
    var Fs3 = Pitch(name: "Fs", height: 3)
    var G3 = Pitch(name: "G", height: 3)
    var Gs3 = Pitch(name: "Gs", height: 3)
    var A3 = Pitch(name: "A", height: 3)
    var As3 = Pitch(name: "As", height: 3)
    var B3 = Pitch(name: "B", height: 3)

    var C4 = Pitch(name: "C", height: 4)
    var Cs4 = Pitch(name: "Cs", height: 4)
    var D4 = Pitch(name: "D", height: 4)
    var Ds4 = Pitch(name: "Ds", height: 4)
    var E4 = Pitch(name: "E", height: 4)
    var F4 = Pitch(name: "F", height: 4)
    var Fs4 = Pitch(name: "Fs", height: 4)
    var G4 = Pitch(name: "G", height: 4)
    var Gs4 = Pitch(name: "Gs", height: 4)
    var A4 = Pitch(name: "A", height: 4)
    var As4 = Pitch(name: "As", height: 4)
    var B4 = Pitch(name: "B", height: 4)

    
    var mute = Pitch(name: "N", height: 0)
    
    // 辞書を作ってその中に全てコードをぶち込みましょう
    var chordBook : [String: Chord] = [:]
    
    //プロパティが多くなるのは好ましくないと思うのです
    //↑どの口がそんなこと言ってるんだ...
    private var freeChord = Chord(name: "N")
    
    func setAllChords(){
        self.setMajorChords()
        self.setMinorChords()
        self.setSeventhChords()
        self.setMinorSeventhChords()
        self.setMajorSeventhChords()
    
        //freeChord = Chord(name: "N")
    }
    
    //同じfreeChordを使い回すならいちいち初期化が必要！！！
    func setMajorChords(){
        var contents = Array<Pitch>()
        freeChord.type = ChordType.Major

        freeChord = Chord(name: "C")
        contents = [E4, C4, G3, E3, C3, mute]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord

        freeChord = Chord(name: "D")
        contents = [Fs4, D4, A3, D3, mute, mute]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord

        freeChord = Chord(name: "E")
        contents = [E4, B3, Gs3, E3, B2, E2]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord

        freeChord = Chord(name: "F")
        contents = [F4, C4, A3, F3, C3, F2]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord
        
        freeChord = Chord(name: "G")
        contents = [G4, B3, G3, D3, B2, G2]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord
     
        freeChord = Chord(name: "A")
        contents = [E4, Cs4, A3, E3, A2, mute]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord

        freeChord = Chord(name: "B")
        contents = [E4, C4, G3, E3, C3, mute]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord

    }
    
    func setMinorChords(){
        var contents = Array<Pitch>()
        freeChord.type = ChordType.Minor
        
        freeChord = Chord(name: "Am")
        contents = [E4, C4, A3, E3, A2, E2]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord
        
        freeChord = Chord(name: "Bm")
        contents = [Fs4, D4, B3, Fs3, B2, mute]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord
        
        freeChord = Chord(name: "Em")
        contents = [E4, B3, G3, E3, B2, E2]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord

        
        freeChord = Chord(name: "F#m")
        contents = [Fs4, Cs3, A3, Fs3, Cs3, Fs2]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord

    }

    func setSeventhChords(){
        var contents = Array<Pitch>()
        freeChord.type = ChordType.Seventh
        
        freeChord = Chord(name: "A7")
        contents = [E4, Cs4, G3, E3, A2, mute]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord
        
        freeChord = Chord(name: "F#7")
        contents = [Fs4, Cs3, As3, E3, Cs3, Fs2]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord

        
    }

    
    func setMinorSeventhChords(){
        var contents = Array<Pitch>()
        freeChord.type = ChordType.MinorSeventh
        
        freeChord = Chord(name: "Am7")
        contents = [E4, C4, G3, E3, A2, mute]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord

        freeChord = Chord(name: "F#m7")
        contents = [Fs4, Cs4, A3, E3, Cs3, Fs2]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord

    }

    func setMajorSeventhChords(){
        var contents = Array<Pitch>()
        freeChord.type = ChordType.MajorSeventh
        
        freeChord = Chord(name: "AM7")
        contents = [E4, Cs4, Gs3, E3, A2, mute]
        freeChord.contents.content = contents
        chordBook[freeChord.name] = freeChord
        
    }

    

}

