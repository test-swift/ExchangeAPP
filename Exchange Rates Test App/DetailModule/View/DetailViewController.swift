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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mChart: LineChartView!
    var dataEntries: [ChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = presenter.symbol
        
    }
}
    

extension DetailViewController: DetailViewProtocol{
    
    func successRequest() {
        
    }
    
    func failureRequest() {
        
    }
       
      func setChart(values: [Double], label: [String]) {
                 mChart.noDataText = "No data available!"
                 for i in 0..<values.count {
                     print("chart point : \(values[i])")
                     let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
                     dataEntries.append(dataEntry)
                 }
    
      mChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:label)
      mChart.xAxis.granularity = 1
      let line1 = LineChartDataSet(entries: dataEntries, label: "Units Consumed")
                 line1.colors = [NSUIColor.blue]
                 line1.mode = .cubicBezier
                 line1.cubicIntensity = 0.2

                 let gradient = getGradientFilling()
                 line1.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
                 line1.drawFilledEnabled = true

                 let data = LineChartData()
                 data.addDataSet(line1)
                 mChart.data = data
                 mChart.setScaleEnabled(false)
      mChart.animate(xAxisDuration: 0.7)
                 mChart.drawGridBackgroundEnabled = false
                 mChart.xAxis.drawAxisLineEnabled = true
      mChart.xAxis.drawGridLinesEnabled = false
      mChart.xAxis.labelPosition = .bottom
                 mChart.leftAxis.drawAxisLineEnabled = true
                 mChart.leftAxis.drawGridLinesEnabled = false
                 mChart.rightAxis.drawAxisLineEnabled = false
                 mChart.rightAxis.drawGridLinesEnabled = false
                 mChart.legend.enabled = false
                 mChart.xAxis.enabled = true
                 mChart.leftAxis.enabled = true
                 mChart.rightAxis.enabled = false
                 mChart.xAxis.drawLabelsEnabled = true

             }


             /// Creating gradient for filling space under the line chart
             private func getGradientFilling() -> CGGradient {
                 // Setting fill gradient color
                 let coloTop = UIColor(red: 141/255, green: 133/255, blue: 220/255, alpha: 1).cgColor
                 let colorBottom = UIColor(red: 230/255, green: 155/255, blue: 210/255, alpha: 1).cgColor
                 // Colors of the gradient
                 let gradientColors = [coloTop, colorBottom] as CFArray
                 // Positioning of the gradient
                 let colorLocations: [CGFloat] = [0.7, 0.0]
                 // Gradient Object
                 return CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)!
             }
    
}
