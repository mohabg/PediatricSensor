//
//  TDTempoDiscInfoCell.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/12/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit

class TDTempoDiscInfoCell: UICollectionViewCell {

    @IBOutlet var dataTypeLabel: UILabel!
    @IBOutlet var dataUnitLabel: UILabel!
    @IBOutlet var currentDataLabel: UILabel!
    @IBOutlet var highestDataLoggedLabel: UILabel!
    @IBOutlet var averageDataLogLabel: UILabel!
    @IBOutlet var lowestDataLogLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
