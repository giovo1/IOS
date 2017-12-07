//
//  NewsTableViewCell.swift
//  NYTimesApp
//
//  Created by Giovanny Rocha on 11/22/17.
//  Copyright © 2017 Giovanny Rocha. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var labelResumeNews: UILabel!
    @IBOutlet weak var labelSourceNews: UILabel!
    @IBOutlet weak var labelDateNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
