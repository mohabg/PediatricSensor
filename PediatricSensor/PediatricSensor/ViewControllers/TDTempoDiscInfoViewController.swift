//
//  TDTempoDiscInfoViewController.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/12/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit

class TDTempoDiscInfoViewController: UIViewController {
    
    @IBOutlet var deviceNameLabel: UILabel!
    @IBOutlet var deviceDataCollectionView: UICollectionView!
    
    var disc: TDTempoDisc?
    var parser = DownloadParser()
    
    static let INFO_CELL_IDENTIFIER = "TDTempoDiscInfoCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        deviceDataCollectionView.register(UINib.init(nibName: "TDTempoDiscInfoCell", bundle: nil), forCellWithReuseIdentifier: TDTempoDiscInfoViewController.INFO_CELL_IDENTIFIER)
        deviceDataCollectionView.delegate = self
        deviceDataCollectionView.dataSource = self
    }
}

extension TDTempoDiscInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    enum DataType: Int {
        case Temperature
        case Humidity
        case Pressure
        case DewPoint
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var max: Int = 0
        while let _ = DataType(rawValue: max) { max += 1 }
        return max
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TDTempoDiscInfoViewController.INFO_CELL_IDENTIFIER, for: indexPath) as! TDTempoDiscInfoCell
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 10.0
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 1.0
        cell.clipsToBounds = false
        cell.layer.masksToBounds = false
        
        deviceNameLabel.text = disc?.name
        
        switch indexPath.row {
        case 0:
            cell.fillWithDataType(.Temperature, usingDisc: disc)
            cell.layer.borderColor = UIColor.red.cgColor
        case 1:
            cell.fillWithDataType(.Humidity, usingDisc: disc)
            cell.layer.borderColor = UIColor.blue.cgColor
        case 2:
            cell.fillWithDataType(.Pressure, usingDisc: disc)
            cell.layer.borderColor = UIColor.purple.cgColor
        case 3:
            cell.fillWithDataType(.DewPoint, usingDisc: disc)
            cell.layer.borderColor = UIColor.green.cgColor
        default: break
        }
//        
//        switch indexPath.row {
//        case 0: fillCell(cell, withDataType: .Temperature)
//        cell.layer.borderColor = UIColor.red.cgColor
//        case 1: fillCell(cell, withDataType: .Humidity)
//        cell.layer.borderColor = UIColor.blue.cgColor
//        case 2: fillCell(cell, withDataType: .Pressure)
//        cell.layer.borderColor = UIColor.purple.cgColor
//        case 3: fillCell(cell, withDataType: .DewPoint)
//        cell.layer.borderColor = UIColor.green.cgColor
//        default: break
//        }
//
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let graphVC = storyboard?.instantiateViewController(withIdentifier: "PebbleLogGraphViewController") as! PebbleLogGraphViewController
        switch indexPath.row {
        case 0:
            graphVC.graphData = parser.temp
            graphVC.identifier = .Temperature
        case 1:
            graphVC.graphData = parser.humidity
            graphVC.identifier = .Humidity
        case 2:
            graphVC.graphData = parser.pressure
            graphVC.identifier = .Pressure
        case 3:
            graphVC.graphData = parser.dewPoint
            graphVC.identifier = .DewPoint
        default:
            break
        }
        self.show(graphVC, sender: self)
    }
    
//    func fillCell(_ cell: TDTempoDiscInfoCell, withDataType type: DataType) {
//        switch type {
//        case .Temperature:
//            cell.dataTypeLabel.text = "Temperature"
//            cell.dataUnitLabel.text = disc?.isFahrenheit == true ? "Fahrenheit" : "Celsius"
//            cell.currentDataLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.currentTemperature as! Float).stringValue : disc?.currentTemperature?.stringValue
//            cell.averageDataLogLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.averageDayTemperature as! Float).stringValue : disc?.averageDayTemperature?.stringValue
//            cell.lowestDataLogLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.lowestDayTemperature as! Float).stringValue : disc?.lowestDayTemperature?.stringValue
//            cell.highestDataLoggedLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.highestDayTemperature as! Float).stringValue : disc?.highestDayTemperature?.stringValue
//        case .Humidity:
//            cell.dataTypeLabel.text = "Humidity"
//            cell.dataUnitLabel.text = "% Relative Humidity"
//            cell.currentDataLabel.text = disc?.currentHumidity?.stringValue
//            cell.averageDataLogLabel.text = disc?.averageDayHumidity?.stringValue
//            cell.lowestDataLogLabel.text = disc?.lowestDayHumidity?.stringValue
//            cell.highestDataLoggedLabel.text = disc?.highestDayHumidity?.stringValue
//        case .Pressure:
//            cell.dataTypeLabel.text = "Pressure"
//            cell.dataUnitLabel.text = "hPa"
//            cell.currentDataLabel.text = disc?.currentPressure?.stringValue
//            cell.averageDataLogLabel.text = disc?.averageDayPressure?.stringValue
//            cell.lowestDataLogLabel.text = disc?.lowestDayPressure?.stringValue
//            cell.highestDataLoggedLabel.text = disc?.highestDayPressure?.stringValue
//        case .DewPoint:
//            cell.dataTypeLabel.text = "Dew Point"
//            cell.dataUnitLabel.text = disc?.isFahrenheit == true ? "Fahrenheit" : "Celsius"
//            //TODO Calculate my own dew point
//            cell.currentDataLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(disc?.dewPoint as! Float).stringValue : disc?.dewPoint?.stringValue
//            cell.averageDataLogLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(PebbleUtilities.dewPointCalculation(disc?.averageDayTemperature as! Float, humidity: disc?.averageDayHumidity as! Float)).stringValue : disc?.averageDayDew?.stringValue
//            cell.lowestDataLogLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(PebbleUtilities.dewPointCalculation(disc?.lowestDayTemperature as! Float, humidity: disc?.lowestDayHumidity as! Float)).stringValue : disc?.lowestDayDew?.stringValue
//            cell.highestDataLoggedLabel.text = disc?.isFahrenheit == true ? PebbleUtilities.fahrenheitFromCelsius(PebbleUtilities.dewPointCalculation(disc?.highestDayTemperature as! Float, humidity: disc?.highestDayHumidity as! Float)).stringValue : disc?.highestTemperature?.stringValue
//        }
//        cell.currentDataLabel.text = String.init(format: "%.1f", Float.init(cell.currentDataLabel.text!)!)
//        cell.averageDataLogLabel.text = String.init(format: "%.1f", Float.init(cell.averageDataLogLabel.text!)!)
//        cell.lowestDataLogLabel.text = String.init(format: "%.1f", Float.init(cell.lowestDataLogLabel.text!)!)
//        cell.highestDataLoggedLabel.text = String.init(format: "%.1f", Float.init(cell.highestDataLoggedLabel.text!)!)
//    }
}
