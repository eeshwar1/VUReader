//
//  FeedListViewController.swift
//  ReaderX
//
//  Created by Venky Venkatakrishnan on 9/6/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import UIKit

class FeedListTableViewController: UITableViewController {

    @IBOutlet weak var feedListTableView: UITableView!
    
    var feedList: FeedList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedList = FeedList()

    }
    
    @IBAction func reloadFeedList()
    {
        self.feedListTableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feedList.feeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "FeedCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FeedListTableViewCell
        
        let feed = self.feedList.feeds[indexPath.row]
        
        cell.labelFeedName.text = feed.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowFeed"
        {
            
            let feedTableViewController = segue.destination as! FeedTableViewController
            
            if let selectedFeedCell = sender as? FeedListTableViewCell
            {
                let indexPath = tableView.indexPath(for: selectedFeedCell)!
                let selectedFeed = self.feedList.feeds[indexPath.row]
                feedTableViewController.feed = selectedFeed
            }
            
        }
    }
    
    @IBAction func unwindToFeedList(_ sender: UIStoryboardSegue) {
        
    }
    
}
