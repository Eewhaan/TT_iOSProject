//
//  NewsTableController.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import UIKit

class NewsTableController: UITableViewController {
    
    var articlesList = [NewsArticle]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    var numberOfRows = 0

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
            if let imageID = articlesList[0].imageID {
                let imageURL = URL(string: "https://cdn.ttweb.net/News/images/\(imageID).jpg?preset=w220_q40")
                if let imageURL = imageURL {
                    firstCell.newsImage.load(url: imageURL)
                    
                }
            }
            cell = firstCell
            return cell
            
        } else {
            guard let newsCell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableCells else { return UITableViewCell() }
            newsCell.newsTitle.text = articlesList[indexPath.row].headline
            if let imageID = articlesList[indexPath.row].imageID {
                let imageURL = URL(string: "https://cdn.ttweb.net/News/images/\(imageID).jpg?preset=w220_q40")
                if let imageURL = imageURL {
                    newsCell.newsImage.load(url: imageURL)
                    
                }
            }
            cell = newsCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 170
        } else {
            return 70
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "NewsDetail") as? NewsDetailVC else { return }
        vc.selectedArticle = articlesList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}
