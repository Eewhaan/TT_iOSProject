//
//  NewsTableController.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import UIKit

class NewsTableController: UITableViewController {
    
    var articlesList = [NewsArticle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.shared.getNewsArticles { newsArticles in
            self.articlesList = newsArticles
        }
        navigationItem.title = "Breaking News"

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            guard let firstCell = tableView.dequeueReusableCell(withIdentifier: "NewsFirstCell", for: indexPath) as? NewsTableFirstCell  else { return UITableViewCell() }
            firstCell.newsTitle.text = articlesList[0].headline
            cell = firstCell
            return cell
        } else {
            guard let newsCell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableCells else { return UITableViewCell() }
            newsCell.newsTitle.text = articlesList[indexPath.row].headline
            cell = newsCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "NewsDetail") as? NewsDetailVC else { return }
        navigationController?.pushViewController(vc, animated: true)
    }

}
