//
//  ItemCell.swift
//  Lab5-AMAD
//
//  Created by Matthew Coker on 3/31/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var ItemLabel: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
