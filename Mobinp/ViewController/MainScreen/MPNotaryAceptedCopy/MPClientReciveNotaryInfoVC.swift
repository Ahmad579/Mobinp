//
//  MPClientReciveNotaryInfoVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 11/04/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView


class MPClientReciveNotaryInfoVC: UIViewController {
    
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var imgeOfUser: UIImageView!
    var requestId : Int?
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?

    var responseObj: UserResponse?
    
    @IBOutlet var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getNotaryProfile()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getNotaryProfile() {
        
         let serviceURL =  CLIENT_REQUESTFORNotaryInfo + "\(requestId!)" + "?api_token=\(localUserData.apiToken!)"
        
//        let serviceURL = "http://mobinp.com/api/v1/client/request/3?api_token=rpwyf7uks3y1nmkVTeh8wak0dFkNRi5F1Kv3kzYkQKJLWID40zZ5ysYz2IDa"
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Get Notary Profile", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            
            
            if  self.responseObj?.success == true {
                
                self.lblUserName.text = self.responseObj?.requestClientData?.clientGetNotaryObject?.username
                
                let cgFloat: CGFloat = self.imgeOfUser.frame.size.width/2.0
                let someFloat = Float(cgFloat)
                WAShareHelper.setViewCornerRadius(self.imgeOfUser , radius: CGFloat(someFloat))
                let imageOfUser = self.responseObj?.requestClientData?.clientGetNotaryObject?.avatar_url?.replacingOccurrences(of: " ", with: "%20")
                WAShareHelper.loadImage(urlstring:imageOfUser! , imageView: self.imgeOfUser!, placeHolder: "image_placeholder")
                
                
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
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}



extension MPClientReciveNotaryInfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var cell: ClientReciveNotifyCell? = tableView.dequeueReusableCell(withIdentifier: "Certificate") as! ClientReciveNotifyCell?
            if cell == nil {
                cell = ClientReciveNotifyCell(style: .default, reuseIdentifier: "Certificate")
            }
            cell?.collectionViewCell.reloadData()
            cell?.certificateList = responseObj?.requestClientData?.clientGetNotaryObject?.notaryCertificates
            return cell!
            
        } else  {
            var cell: ClientReciveNotifyCell? = tableView.dequeueReusableCell(withIdentifier: "ExtraInfo") as! ClientReciveNotifyCell?
            if cell == nil {
                cell = ClientReciveNotifyCell(style: .default, reuseIdentifier: "ExtraInfo")
            }
            
//            let procesCost = self.responseObj?.requestClientData?.clientGetNotaryObject?.notaryProfile?.suggested_fees_for_services
            cell?.lblLuanguage.text = "English"
            cell?.lblComissionNum.text = self.responseObj?.requestClientData?.clientGetNotaryObject?.notaryProfile?.commission_no
            cell?.lblSigningAgent.text = self.responseObj?.requestClientData?.clientGetNotaryObject?.notaryProfile?.notary_qualifications
            cell?.delegate = self
            cell?.index = indexPath
            if let deliveryCharges = self.responseObj?.requestClientData?.clientGetNotaryObject?.notaryProfile?.delivery_charges {
                cell?.lblDeliveryCost.text = "\(deliveryCharges)"
            }
            
            if let procesCost = self.responseObj?.requestClientData?.clientGetNotaryObject?.notaryProfile?.suggested_fees_for_services {
                cell?.lblProcessingCost.text = "\(procesCost)"
            }
            
            
//            cell?.lblOtherCost.text = "\(deliveryCharges!)"
            
//            cell?.lblProcessingCost.text = "\(procesCost!)"
            cell?.lblYearOfExperience.text = "5 year"
            
            
            
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
            return 1
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section ==  0 {
            return 142.0
        } else {
            return 298.0
        }
    }
    
    
    
}

extension MPClientReciveNotaryInfoVC : AttachFile_Pressed {
   
    func selectFile(checkCell : ClientReciveNotifyCell , indexPath : IndexPath) {
        
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
           
            self.cover_image = orignal
            let clientID  = self.responseObj?.requestClientData?.client_id!
            let params =         ["api_token"                    :  localUserData.apiToken!  ,
                                  "client_request_id"            :  "\(clientID!)" ,
                                  "document_name"                :  "Check This File"
                ] as [String : Any]
            
            WebServiceManager.multiPartImage(params: params  as Dictionary<String, AnyObject> , serviceName: GETCLIENTRequestDocument, imageParam:"document_image", serviceType: "Update Avatar", profileImage: self.cover_image , cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
                let responseObj = response as! UserResponse
                
                if responseObj.success == true {
                    self.showCustomPop(popMessage: (responseObj.message!))
                }
                else
                {
                    JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)
                    
                }
                
            }) { (error) in
                JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
                
                
            }
            
            
        }

        
        
    }
}

