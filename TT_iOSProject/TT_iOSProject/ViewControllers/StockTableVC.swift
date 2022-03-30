//
//  ViewController.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 13.3.22..
//
import CoreData
import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
       
    var symbolList = [Symbol]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            for symbol in symbolList {
                guard let newDate = symbol.quote?.dateTime, let newChangePercent = symbol.quote?.changePercent else { return }
                let name = symbol.name
                DispatchQueue.main.async { [weak self] in
                    self?.saveGraphData(name: name, date: newDate, changePercent: newChangePercent)
                }
            }
        }
    }

    var sortedSymbolList = [Symbol]()
    var refreshTime = 3.0 {
        didSet {
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: refreshTime, target: self, selector: #selector(autoReloadData), userInfo: nil, repeats: false)
        }
    }
    var timer: Timer?
    var clickCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(StockTableCell.self, forCellReuseIdentifier: "StockCell")
        tableView.register(StockTableHeader.self, forHeaderFooterViewReuseIdentifier: StockTableHeader.identifier)

        navigationItem.title = "Hot Stocks"
        DataService.shared.getSymbols { symbols in
            self.symbolList = symbols
            self.sortSymbols()
        }
        
        clickCounter = UserDefaults.standard.integer(forKey: "Sort")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        timer = Timer.scheduledTimer(timeInterval: refreshTime, target: self, selector: #selector(autoReloadData), userInfo: nil, repeats: false)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.set(0, forKey: "View")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedSymbolList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? StockTableCell else { return UITableViewCell() }
        cell.loadSetup()
        cell.configure(symbol: sortedSymbolList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "StockDetail") as? StockDetailView else { return }
        vc.selectedStock = sortedSymbolList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sortedSymbolList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: StockTableHeader.identifier) as? StockTableHeader else { return nil}
        header.loadSetup()
        header.name.addTarget(self, action: #selector(sortTapped), for: .touchUpInside)
        return header
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    
    @objc func autoReloadData() {
        if refreshTime > 29 {
            refreshTime = 3
        }
        reloadData()
        refreshTime = TimeInterval.random(in: refreshTime...30)
        refreshTime = TimeInterval.random(in: (refreshTime * 0.8)...(refreshTime * 1.2))
    }
    
    
    @objc func reloadData() {
        DataService.shared.getSymbols{ symbols in
            self.symbolList = symbols
            self.sortSymbols()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                self?.tableView.refreshControl?.endRefreshing()
                self?.tableView.refreshControl?.isHidden = true
                self?.tableView.reloadData()
            }
        }
    }
    
    
    func sortSymbols() {
        switch clickCounter {
        case 0:
            sortedSymbolList = symbolList
        case 1:
            sortedSymbolList = sortByNameAscending(symbolList)
        case 2:
            sortedSymbolList = sortByNameDescending(symbolList)
        default:
            break
        }
    }
    
    
    func sortByNameAscending(_ items: [Symbol]) -> [Symbol] {
        items.sorted { itemA, itemB in
            itemA.name < itemB.name
        }
    }
    
    
    func sortByNameDescending(_ items: [Symbol]) -> [Symbol] {
        items.sorted { itemA, itemB in
            itemA.name > itemB.name
        }
    }
    
    
    @objc func sortTapped(_ sender: UIButton) {
        clickCounter += 1
        if clickCounter == 3 {
            clickCounter = 0
        }
        sortSymbols()
        tableView.reloadData()
        UserDefaults.standard.set(clickCounter, forKey: "Sort")
    }
    
    // since app doesn't have access to real stock market sever we mimic change traffic by saving everything to Core Data
    func saveGraphData(name: String, date: Date, changePercent: Double) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Stock", in: managedContext) else { return }
        
        let stock = NSManagedObject(entity: entity, insertInto: managedContext)
        stock.setValue(date, forKeyPath: "date")
        stock.setValue(changePercent, forKeyPath: "changePercent")
        stock.setValue(name, forKeyPath: "name")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
    }

}
