//
//  ViewController.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 13.3.22..
//

import UIKit

class ViewController: UITableViewController {
    
    var symbolList = [Symbol]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.clickCounter = 0
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortSymbols))
        navigationItem.title = "Hot Stocks"
        DataService.shared.getSymbols { symbols in
            self.symbolList = symbols
            self.sortedSymbolList = self.symbolList
        }
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        timer = Timer.scheduledTimer(timeInterval: refreshTime, target: self, selector: #selector(autoReloadData), userInfo: nil, repeats: false)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.set(0, forKey: "View")

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedSymbolList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? StockTableCell else { return UITableViewCell() }
        cell.name.text = sortedSymbolList[indexPath.row].name
        
        var color = UIColor()
        let double = (sortedSymbolList[indexPath.row].quote?.changePercent ?? 1 - 1)
        if double > 0 {
            color = UIColor.systemGreen
        } else if double < 0 {
            color = UIColor.systemRed
        } else {
            color = UIColor.black
        }
        let changeString = String(format: "%.2f", double)
        cell.change.text = changeString + "%"
        cell.change.textColor = color
        if let last = sortedSymbolList[indexPath.row].quote?.last {
            cell.last.text = "\(String(format: "%.2f", last))"
            var color = UIColor()
            if double > 0 {
                color = UIColor.systemGreen
            } else if double < 0 {
                color = UIColor.systemRed
            } else {
                color = UIColor.clear
            }
            UIView.animate(withDuration: 1.5, delay: 0, options: [], animations: {
                cell.last.layer.backgroundColor = color.cgColor
                cell.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, animations: {
                    cell.last.layer.backgroundColor = UIColor.clear.cgColor
                    
                })
            })
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "StockDetail") as? StockDetailView else { return }
        vc.selectedStock = sortedSymbolList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sortedSymbolList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        }
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
            self.sortedSymbolList = self.symbolList
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                self?.tableView.refreshControl?.endRefreshing()
                self?.tableView.refreshControl?.isHidden = true
                self?.tableView.reloadData()
            }
        }
    }
    
    
    @objc func sortSymbols() {

        clickCounter += 1

        switch clickCounter {
        case 1:
            sortedSymbolList = sortByNameAscending(symbolList)
        case 2:
            sortedSymbolList = sortByNameDescending(symbolList)
        case 3:
            sortedSymbolList = symbolList
            clickCounter = 0
        default:
            break
        }
        tableView.reloadData()
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


}
