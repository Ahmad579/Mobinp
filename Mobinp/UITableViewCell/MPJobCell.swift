//
//  MPJobCell.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit

class MPJobCell: UITableViewCell {

    @IBOutlet var imgOfUser: UIImageView!
    
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblCompanyName: UILabel!

    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblCost: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
