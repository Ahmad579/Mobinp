//
//  ClientReciveNotifyCell.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 11/04/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit

protocol AttachFile_Pressed {
    func selectFile(checkCell : ClientReciveNotifyCell , indexPath : IndexPath)
    
}


class ClientReciveNotifyCell: UITableViewCell {

    var delegate: AttachFile_Pressed?
    var index: IndexPath?

    @IBOutlet var lblSigningAgent: UILabel!
    
     @IBOutlet weak var collectionViewCell: UICollectionView!
    var certificateList : [GETALLCertificateObject]?

    @IBOutlet var lblProcessingCost: UILabel!
    @IBOutlet var lblLuanguage: UILabel!
    @IBOutlet var lblComissionNum: UILabel!
    @IBOutlet var lblYearOfExperience: UILabel!
    
    @IBOutlet var lblDeliveryCost: UILabel!
    
    @IBOutlet var lblOtherCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAttachFile_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.delegate?.selectFile(checkCell : self  , indexPath : index!)

    
    }


}

extension ClientReciveNotifyCell : UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (certificateList?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        CertifcateCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CertifcateCell", for: indexPath) as! CertifcateCell
        
        WAShareHelper.loadImage(urlstring: (certificateList![indexPath.row].url)! , imageView: cell.imgOfCertificate, placeHolder: "rectangle_placeholder")
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = self.collectionViewCell.frame.size.width/2
        //        let heightOfCell = self.collectionViewCell.frame.size.height/6
        
        return CGSize(width: sizeOfCell, height: 114.0)
    }
    
    
}


