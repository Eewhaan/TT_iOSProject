//
//  NewsTableController.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import UIKit

class NewsTableController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Breaking News"

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            guard let firstCell = tableView.dequeueReusableCell(withIdentifier: "NewsFirstCell", for: indexPath) as? NewsTableFirstCell  else { return UITableViewCell() }
            firstCell.newsTitle.text = "First cell"
            cell = firstCell
            return cell
        } else {
            guard let newsCell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableCells else { return UITableViewCell() }
            newsCell.newsTitle.text = "Second cell"
            cell = newsCell
            return cell
        }
    }

}
