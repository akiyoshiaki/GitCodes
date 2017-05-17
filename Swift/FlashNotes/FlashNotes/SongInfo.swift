//
//  ListCell.swift
//  FlashNotes
//
//  Created by denjo on 2015/11/09.
//  Copyright © 2015年 Shunya Ariga. All rights reserved.
//

import Foundation

class SongInfo: NSObject {
    var id: Int = 0
    var title: String = ""
    var artist: String = ""
    var tonic: String = ""
    var metre: String = ""
    init(id: Int, title: String, artist: String, tonic: String, metre: String) {
        self.id = id
        self.title = title
        self.artist = artist
        self.tonic = tonic
        self.metre = metre
        
    }

    
}