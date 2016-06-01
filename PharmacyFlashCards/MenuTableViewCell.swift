//
//  MenuTableViewCell.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 5/20/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var leftImageView: UIView!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var leftImageTitle: UILabel!
    
    @IBOutlet weak var rightImageView: UIView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var rightImageTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
