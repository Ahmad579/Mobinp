//
//  NotaryProfileCell.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 11/04/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import Cosmos


class NotaryProfileCell: UITableViewCell {
    
    var certificateList : [GETALLCertificateObject]?
    @IBOutlet weak var collectionViewCell: UICollectionView!
    
    @IBOutlet var viewOfReview: CosmosView!
    @IBOutlet var lblServiceTitle: UILabel!
    
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var lblDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension NotaryProfileCell : UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
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

