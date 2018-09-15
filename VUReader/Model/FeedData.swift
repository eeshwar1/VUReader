//
//  Feed.swift
//  FeedReader
//
//  Created by Venky Venkatakrishnan on 8/18/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import UIKit

class FeedData: NSObject, Decodable {
    
    var feedTitle: String
    var homePageURL: String
    var feedURL: String
    
    var feedIcon: UIImage?
    var faviconURL: String
    var items:[FeedDataItem] = []
    var itemsInSections: Array<Array<FeedDataItem>> = []
    var sectionNames: [String] = []
    var sections: Int = 1
    
    let dateFormatter = DateFormatter()
    
    init(feedTitle: String, homePageURL: String, feedURL: String, feedIcon: UIImage, faviconURL: String, items: [FeedDataItem])
    {
        
        self.feedTitle = feedTitle
        self.homePageURL = homePageURL
        self.feedURL = feedURL
        self.feedIcon = feedIcon
        self.faviconURL = faviconURL
        self.items = items
        
        super.init()
        
        
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "America/New_York")
        
        self.sectionizeFeed()
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case homePageURL = "home_page_url"
        case feedURL = "feed_url"
        case icon
        case favicon
        case items
    }
    
    
    required convenience init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
      
        let feedTitle: String = try container.decode(String.self, forKey: .title)
        
        let homePageURL = try container.decode(String.self,
                                               forKey: .homePageURL)
      
        let feedURL = try container.decode(String.self, forKey: .feedURL)
     
       
        var iconURL: String
        var feedIcon: UIImage
        
        do
        {
            
            iconURL =  try container.decode(String.self, forKey: .icon)
            
            let url = URL(string: iconURL)
            let data = try? Data(contentsOf: url!)
            feedIcon = UIImage(data: data!)!
        }
        catch
        {
            iconURL = ""
            feedIcon = UIImage(imageLiteralResourceName: "Default Feed Icon")
        }
        
        var faviconURL: String
        do
        {
           
            faviconURL =  try container.decode(String.self, forKey: .favicon)
        }
        catch
        {
            faviconURL = ""
        }
        
        let items =  try container.decode([FeedDataItem].self, forKey: .items)
        
        self.init(feedTitle: feedTitle, homePageURL: homePageURL, feedURL: feedURL, feedIcon: feedIcon, faviconURL: faviconURL, items: items)
        
    }
    
    func sectionizeFeed()
    {
    
        dateFormatter.dateFormat = "EEEE, dd MMMM yyyy"
        
        var prevDate: String?
        var currDate: String?
        
        prevDate = nil
        currDate = nil
        
        var sectionNumber = 0
        
        var sectionArray: [FeedDataItem] = []
        for item in self.items
        {
            prevDate = currDate
            
            currDate = dateFormatter.string(from: item.datePub)
            
            
            if (prevDate != nil && prevDate != currDate)
            {
                sectionNumber += 1
                itemsInSections.append(sectionArray)
                sectionArray = []
            
                sectionNames.append(prevDate ?? "Invalid Date")
            }
            
            item.section = sectionNumber
            sectionArray.append(item)
            
         
            
        }
        
        itemsInSections.append(sectionArray)
        self.sectionNames.append(currDate ?? "Invalid Date")
        
        self.sections = sectionNumber + 1
        
       
    }
    
    
}

