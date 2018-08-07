//
//  MPLuanguageHeaderCe.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 03/07/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
protocol AddLuanguageDelegate {
    func addLuanguage(checkCell : MPLuanguageHeaderCe , indexPath : IndexPath)
    
}
class MPLuanguageHeaderCe: UITableViewCell {

    @IBOutlet weak var btnAddLuanguage: UIButton!
    var delegate: AddLuanguageDelegate?
    var index: IndexPath?
   
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAddLangugae_Pressed(_ sender: UIButton) {
        print("Print")
    }
    
    
//    @IBAction func btnAddLuanguage_Pressed(_ sender: UIButton) {
//            print("Ahmad")
////        self.delegate?.addLuanguage(checkCell : self  , indexPath : index!)
//
//
//    }
    
}
