//
//  FingerBoardTile.swift
//  FlashNotes
//
//  Created by denjo on 2015/09/24.
//  Copyright (c) 2015年 Shunya Ariga. All rights reserved.
//

import Foundation
import SpriteKit

//一応作った
enum TileType: Int{
    case None
    case Top
    case Fret
    case Other
    func canTouch() -> Bool {
        return (self == .Fret)
    }
}

// これも一応...
class Tile: SKSpriteNode {
    var type = TileType.None

    // ポジション欲しいと思った
    var tilePosition = TilePosition(x: 0, y: 0)
    
    // pitchプロパティを持たせた方が便利だと思う
    // でもコードブックはViewControllerが持っているから工夫が必要かな...
    // ViewControllerからセッティングできないだろうか

    var pitch = Pitch(name: "N", height: 0)
    
    
}

// 必要性を感じた
class TouchMark: SKSpriteNode {

    var tilePosition = TilePosition(x: 0, y: 0)
    
}



//なぜ構造体???
//2次元配列を実現する用の構造体.
struct TilePosition {

    // なぜこれintなのか。
    // もしかしてCGFloatとかの計算がめんどいから自分で作ったの?
    var x, y: Int
    
    //他のtilePositionと比較して一致しているのか
    func isEqual(other: TilePosition) -> Bool {
        return self.x == other.x && self.y == other.y
    }
}

