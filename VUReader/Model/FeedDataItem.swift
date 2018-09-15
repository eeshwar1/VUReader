//
//  FeedItem.swift
//  FeedReader
//
//  Created by Venky Venkatakrishnan on 8/18/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import UIKit

class FeedDataItem: NSObject, Decodable {
    
    var section: Int = 0
    var title: String
    var datePub: Date
    var url: String
    var contentHTML: String
    var content: NSAttributedString = NSAttributedString(string: "")
    
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case datePub = "date_published"
        case url
        case contentHTML = "content_html"
    }
    
    init(title: String, datePub: Date, url: String, contentHTML: String)
    {
        self.title = title
        self.datePub = datePub
        self.url = url
        self.contentHTML = contentHTML
        self.content = self.contentHTML.htmlToAttributedString ?? NSAttributedString(string: "Error decoding HTML text")
        
        let textFont = UIFont.systemFont(ofSize: 18)
        let fontAttribute =  [NSAttributedString.Key.font: textFont]
        self.content = NSAttributedString(string: self.content.string, attributes: fontAttribute)
    }
    
 
    required convenience init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var title: String
        do
        {
            title = try container.decode(String.self, forKey: .title)
        }
        catch
        {
            title = ""
        }
     
        let datePub = try container.decode(String.self,
                                               forKey: .datePub)
       
        let url =  try container.decode(String.self, forKey: .url)
        
        
        let contentHTML = try container.decode(String.self, forKey: .contentHTML)
        
    
        let dateFormatter = DateFormatter()
        
        
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "America/New_York")
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ssZ"
        

        let datePubVal = dateFormatter.date(from: datePub) ?? Date()
        
        self.init(title: title, datePub: datePubVal, url: url, contentHTML: contentHTML)
       
 
    }
    

}
