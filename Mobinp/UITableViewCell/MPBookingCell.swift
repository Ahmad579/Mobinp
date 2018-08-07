//
//  MPBookingCell.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit

class MPBookingCell: UITableViewCell {

    @IBOutlet var lblTitleOfUser: UILabel!
    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet weak var imageOfBooking: UIImageView!
    @IBOutlet var lblDate: UILabel!
    
    @IBOutlet var lblLoadSigning: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
