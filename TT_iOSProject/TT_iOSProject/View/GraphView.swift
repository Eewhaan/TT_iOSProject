//
//  Graph.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 26.3.22..
//

import CorePlot
import UIKit


class GraphView: CPTGraphHostingView {
    
    func configureGraphView() {
        
        let graph = CPTXYGraph(frame: self.bounds)
        graph.plotAreaFrame?.masksToBounds = false
        self.hostedGraph = graph
        graph.backgroundColor = UIColor.systemBackground.cgColor
        graph.paddingBottom = 0
        graph.paddingLeft = 0
        graph.paddingTop = 0
        graph.paddingRight = 0
        
        graph.plotAreaFrame?.masksToBorder = false;
        graph.plotAreaFrame?.borderLineStyle = nil
        graph.plotAreaFrame?.cornerRadius = 0.0
        graph.plotAreaFrame?.paddingTop = 30
        graph.plotAreaFrame?.paddingLeft = 35
        graph.plotAreaFrame?.paddingBottom = 30
        graph.plotAreaFrame?.paddingRight = 10.0
        
        let titleTextStyle = CPTMutableTextStyle()
        titleTextStyle.font = UIFont(name: "Avenir Heavy", size: 16)
        titleTextStyle.color = CPTColor(cgColor: UIColor.systemIndigo.cgColor)
        graph.titleTextStyle = titleTextStyle
        graph.title = "Change in last 30 minutes"
        
        
        configureAxis(graph: graph)
                
    }
    
    func configureAxis(graph: CPTXYGraph) {
        let axisSet = graph.axisSet as? CPTXYAxisSet
        
        let axisTextStyle = CPTMutableTextStyle()
        axisTextStyle.font = UIFont(name: "Avenir", size: 13)
        axisTextStyle.color = CPTColor.init(cgColor: UIColor.label.cgColor)
        axisTextStyle.textAlignment = .center
        
        let lineStyle = CPTMutableLineStyle()
        lineStyle.lineColor = CPTColor.init(cgColor: UIColor.label.cgColor)
        lineStyle.lineWidth = 3
        
        let gridLineStyle = CPTMutableLineStyle()
        gridLineStyle.lineColor = CPTColor.lightGray()
        gridLineStyle.lineWidth = 0.5
        
        if let x = axisSet?.xAxis {
            x.majorIntervalLength = 10
            x.minorTicksPerInterval = 2
            x.labelTextStyle = axisTextStyle
            x.minorGridLineStyle = gridLineStyle
            x.majorGridLineStyle = gridLineStyle
            x.axisLineStyle = lineStyle
            x.axisConstraints = CPTConstraints(lowerOffset: 0.0)
            let vc = StockDetailView()
            x.delegate = vc
        }
        
        if let y = axisSet?.yAxis {
            y.majorIntervalLength = 20
            y.minorTicksPerInterval = 2
            y.minorGridLineStyle = gridLineStyle
            y.majorGridLineStyle = gridLineStyle
            y.axisLineStyle = lineStyle
            y.labelTextStyle = axisTextStyle
            y.axisConstraints = CPTConstraints(lowerOffset: 0.0)
            let vc = StockDetailView()
            y.delegate = vc
            
        }
    }
    
    func configurePlot(vc: StockDetailView, plot: CPTScatterPlot) {
        
        let plotLineStile = CPTMutableLineStyle()
        plotLineStile.lineJoin = .round
        plotLineStile.lineCap = .round
        plotLineStile.lineWidth = 2
        plotLineStile.lineColor = CPTColor.init(cgColor: UIColor.systemIndigo.cgColor)
        plot.dataLineStyle = plotLineStile
        plot.curvedInterpolationOption = .hermiteCubic
        plot.interpolation = .linear
        plot.dataSource = vc
        plot.delegate = vc
        
        guard let graph = self.hostedGraph else { return }
        let plotSpace = graph.defaultPlotSpace as! CPTXYPlotSpace
        plotSpace.xRange = CPTPlotRange(location: -30, length: NSNumber(35))
        plotSpace.yRange = CPTPlotRange(location: -40, length: NSNumber(80))
        graph.add(plot, to: graph.defaultPlotSpace)
    }

}
