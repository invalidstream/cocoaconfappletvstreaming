//
// DemoListViewController.swift
//  TVStreamingDemo
//
//  Created by Chris Adamson on 9/8/16.
//  Copyright © 2016 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit

class DemoListViewController: UITableViewController {

    var demoItems : [DemoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDemos()
    }
    
    private func loadDemos() {
        guard let url = URL(string:
            "http://invalidstream.com/cocoaconf-16/cocoaconf-hls-demo.json")
             else { return }
        
        do {
            let data = try Data (contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data)
            if let demos = json as? [ [String : AnyObject] ] {
                demoItems.removeAll()
                for demo in demos {
                    guard let title = demo["title"] as? String,
                        let description = demo["description"] as? String,
                        let urlString = demo["url"] as? String,
                        let url = URL(string: urlString) else { continue }
                    
                    let demoItem = DemoItem(title: title, description: description, url: url)
                    demoItems.append (demoItem)
                }
                tableView.reloadData()
                if demoItems.count > 1 {
                    let selectionPath = IndexPath(row: 0, section: 0)
                    tableView.selectRow(at: selectionPath, animated: true, scrollPosition: .none)
                    updateDetailFor(indexPath: selectionPath)
                }
            }
        } catch let error {
            NSLog ("couldn't load from \(url): \(error)")
            return
        }
    }
    
    private func updateDetailFor(indexPath: IndexPath) {
        if let splitViewController = splitViewController,
            splitViewController.viewControllers.count > 1 {
            if let detailVC = splitViewController.viewControllers[1] as? DemoDetailViewController {
                detailVC.demoItem = demoItems[indexPath.row]
            }
            guard let demoSplitViewController = splitViewController as? DemoSplitViewController else { return }
            demoSplitViewController.updateFocusToDetailViewController()
        }
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoItemCell", for: indexPath)
        cell.textLabel!.text = demoItems[indexPath.row].title
        NSLog ("delegate: \(tableView.delegate)")
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateDetailFor(indexPath: indexPath)
    }

    
}
