//
//  StockTableCell.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 13.3.22..
//

import UIKit

class StockTableCell: UITableViewCell {
    var name: UILabel!
    var change: UILabel!
    var last: UILabel!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupViews() {
        name = UILabel()
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
            name.heightAnchor.constraint(equalToConstant: 50),
            
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
    
    func loadSetup () {
        self.name.numberOfLines = 2
        self.name.font = UIFont(name: "Avenir Book", size: 16)
        self.name.textAlignment = .left
        
        self.change.numberOfLines = 1
        self.change.font = UIFont(name: "Avenir Book", size: 16)
        self.change.textAlignment = .center
        
        self.last.numberOfLines = 1
        self.last.font = UIFont(name: "Avenir Book", size: 16)
        self.last.textAlignment = .center
    }
    
    func configure(symbol: Symbol) {
        
        self.name.text = symbol.name
        let double = (symbol.quote?.changePercent ?? 1 - 1)
        var textColor = UIColor()
        var backgroundColor = UIColor()
        if double > 0 {
            textColor = UIColor.systemGreen
            backgroundColor = UIColor.systemGreen
        } else if double < 0 {
            textColor = UIColor.systemRed
            backgroundColor = UIColor.systemRed
        } else {
            textColor = UIColor.label
            backgroundColor = UIColor.clear
        }
        self.change.text = String(format: "%.2f", double) + "%"
        self.change.textColor = textColor
        self.last.text = String(format: "%.2f", symbol.quote?.last ?? 0)
        UIView.animate(withDuration: 1.5, delay: 0, options: [], animations: { [weak self] in
            self?.last?.layer.backgroundColor = backgroundColor.cgColor
            self?.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.last?.layer.backgroundColor = UIColor.clear.cgColor
            })
        })
        
    }
}

