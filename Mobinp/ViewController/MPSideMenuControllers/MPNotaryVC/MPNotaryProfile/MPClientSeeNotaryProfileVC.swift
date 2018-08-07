//
//  MPClientSeeNotaryProfileVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 11/04/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView
import Cosmos
class MPClientSeeNotaryProfileVC: UIViewController {
    
    var selectNotaryList: UserInformation?

    @IBOutlet weak var viewOfRating: CosmosView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var imgeOfUser: UIImageView!
    var responseObj: UserResponse?
    
    @IBOutlet var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getNotaryProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getNotaryProfile() {
     
        let notarySelected = self.selectNotaryList?.id

        
        let serviceURL =  NOTARYPROFILEOFCLIENT + "?api_token=\(localUserData.apiToken!)&notary_id=\(notarySelected!)"

        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Get Notary Profile", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            
            
            if  self.responseObj?.success == true {
                
                self.lblUserName.text = self.responseObj?.notaryProfile?.userProfile?.username
                let cgFloat: CGFloat = self.imgeOfUser.frame.size.width/2.0
                let someFloat = Float(cgFloat)
                WAShareHelper.setViewCornerRadius(self.imgeOfUser , radius: CGFloat(someFloat))
                let imageOfUser = self.responseObj?.notaryProfile?.userProfile?.avatar_url?.replacingOccurrences(of: " ", with: "%20")
                WAShareHelper.loadImage(urlstring:imageOfUser! , imageView: self.imgeOfUser!, placeHolder: "image_placeholder")
                
//                self.viewOfRating.rating = self.responseObj?.notaryProfile?.userProfile?.ratedNotary![0].average)?.doubleValue

                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
            }
            else {
                
                self.showCustomPop(popMessage: (self.responseObj?.message!)!)
                
                //            self.showAlert(title: "blink", message: (self.categoriesList?.message)!, controller: self)
            }
        }) { (error) in
            
            JSSAlertView().danger(self, title: KMessageTitle , text: error.description)
            
        }
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    func showCustomPop(popMessage : String) {
        let customIcon = UIImage(named: "lightbulb")
        let alertview = JSSAlertView().show(self,
                                            title: "MobiNP",
                                            text: popMessage,
                                            buttonText: "Ok",
                                            color: UIColorFromHex(0xD48FE, alpha: 1),
                                            iconImage: customIcon)
        alertview.addAction(self.closeCallback)
        alertview.setTitleFont("Montserrat-Bold")
        alertview.setTextFont("Montserrat")
        alertview.setButtonFont("Montserrat-Light")
        alertview.setTextTheme(.light)
    }
    
    func closeCallback() {
        
        
//        certifcateResponse?.certificateList?.append((addNewCertificate?.uploadCertificate)!)
//
//        tblView.reloadData()
//        print("Close callback called")
    }
   
}

extension MPClientSeeNotaryProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var cell: NotaryProfileCell? = tableView.dequeueReusableCell(withIdentifier: "Certificate") as! NotaryProfileCell?
            if cell == nil {
                cell = NotaryProfileCell(style: .default, reuseIdentifier: "Certificate")
            }
            cell?.collectionViewCell.reloadData()
            cell?.certificateList = responseObj?.notaryProfile?.userProfile?.notaryCertificates
            return cell!
            
        } else  {
            var cell: NotaryProfileCell? = tableView.dequeueReusableCell(withIdentifier: "Reviews") as! NotaryProfileCell?
            if cell == nil {
                cell = NotaryProfileCell(style: .default, reuseIdentifier: "Reviews")
            }
            
            cell?.lblServiceTitle.text = self.responseObj?.notaryProfile?.userProfile?.reviewList![indexPath.row].comment
            cell?.lblName.text = self.responseObj?.notaryProfile?.userProfile?.reviewList![indexPath.row].notaryReview?.name
            cell?.lblDate.text = self.responseObj?.notaryProfile?.userProfile?.reviewList![indexPath.row].created_at
            cell?.viewOfReview.rating = Double((self.responseObj?.notaryProfile?.userProfile?.reviewList![indexPath.row].rating)!)
            
            
            
            return cell!
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else  {
            return (self.responseObj?.notaryProfile?.userProfile?.reviewList?.count)!
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section ==  0 {
            return 142.0
        } else {
            return 90.0
        }
    }
    
    
    
}
