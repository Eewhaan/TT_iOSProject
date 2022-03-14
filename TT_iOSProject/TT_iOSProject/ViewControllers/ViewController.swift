//
//  ViewController.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 13.3.22..
//

import UIKit

class ViewController: UITableViewController {
    
    var symbolList = [Symbol]()
    var refreshTime = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Hot Stocks"
        DataService.shared.getSymbols { symbols in
            self.symbolList = symbols
        }
//
//        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(reloadData))
//        swipeGestureRecognizer.direction = .down
//        view.addGestureRecognizer(swipeGestureRecognizer)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symbolList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? StockTableCell else { return UITableViewCell() }
        cell.name.text = symbolList[indexPath.row].name
        cell.last.text = "\(symbolList[indexPath.row].quote?.last)"
        let double = (symbolList[indexPath.row].quote?.changePercent ?? 1 - 1)
        let changeString = String(format: "%.2f", double)
        cell.change.text = changeString + "%"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "StockDetail") as? StockDetailView else { return }
        vc.selectedStock = symbolList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            symbolList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        
        let width = (headerView.frame.width - 20)/3
        let height = headerView.frame.height - 10
        let sortButton = UIButton(type: .system)
        sortButton.setTitle("Name", for: .normal)
        sortButton.frame = CGRect.init(x: 5, y: 5, width: width, height: height)
        headerView.addSubview(sortButton)
        
        let changeLabel = UILabel()
        changeLabel.frame = CGRect.init(x: (headerView.frame.width - 20)/3 + 5, y: 5, width: width, height: height)
        changeLabel.text = "Change"
        changeLabel.font = .systemFont(ofSize: 15)
        changeLabel.textColor = .black
        changeLabel.textAlignment = .center
        
        headerView.addSubview(changeLabel)
        
        let lastLabel = UILabel()
        lastLabel.frame = CGRect.init(x: (headerView.frame.width - 20)/1.5 + 5, y: 5, width: width, height: height)
        lastLabel.text = "Last"
        lastLabel.font = .systemFont(ofSize: 15)
        lastLabel.textColor = .black
        lastLabel.textAlignment = .center
        
        headerView.addSubview(lastLabel)
               
        return headerView
    }
    
//    func autoReloadData() {
//        refreshTime = TimeInterval.random(in: refreshTime...30)
//        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + refreshTime) { [weak self] in
//            self?.reloadData()
//        }
//        refreshTime = TimeInterval.random(in: (refreshTime * 0.8)...(refreshTime * 1.2))
//    }
//    
//    @objc func reloadData() {
//        DataService.shared.getSymbols()
//        DispatchQueue.main.async { [weak self] in
//            self?.tableView.reloadData()
//        }
//
//    }
    
    func sortItemsByName(_ items: [Symbol]) -> [Symbol] {
        items.sorted { itemA, itemB in
            itemA.name < itemB.name
        }
    }

}
