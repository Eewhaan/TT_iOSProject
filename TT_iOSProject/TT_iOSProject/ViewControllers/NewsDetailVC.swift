
//
//  NewsDetailVC.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import UIKit

class NewsDetailVC: UIViewController {
    private let newsImage = UIImageView()
    private let titleLabel = UILabel()
    private let shadeView = UIView()
    
    private var portraitConstr = [NSLayoutConstraint]()
    private var landscapeConstr = [NSLayoutConstraint]()
    
    var selectedArticle: NewsArticle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsImage)
        
        shadeView.translatesAutoresizingMaskIntoConstraints = false
        shadeView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.addSubview(shadeView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = selectedArticle?.headline
        titleLabel.font = UIFont(name: "Avenir", size: 16)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.white
        view.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        portraitConstr = [
            newsImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            newsImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newsImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 180),
            
            shadeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shadeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shadeView.bottomAnchor.constraint(equalTo: newsImage.bottomAnchor),
            shadeView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.bottomAnchor.constraint(equalTo: shadeView.bottomAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ]
        
        landscapeConstr = [
            newsImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            newsImage.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            newsImage.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 300),
            
            shadeView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            shadeView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            shadeView.bottomAnchor.constraint(equalTo: newsImage.bottomAnchor),
            shadeView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.bottomAnchor.constraint(equalTo: shadeView.bottomAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ]
        
        if UIDevice.current.orientation.isLandscape {
            loadLandscapeSetup()
        } else {
            loadPortraitSetup()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isPortrait {
            loadPortraitSetup()
        } else {
            loadLandscapeSetup()
        }
    }
    
    func loadPortraitSetup() {
        if let id = selectedArticle?.imageID,
           let url = URL(string: "https://cdn.ttweb.net/News/images/\(id).jpg?preset=w320_q50") {
            newsImage.load(url: url)
        }
        NSLayoutConstraint.deactivate(landscapeConstr)
        NSLayoutConstraint.activate(portraitConstr)
    }
    
    func loadLandscapeSetup() {
        if let id = selectedArticle?.imageID,
           let url = URL(string: "https://cdn.ttweb.net/News/images/\(id).jpg?preset=w800_q70") {
            newsImage.load(url: url)
        }
        NSLayoutConstraint.deactivate(portraitConstr)
        NSLayoutConstraint.activate(landscapeConstr)
    }
}
