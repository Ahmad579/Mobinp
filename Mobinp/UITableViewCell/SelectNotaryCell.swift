//
//  SelectNotaryCell.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 21/03/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit

protocol SelectNotaryUser {
    func selectUer(selectCell : SelectNotaryCell , indexPath : IndexPath)
    
}

class SelectNotaryCell: UITableViewCell {
    
    var delegate: SelectNotaryUser?
    var index: IndexPath?
    @IBOutlet weak var btnRequestSent_Pressed: UIButton!

    @IBOutlet var userName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnSendRequest(_ sender: UIButton) {
        self.delegate?.selectUer(selectCell : self  , indexPath : index!)
        
        
    }

    
}
