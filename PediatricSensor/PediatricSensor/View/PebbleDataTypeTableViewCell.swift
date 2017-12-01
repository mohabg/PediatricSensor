//
//  PebbleDataTypeTableViewCell.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/30/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit

class PebbleDataTypeTableViewCell: UITableViewCell {

    @IBOutlet var background: UIView!
    @IBOutlet var dataTypeLabel: UILabel!
    @IBOutlet var dataUnitLabel: UILabel!
    @IBOutlet var currentDataLabel: UILabel!
    @IBOutlet var highestDataLabel: UILabel!
    @IBOutlet var averageDataLabel: UILabel!
    @IBOutlet var lowestDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBackgroundGradient(from topColor: UIColor, to bottomColor: UIColor){
        let gradient = CAGradientLayer()
        
        gradient.frame = background.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
    
//        gradient.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        gradient.startPoint = CGPoint.init(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        
        background.layer.insertSublayer(gradient, at: 0)
    }
    
    func fillWithDataType(_ type: TDTempoDiscInfoViewController.DataType, usingDisc disc: TDTempoDisc?) {
        switch type {
        case .Temperature:
            self.dataTypeLabel.text = "Temperature"
            self.dataUnitLabel.text = disc?.isFahrenheit == true ? "Fahrenheit" : "Celsius"
            self.currentDataLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.currentTemperature as! Float).stringValue : disc?.currentTemperature?.stringValue
            self.averageDataLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.averageDayTemperature as! Float).stringValue : disc?.averageDayTemperature?.stringValue
            self.lowestDataLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.lowestDayTemperature as! Float).stringValue : disc?.lowestDayTemperature?.stringValue
            self.highestDataLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.highestDayTemperature as! Float).stringValue : disc?.highestDayTemperature?.stringValue
        case .Humidity:
            self.dataTypeLabel.text = "Humidity"
            self.dataUnitLabel.text = "% Relative Humidity"
            self.currentDataLabel.text = disc?.currentHumidity?.stringValue
            self.averageDataLabel.text = disc?.averageDayHumidity?.stringValue
            self.lowestDataLabel.text = disc?.lowestDayHumidity?.stringValue
            self.highestDataLabel.text = disc?.highestDayHumidity?.stringValue
        case .Pressure:
            self.dataTypeLabel.text = "Pressure"
            self.dataUnitLabel.text = "hPa"
            self.currentDataLabel.text = disc?.currentPressure?.stringValue
            self.averageDataLabel.text = disc?.averageDayPressure?.stringValue
            self.lowestDataLabel.text = disc?.lowestDayPressure?.stringValue
            self.highestDataLabel.text = disc?.highestDayPressure?.stringValue
        case .DewPoint:
            self.dataTypeLabel.text = "Dew Point"
            self.dataUnitLabel.text = disc?.isFahrenheit == true ? "Fahrenheit" : "Celsius"
            //TODO Calculate my own dew point
            self.currentDataLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.dewPoint as! Float).stringValue : disc?.dewPoint?.stringValue
            self.averageDataLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(PebbleUtilities.dewPointCalculation(disc?.averageDayTemperature as! Float, humidity: disc?.averageDayHumidity as! Float)).stringValue : disc?.averageDayDew?.stringValue
            self.lowestDataLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(PebbleUtilities.dewPointCalculation(disc?.lowestDayTemperature as! Float, humidity: disc?.lowestDayHumidity as! Float)).stringValue : disc?.lowestDayDew?.stringValue
            self.highestDataLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(PebbleUtilities.dewPointCalculation(disc?.highestDayTemperature as! Float, humidity: disc?.highestDayHumidity as! Float)).stringValue : disc?.highestTemperature?.stringValue
        }
        self.currentDataLabel.text = String.init(format: "%.1f", Float.init(self.currentDataLabel.text!)!)
        self.averageDataLabel.text = String.init(format: "%.1f", Float.init(self.averageDataLabel.text!)!)
        self.lowestDataLabel.text = String.init(format: "%.1f", Float.init(self.lowestDataLabel.text!)!)
        self.highestDataLabel.text = String.init(format: "%.1f", Float.init(self.highestDataLabel.text!)!)
    }
}
