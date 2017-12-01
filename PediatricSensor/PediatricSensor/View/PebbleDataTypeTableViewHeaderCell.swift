//
//  PebbleDataTypeTableViewHeaderCell.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 12/1/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit

class PebbleDataTypeTableViewHeaderCell: UITableViewCell {
    
    var section: Int!
    
    @IBOutlet var sectionTitleLabel: UILabel!
    @IBOutlet var expandSectionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
