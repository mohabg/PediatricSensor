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
    
    func fillWithDataType(_ type: TDTempoDiscInfoViewController.DataType, usingDisc disc: TDTempoDisc?) {
        switch type {
        case .Temperature:
            self.dataTypeLabel.text = "Temperature"
            self.dataUnitLabel.text = disc?.isFahrenheit == true ? "Fahrenheit" : "Celsius"
            self.currentDataLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.currentTemperature as! Float).stringValue : disc?.currentTemperature?.stringValue
            self.averageDataLogLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.averageDayTemperature as! Float).stringValue : disc?.averageDayTemperature?.stringValue
            self.lowestDataLogLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.lowestDayTemperature as! Float).stringValue : disc?.lowestDayTemperature?.stringValue
            self.highestDataLoggedLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.highestDayTemperature as! Float).stringValue : disc?.highestDayTemperature?.stringValue
        case .Humidity:
            self.dataTypeLabel.text = "Humidity"
            self.dataUnitLabel.text = "% Relative Humidity"
            self.currentDataLabel.text = disc?.currentHumidity?.stringValue
            self.averageDataLogLabel.text = disc?.averageDayHumidity?.stringValue
            self.lowestDataLogLabel.text = disc?.lowestDayHumidity?.stringValue
            self.highestDataLoggedLabel.text = disc?.highestDayHumidity?.stringValue
        case .Pressure:
            self.dataTypeLabel.text = "Pressure"
            self.dataUnitLabel.text = "hPa"
            self.currentDataLabel.text = disc?.currentPressure?.stringValue
            self.averageDataLogLabel.text = disc?.averageDayPressure?.stringValue
            self.lowestDataLogLabel.text = disc?.lowestDayPressure?.stringValue
            self.highestDataLoggedLabel.text = disc?.highestDayPressure?.stringValue
        case .DewPoint:
            self.dataTypeLabel.text = "Dew Point"
            self.dataUnitLabel.text = disc?.isFahrenheit == true ? "Fahrenheit" : "Celsius"
            //TODO Calculate my own dew point
            self.currentDataLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.dewPoint as! Float).stringValue : disc?.dewPoint?.stringValue
            self.averageDataLogLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(PebbleUtilities.dewPointCalculation(disc?.averageDayTemperature as! Float, humidity: disc?.averageDayHumidity as! Float)).stringValue : disc?.averageDayDew?.stringValue
            self.lowestDataLogLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(PebbleUtilities.dewPointCalculation(disc?.lowestDayTemperature as! Float, humidity: disc?.lowestDayHumidity as! Float)).stringValue : disc?.lowestDayDew?.stringValue
            self.highestDataLoggedLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(PebbleUtilities.dewPointCalculation(disc?.highestDayTemperature as! Float, humidity: disc?.highestDayHumidity as! Float)).stringValue : disc?.highestTemperature?.stringValue
        }
        self.currentDataLabel.text = String.init(format: "%.1f", Float.init(self.currentDataLabel.text!)!)
        self.averageDataLogLabel.text = String.init(format: "%.1f", Float.init(self.averageDataLogLabel.text!)!)
        self.lowestDataLogLabel.text = String.init(format: "%.1f", Float.init(self.lowestDataLogLabel.text!)!)
        self.highestDataLoggedLabel.text = String.init(format: "%.1f", Float.init(self.highestDataLoggedLabel.text!)!)
        
        self.contentView.setNeedsLayout()
    }
}
