//
//  MemeTableViewCell.swift
//  Meme
//
//  Created by Samuel Doherty on 6/19/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    //IBOutlets
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
