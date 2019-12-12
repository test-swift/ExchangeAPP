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
    @IBOutlet weak var minValue: UIButton!
    @IBOutlet weak var maxValue: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        print(self.navigationController?.navigationBar.items)
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "Exchange Rate", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)])
        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
        diagramView.layer.cornerRadius = 10
        self.title = "\(presenter.symbol) Exchange Rate History"
        self.diagramView.backgroundColor =  UIColor(red:0.51, green:0.72, blue:0.29, alpha:0.6)
        self.maxValue.backgroundColor = UIColor(red:0.51, green:0.72, blue:0.29, alpha:0.6)
        self.minValue.backgroundColor = UIColor(red:0.51, green:0.72, blue:0.29, alpha:0.6)
        self.minValue.layer.cornerRadius = 10
        self.maxValue.layer.cornerRadius = 10
//        self.minValue.setTitle("Maximum Rate For Last 7 day", for: .init())
        self.minValue.setTitle("Minimum Rate For Last 7 day", for: .init())
        self.maxValue.setTitle("Maximum Rate For Last 7 day", for: .init())
        self.maxValue.setTitleColor(UIColor(red:0.9, green:0.58, blue:0.42, alpha:1.0), for: .init())
        self.minValue.setTitleColor(UIColor(red:0.9, green:0.58, blue:0.42, alpha:1.0), for: .init())
    }
}



extension DetailViewController: DetailViewProtocol{
    func setLabels(minValue: String, maxValue: String, imgName: String)  {
        self.minValue.setTitle("Mininum Rate: \(minValue)", for: .init())
        self.maxValue.setTitle("Maximum Rate: \(maxValue)", for: .init())
        self.img.image = UIImage(named: imgName)
    }
    
 
    
    
    func failureRequest() {
        let alert = UIAlertController(title: "An Error Occurred", message: "No exchange rate data is available for the selected currency.", preferredStyle: .alert)
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
        linearDiagram.xAxis.granularityEnabled = true
        linearDiagram.xAxis.labelPosition = .bottom
        linearDiagram.xAxis.granularity =  1

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
//        linearDiagram.leftAxis.gridColor = UIColor.clear
//        linearDiagram.xAxis.gridColor = UIColor.clear
        linearDiagram.leftAxis.labelTextColor = UIColor.clear
        linearDiagram.rightAxis.labelTextColor = UIColor.clear
//        linearDiagram.leftAxis.axisLineColor = UIColor.clear
//        linearDiagram.drawGridBackgroundEnabled = false
        linearDiagram.legend.enabled = false
        linearDiagram.xAxis.labelTextColor = UIColor(red:0.9, green:0.58, blue:0.42, alpha:1.0)
        linearDiagram.xAxis.labelFont = UIFont(name: "ArialMT", size: 10 ) ?? UIFont.italicSystemFont(ofSize: 10)
    

        
        
        linearDiagram.drawGridBackgroundEnabled = false
              linearDiagram.xAxis.drawAxisLineEnabled = false
              linearDiagram.xAxis.drawGridLinesEnabled = false
              linearDiagram.leftAxis.drawAxisLineEnabled = false
        linearDiagram.leftAxis.drawGridLinesEnabled = false
              linearDiagram.rightAxis.drawAxisLineEnabled = false
              linearDiagram.rightAxis.drawGridLinesEnabled = false
//              mChart.legend.enabled = false
//              mChart.xAxis.enabled = false
//              mChart.leftAxis.enabled = false
//              mChart.rightAxis.enabled = false
//              mChart.xAxis.drawLabelsEnabled = false

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
