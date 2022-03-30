//
//  StockDetailView.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//


import CoreData
import CorePlot
import UIKit

class StockDetailView: UIViewController, UITableViewDelegate, UITableViewDataSource, CPTScatterPlotDelegate, CPTScatterPlotDataSource {
    
    var oneMinute: Double = 60
    var selectedStock: Symbol?
    var graphData = [NSManagedObject]()

    var plot: CPTScatterPlot!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedStock = selectedStock else {
            return
        }
        
        initializeGraph()
        let navLabel = UILabel()
        navLabel.text = selectedStock.name
        navLabel.adjustsFontSizeToFitWidth = true
        navigationItem.titleView = navLabel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchGraphData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        guard let selectedStock = selectedStock else { return cell }

        if indexPath.row < 13 {
            guard let plainCell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? DetailStockCell else { return cell}
            plainCell.configure(selectedSymbol: selectedStock, row: indexPath.row)
            cell = plainCell
        } else {
            guard let changeCell = tableView.dequeueReusableCell(withIdentifier: "ChangeCell", for: indexPath) as? ChangeDetailCell else { return cell }
            changeCell.configure(selectedSymbol: selectedStock, row: indexPath.row)
            cell = changeCell
        }
        return cell
    }
    
    func initializeGraph() {
        graphView.configureGraphView()
        plot = CPTScatterPlot()
        graphView.configurePlot(vc: self, plot: plot)
    }
    
    func dateDifferenceInMinutes(from fromDate: Date, to toDate: Date) -> Double {
        let delta = toDate.timeIntervalSince(fromDate)
        return trunc(delta/60)
    }
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(graphData.count)
    }
    
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        switch CPTScatterPlotField(rawValue: Int(fieldEnum)) {
        case .X:
            return dateDifferenceInMinutes(from: .now, to: graphData[Int(idx)].value(forKeyPath: "date") as! Date)
        case .Y:
            return graphData[Int(idx)].value(forKeyPath: "changePercent")
        default:
            return 0
        }
    }
    
    // when testing graph it is recommended to let application run for few minutes so there is some significant amount of data to fetch
    func fetchGraphData() {
        guard let selectedStock = selectedStock else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Stock")
        let predicate = NSPredicate(format: "name = %@", argumentArray: [selectedStock.name])
        fetchRequest.predicate = predicate
        
        do {
            graphData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print ("Couldn't fetch data. \(error), \(error.userInfo)")
        }
    }

}
