//
//  FeedList.swift
//  ReaderX
//
//  Created by Venky Venkatakrishnan on 9/6/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import UIKit



class FeedList: NSObject {
    
    var feeds: [Feed] = []
    
    var feedDefinitons: [[String: String]] = [ ["name": "Daring Fireball", "url": "https://daringfireball.net/feeds/json"],
                                               ["name": "Flying Meat",
                                                "url":
                               "http://flyingmeat.com/blog/feed.json"],
                                               ["name": "JSON Feed", "url": "https://jsonfeed.org/feed.json"],
                                               ["name": "Hypercritical", "url": "http://hypercritical.co/feeds/main.json"],["name": "Manton Reece", "url": "https://manton.org/feed.json"],
                                               ["name": "inessential",
                                                "url": "http://inessential.com/feed.json"]]
    
    
    override init()
    {
        super.init()
        
      //  loadSampleFeeds()
        
       getFeedList()
        
        
    }

    func loadSampleFeeds()
    {
        for item in self.feedDefinitons.enumerated()
        {
            
            self.feeds.append(Feed(name: item.element["name"]!,
                                   url: item.element["url"]! ))
        }
        
    }
    
    func getFeedList()
    {
        if let path = Bundle.main.path(forResource: "Feeds", ofType: "plist")
        {
            if let feeds = NSDictionary(contentsOfFile: path)
            {
            
                for item in feeds.enumerated()
                {
                    
                    if let feed = item.element.value as? NSDictionary
                    {
                
                      let name = feed["name"] as! String
                      let url = feed["url"] as! String
                        
                      self.feeds.append(Feed(name: name,
                                               url: url ))
                    }
                    
                }
            }
        }
    }
    
    
    func getFeedData(urlName: String)
    {
        
        let url = URL(string: urlName)
        
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
                do
                {
                    
                    let feed = try JSONDecoder().decode(Feed.self, from:  data!)
                    self.feeds.append(feed)
                    
                }
                catch
                {
                    print("Error reading JSON data")
                }
                
            })
            
            
        }).resume()
        
        
    }
    
    

}
