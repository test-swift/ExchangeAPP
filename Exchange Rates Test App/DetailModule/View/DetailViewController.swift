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
    @IBOutlet weak var diagramView: UIView!
    @IBOutlet weak var linearDiagram: LineChartView!
    @IBOutlet var btnStack: [UIButton]!
    @IBOutlet weak var img: UIImageView!
    
    var presenter: DetailViewPresenterPrototcol!
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoadingAnimation()
        diagramView.layer.cornerRadius = 10
        self.diagramView.backgroundColor =  UIColor(red:0.51, green:0.72, blue:0.29, alpha:0.6)
        self.setNavBar()
        self.setLabels(minValue: "0", maxValue: "0", imgName: "fag")
    }
    
    private func setNavBar(){
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "\(presenter.symbol) Exchange Rate History", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)])
        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
    }
}


extension DetailViewController: DetailViewProtocol{
    func setLabels(minValue: String, maxValue: String, imgName: String)  {
        for btn in btnStack{
            btn.backgroundColor = UIColor(red:0.51, green:0.72, blue:0.29, alpha:0.6)
            btn.layer.cornerRadius = 10
            btn.setTitleColor(UIColor(red:0.9, green:0.58, blue:0.42, alpha:1.0), for: .init())
        }
        btnStack[0].setTitle("Mininum Rate: \(minValue)", for: .init())
        btnStack[1].setTitle("Maximum Rate: \(maxValue)", for: .init())
        img.image = UIImage(named: imgName)
    }
    
    func failureRequest() {
        let alert = UIAlertController(
            title: "An Error Occurred",
            message: "No exchange rate data is available for the selected currency.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func setChart(values: [Double], label: [String]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        //MARK: Creating line
        let line = LineChartDataSet(entries: dataEntries)
        line.colors = [NSUIColor.blue]
        line.mode = .cubicBezier
        line.cubicIntensity = 0.2
        line.circleRadius = 7
        line.circleHoleRadius = 3
        let gradient = getGradientFilling()
        line.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        line.drawFilledEnabled = true
        let data = LineChartData()
        data.addDataSet(line)
        
        //MARK: Set axis
        linearDiagram.xAxis.valueFormatter = IndexAxisValueFormatter(values: label)
        linearDiagram.xAxis.granularityEnabled = true
        linearDiagram.xAxis.labelPosition = .bottom
        linearDiagram.xAxis.granularity =  1
        linearDiagram.data = data
        linearDiagram.leftAxis.labelTextColor = UIColor.clear
        linearDiagram.rightAxis.labelTextColor = UIColor.clear
        linearDiagram.legend.enabled = false
        linearDiagram.rightAxis.xOffset = 0
        linearDiagram.xAxis.labelTextColor = UIColor(red:0.9, green:0.58, blue:0.42, alpha:1.0)
        linearDiagram.xAxis.labelFont = UIFont(name: "ArialMT", size: 10 ) ?? UIFont.italicSystemFont(ofSize: 10)
        linearDiagram.drawGridBackgroundEnabled = false
        linearDiagram.xAxis.drawAxisLineEnabled = false
        linearDiagram.xAxis.drawGridLinesEnabled = false
        linearDiagram.leftAxis.drawAxisLineEnabled = false
        linearDiagram.leftAxis.drawGridLinesEnabled = false
        linearDiagram.rightAxis.drawAxisLineEnabled = false
        linearDiagram.rightAxis.drawGridLinesEnabled = false
        self.stopShowingLoadingAnimation()
    }
    
    //MARK: Creating gradient
    private func getGradientFilling() -> CGGradient {
        let coloTop = UIColor(red: 141/255, green: 133/255, blue: 220/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 230/255, green: 155/255, blue: 210/255, alpha: 1).cgColor
        let gradientColors = [coloTop, colorBottom] as CFArray
        let colorLocations: [CGFloat] = [0.7, 0.0]
        return CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)!
    }
    
    func showLoadingAnimation() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .green
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopShowingLoadingAnimation() {
        activityIndicator.stopAnimating()
    }
}
