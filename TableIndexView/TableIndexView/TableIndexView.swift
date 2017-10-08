//
//  TableIndexView.swift
//  SampleContactList
//
//  Created by GK on 2017/9/30.
//  Copyright © 2017年 Stephen Lindauer. All rights reserved.
//

import Foundation
import UIKit

class TableIndexView: UIView {
    
    var indexes: [String]!
    var tableView: UITableView!
    
    func setup() {
        
        self.isExclusiveTouch  = true
        translatesAutoresizingMaskIntoConstraints = false
        
        var views = [String:UILabel]()
        var verticalLayoutString = "V:|"
        
        for i in 0..<indexes.count {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            label.text = indexes[i]
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(label)
            views["label\(i)"] = label
            
            if i == 0 {
                verticalLayoutString += "[label\(i)]"
            }
            else {
                verticalLayoutString += "[label\(i)(==label0)]"
            }
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label\(i)]|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: [:], views: views))
        }
        
        verticalLayoutString += "|"
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalLayoutString, options: NSLayoutFormatOptions.alignAllCenterX, metrics: [:], views: views))
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(indexViewWasDragged))
        addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(indexViewWasDragged))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func indexViewWasDragged(_ gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: self)
        let index = max(min(Int(point.y / frame.height * CGFloat(indexes.count)), indexes.count-1), 0)
        let percentInSection = max(point.y / frame.height * CGFloat(indexes.count) - CGFloat(index), 0)
        scrollToIndex(index, percentInSection: percentInSection)
    }
    func scrollToIndex(_ index: Int, percentInSection: CGFloat) {
        var section = index
        var rows = self.tableView.dataSource!.tableView(tableView, numberOfRowsInSection: section)
        var row = Int(CGFloat(rows) * percentInSection)
        let numberOfSectionsInTable = tableView.dataSource!.numberOfSections!(in: tableView)
        
        if (rows == 0 && section < numberOfSectionsInTable-1) {
            return;
        }
        
//        while (rows == 0 && section < numberOfSectionsInTable-1) {
//            section += 1
//            rows = self.tableView.dataSource!.tableView(tableView, numberOfRowsInSection: section)
//            row = 0
//        }
//
//        if (rows != 0) {
//            let indexPath = IndexPath(row: row, section: section)
//            tableView.scrollToRow(at: indexPath, at: .top, animated: false)
//        }

        
        if (rows != 0) {
           let tmpIndex  = self.tableView.numberOfRows(inSection: section)
            if (row <= tmpIndex && row != 0 ) {
                let indexPath = IndexPath(row: row, section: section)
                tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }
          
        }
    }
}
