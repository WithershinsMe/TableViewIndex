//
//  ViewController.swift
//  TableIndexView
//
//  Created by GK on 2017/10/8.
//  Copyright © 2017年 GK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var indexView: TableIndexView!
    @IBOutlet weak var tableView: UITableView!
    
    let indexes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var contactsBySection: [String: Array<String>] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        getContactsFromPlist()
        
        indexView.tableView = self.tableView;
        indexView.indexes = self.indexes;
        indexView.setup();
    }
    func getContactsFromPlist() {
        if let path = Bundle.main.path(forResource: "Contacts", ofType: "plist") {
            
            contactsBySection = NSDictionary(contentsOfFile: path) as! Dictionary<String, Array<String>>
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactsBySection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexes[section]
    }
    
    //    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    //        return indexes
    //    }
    
    //    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
    //        return index
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contacts = contactsBySection[indexes[section]]!
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let contacts = contactsBySection[indexes[indexPath.section]]!
        let contact = contacts[indexPath.row]
        
        cell.textLabel!.text = contact
        
        return cell
    }
    
}
