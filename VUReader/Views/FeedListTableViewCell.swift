//
//  FeedListTableViewCell.swift
//  ReaderX
//
//  Created by Venky Venkatakrishnan on 9/6/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import UIKit

class FeedListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFeedIcon: UIImageView!
    @IBOutlet weak var labelFeedName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
