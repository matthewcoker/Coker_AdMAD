//
//  ItemCell.swift
//  Project1
//
//  Created by Matthew Coker on 3/5/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import UIKit
class ItemCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    var isChecked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
