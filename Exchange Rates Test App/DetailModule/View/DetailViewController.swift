//
//  DetailViewController.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 09..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit
import Charts

class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresenterPrototcol!
    var dataEntries: [ChartDataEntry] = []
    @IBOutlet weak var diagramView: UIView!
    @IBOutlet weak var linearDiagram: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diagramView.layer.cornerRadius = 40
        self.title = "\(presenter.symbol) Exchange Rate History"
    }
    
    
}



extension DetailViewController: DetailViewProtocol{
    
    func failureRequest() {
        let alert = UIAlertController(title: "An Error Occurred", message: "“No exchange rate data is available for the selected currency.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func setChart(values: [Double], label: [String]) {
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        //MARK: Creating line
        linearDiagram.xAxis.valueFormatter = IndexAxisValueFormatter(values: label)
        linearDiagram.xAxis.granularity =  1
        linearDiagram.minOffset = 0
        let line = LineChartDataSet(entries: dataEntries)
        line.colors = [NSUIColor.blue]
        line.mode = .cubicBezier
        line.label = nil
        line.cubicIntensity = 0.2
        line.circleRadius = 7
        line.circleHoleRadius = 3
        let gradient = getGradientFilling()
        line.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        line.drawFilledEnabled = true
        
        let data = LineChartData()
        data.addDataSet(line)
        linearDiagram.data = data
        
        
        linearDiagram.setScaleEnabled(false)
        linearDiagram.animate(xAxisDuration: 0.7)
        linearDiagram.drawGridBackgroundEnabled = false
        linearDiagram.xAxis.drawAxisLineEnabled = true
        linearDiagram.xAxis.drawGridLinesEnabled = false
        linearDiagram.xAxis.labelPosition = .bottom
        linearDiagram.leftAxis.drawAxisLineEnabled = true
        linearDiagram.leftAxis.drawGridLinesEnabled = true
        linearDiagram.rightAxis.drawAxisLineEnabled = false
        linearDiagram.rightAxis.drawGridLinesEnabled = false
        linearDiagram.legend.enabled = false
        linearDiagram.xAxis.enabled = true
        linearDiagram.xAxis.labelFont = UIFont(name: "ArialMT", size: 9)!
        linearDiagram.xAxis.labelRotationAngle = 20

        linearDiagram.leftAxis.enabled = false
        linearDiagram.rightAxis.enabled = false
        
        linearDiagram.xAxis.axisMinimum = -0.5;
        linearDiagram.xAxis.axisMaximum = Double(label.count) - 0.5;
//        linearDiagram.xAxis.drawLabelsEnabled = true
        linearDiagram.fitScreen()
        
    
    }
    
    //MARK: Creating gradient
    private func getGradientFilling() -> CGGradient {
        let coloTop = UIColor(red: 141/255, green: 133/255, blue: 220/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 230/255, green: 155/255, blue: 210/255, alpha: 1).cgColor
        let gradientColors = [coloTop, colorBottom] as CFArray
        let colorLocations: [CGFloat] = [0.7, 0.0]
        return CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)!
    }
    
}
