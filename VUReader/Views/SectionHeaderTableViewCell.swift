//
//  SectionHeaderTableViewCell.swift
//  ReaderX
//
//  Created by Venky Venkatakrishnan on 9/9/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import UIKit

class SectionHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var labelSectionName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
