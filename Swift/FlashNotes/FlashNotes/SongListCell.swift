//
//  SongListCell.swift
//  FlashNotes
//
//  Created by denjo on 2015/11/09.
//  Copyright © 2015年 Shunya Ariga. All rights reserved.
//

import UIKit

class SongListCell: UITableViewCell {

    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelArtist: UILabel!
    @IBOutlet weak var labelTonic: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    func setCell(info: SongInfo){
        self.labelId.text = String(info.id)
        self.labelTitle.text = info.title
        self.labelArtist.text = info.artist
        self.labelTonic.text = info.tonic
        
    }
    
}
