//
//  Feed.swift
//  ReaderX
//
//  Created by Venky Venkatakrishnan on 9/6/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import UIKit

class Feed: NSObject, Decodable {
    
    var name: String
    var url: String

    
    init(name: String, url: String)
    {
        self.name = name
        self.url = url
    }
    
    
}


