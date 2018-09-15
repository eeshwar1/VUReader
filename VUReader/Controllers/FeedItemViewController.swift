//
//  FeedItemViewController.swift
//  ReaderX
//
//  Created by Venky Venkatakrishnan on 8/25/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import UIKit

class FeedItemViewController: UIViewController {

    @IBOutlet weak var imageFeedIcon: UIImageView!
    @IBOutlet weak var labelFeedTitle: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDatePublished: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var feedTitle: String = ""
    var feedIcon: UIImage!
    
    var feedDataItem: FeedDataItem?
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let feedDataItem = feedDataItem {
            
            self.labelFeedTitle.text = self.feedTitle
            self.labelTitle.text = feedDataItem.title
            self.labelTitle.preferredMaxLayoutWidth = self.view.frame.width * 0.9
            
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
            self.labelDatePublished.text = dateFormatter.string(from: feedDataItem.datePub)
            self.textView.text = feedDataItem.content.string
            
    
                
            let imageSize = self.imageFeedIcon.frame.size
                
            let scaledImage = self.feedIcon.scaled(to: imageSize, scalingMode: .aspectFit)
            self.imageFeedIcon.image = scaledImage
            
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            let topOffset = CGPoint(x: 0, y: -self.textView.contentInset.top)
            self.textView.setContentOffset(topOffset, animated: false)
        }
       
    }

 

}
