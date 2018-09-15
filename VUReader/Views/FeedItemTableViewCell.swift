//
//  ReaderTableViewCell.swift
//  ReaderX
//
//  Created by Venky Venkatakrishnan on 8/23/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import UIKit

class FeedItemTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDatePublished: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
