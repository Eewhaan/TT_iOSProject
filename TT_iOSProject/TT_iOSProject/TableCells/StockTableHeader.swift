//
//  StockTableHeader.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 25.3.22..
//

import UIKit

class StockTableHeader: UITableViewHeaderFooterView {
    
    static let identifier = "StockHeader"
    var name: UIButton!
    var change: UILabel!
    var last: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupViews() {
        name = UIButton(type: .system)
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)
        
        change = UILabel()
        change.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(change)
        
        last = UILabel()
        last.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(last)
        
        NSLayoutConstraint.activate([
            
            name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            name.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            name.heightAnchor.constraint(equalToConstant: 40),
            
            change.leadingAnchor.constraint(equalTo: name.trailingAnchor),
            change.widthAnchor.constraint(equalToConstant: 60),
            change.centerYAnchor.constraint(equalTo: name.centerYAnchor),
            change.heightAnchor.constraint(equalTo: name.heightAnchor),
            
            last.leadingAnchor.constraint(equalTo: change.trailingAnchor),
            last.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            last.widthAnchor.constraint(equalToConstant: 95),
            last.centerYAnchor.constraint(equalTo: change.centerYAnchor),
            last.heightAnchor.constraint(equalTo: change.heightAnchor)
        
        ])
    }
    
    func loadSetup() {
        
        name.tintColor = UIColor.label
        name.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 15)
        name.setTitle("Name", for: .normal)
        name.setImage(UIImage(systemName: "arrow.up.arrow.down.square"), for: .normal)
        name.semanticContentAttribute = .forceRightToLeft
        name.contentHorizontalAlignment = .left
        
        change.font = UIFont(name: "Avenir Heavy", size: 15)
        change.textAlignment = .center
        change.text = "Change"
        
        last.font = UIFont(name: "Avenir Heavy", size: 15)
        last.textAlignment = .center
        last.text = "Last"
    }
    
}
