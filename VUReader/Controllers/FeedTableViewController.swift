//
//  ViewController.swift
//  ReaderX
//
//  Created by Venky Venkatakrishnan on 8/22/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    @IBOutlet weak var feedTableView: UITableView!
    
    var feed: Feed?
    var feedData: FeedData?
    
    let dateFormatter = DateFormatter()
 
   
    override func viewDidLoad() {
        
        // self.view.autoresizesSubviews = true
        
        super.viewDidLoad()
  
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        dateFormatter.dateFormat = "HH:mm"

        self.refreshControl = UIRefreshControl()
        
        self.refreshControl?.addTarget(self, action: #selector(FeedTableViewController.refreshData), for: .valueChanged)
        
        self.refreshControl?.beginRefreshing()
        getFeedData()
        
        
    }
    
    
    @objc func refreshData()
    {
        self.refreshControl?.beginRefreshing()
        getFeedData()
        
    }
  

    func getFeedData()
    {
        
        let url = URL(string: (self.feed!.url))
            
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
            
            
            guard error == nil else {
                print("Error fetching data from URL: \(error!)")
                return
            }
            
            guard let _ = data else {
                print("Error: did not receive data")
                return
            }
            
            
            DispatchQueue.main.async(execute: {
                self.readJSONFeedData(data: data!)
                self.navigationItem.title = self.feedData?.feedTitle
    
                self.feedTableView.reloadData()
                self.refreshControl?.endRefreshing()
            })
            
            
        }).resume()
    }
    
    
    func loadSampleFeed()
    {
        
         
         if let filePath = Bundle.main.path(forResource: "feed",  ofType: "json")
         {
             do
             {
             
                 let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
                 readJSONFeedData(data: data)
                
             }
             catch
             {
                print("Error reading data from file \(filePath)")
             }
         
         }
        
    }
    
    func readJSONFeedData(data: Data)
    {
        do
        {
            
            self.feedData = try JSONDecoder().decode(FeedData.self, from:  data)
            
        }
        catch
        {
            print("Error reading JSON data")
        }
        
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.feedData?.sections ?? 1
    }
    
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedData?.itemsInSections[section].count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.feedData?.sectionNames[section]
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellIdentifier = "SectionHeaderCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SectionHeaderTableViewCell
        
        cell?.labelSectionName.text = self.feedData?.sectionNames[section]
        
        return cell
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "FeedDataItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FeedItemTableViewCell
        
        let feedItem = self.feedData?.itemsInSections[indexPath.section][indexPath.row]
        
        cell.labelTitle.text = feedItem?.title
        cell.labelTitle.preferredMaxLayoutWidth = self.view.frame.width * 0.8
        cell.labelContent.attributedText = feedItem?.content
        cell.labelContent.preferredMaxLayoutWidth = self.view.frame.width * 0.6
        cell.labelContent.sizeToFit()
        
        cell.labelDatePublished.text = dateFormatter.string(from: feedItem?.datePub ?? Date())
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowFeedDataItem"
        {
            
            let feedItemViewController = segue.destination as! FeedItemViewController
            
            if let selectedFeedItemCell = sender as? FeedItemTableViewCell
            {
                let indexPath = tableView.indexPath(for: selectedFeedItemCell)!
                let selectedFeedItem = self.feedData?.itemsInSections[indexPath.section][indexPath.row]
                feedItemViewController.feedDataItem = selectedFeedItem
                feedItemViewController.feedTitle = self.feed?.name ?? "No Title"
                feedItemViewController.feedIcon = self.feedData?.feedIcon
            }
                
            
        }
    }
    
    
}


