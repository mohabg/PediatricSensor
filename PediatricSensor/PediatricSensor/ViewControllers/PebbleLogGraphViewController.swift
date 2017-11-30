//
//  PebbleLogGraphViewController.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/23/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit
import ScrollableGraphView

class PebbleLogGraphViewController: UIViewController, ScrollableGraphViewDataSource {
    
    var identifier = PlotIdentifiers.Temperature
    var pebbleGraphModel: PebbleGraphLogModel?
    var graphData = [Double]()
    
    enum PlotIdentifiers: String {
        case Temperature = "Temperature"
        case Humidity = "Humidity"
        case Pressure = "Pressure"
        case DewPoint = "DewPoint"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
       
        let referenceLines = ReferenceLines()
        referenceLines.referenceLinePosition = .both
        let linePlot = LinePlot(identifier: identifier.rawValue)
        linePlot.lineWidth = 1.0
        linePlot.animationDuration = 0.75
        linePlot.lineStyle = .smooth
      
        graphView.addPlot(plot: linePlot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        graphView.direction = .rightToLeft
        
        switch identifier {
        case .Temperature:
            linePlot.lineColor = UIColor.red
            if(graphData.max()! > 100) {
                graphView.rangeMax = graphData.max()!
            }
        case .Humidity:
            linePlot.lineColor = UIColor.blue
        case .Pressure:
            linePlot.lineColor = UIColor.purple
            //TODO round em
            graphView.rangeMin = graphData.min()!
            graphView.rangeMax = graphData.max()!
        case .DewPoint:
            linePlot.lineColor = UIColor.green
        }
        self.view.addSubview(graphView)
    }
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
//        switch(plot.identifier) {
//        case PlotIdentifiers.Temperature.rawValue: return pebbleGraphModel?.temperature[pointIndex]
//        case PlotIdentifiers.Humidity.rawValue: return pebbleGraphModel?.humidity[pointIndex]
//        case PlotIdentifiers.Pressure.rawValue: return pebbleGraphModel?.pressure[pointIndex]
//        case PlotIdentifiers.DewPoint.rawValue: return pebbleGraphModel?.dewPoint[pointIndex]
//        default: return 0
//        }
//        switch(plot.identifier) {
//        case PlotIdentifiers.Temperature.rawValue: return 100
//        case PlotIdentifiers.Humidity.rawValue: return 75
//        case PlotIdentifiers.Pressure.rawValue: return 50
//        case PlotIdentifiers.DewPoint.rawValue: return 25
//        default: return 0
//        }
        return graphData[pointIndex]
    }
    
    func label(atIndex pointIndex: Int) -> String {
     //   let date = pebbleGraphModel?.dates[pointIndex]
        
        return "iam a bunch oftext \(pointIndex)"
    }
    
    func numberOfPoints() -> Int {
        return graphData.count
    }
}
