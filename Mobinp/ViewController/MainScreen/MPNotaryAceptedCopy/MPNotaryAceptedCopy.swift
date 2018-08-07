//
//  MPNotaryAceptedCopy.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPNotaryAceptedCopy: UIViewController {
   
    @IBOutlet var      profilePic : UIImageView!
    @IBOutlet weak var btnAccept  : UIButton!
    @IBOutlet weak var btnReject  : UIButton!
    var requestId : Int?

    @IBOutlet var lblCompanyName: UILabel!
    @IBOutlet var lblBuisnessEmail        : UILabel!
    @IBOutlet var lblMeetMeAt           : UILabel!
    @IBOutlet var lblServiceType        : UILabel!
    @IBOutlet var lblDateAndtime: UILabel!
    @IBOutlet var lblUserName: UILabel!

    var responseObj: UserResponse?
    var notaryAcceptedOffer : UserResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()
        
        
        lblUserName.text = localUserData.username
        
        let cgFloat: CGFloat = self.profilePic.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        WAShareHelper.setViewCornerRadius(profilePic , radius: CGFloat(someFloat))
        let imageOfUser = localUserData.avatar_url?.replacingOccurrences(of: " ", with: "%20")
        WAShareHelper.loadImage(urlstring:imageOfUser! , imageView: profilePic!, placeHolder: "image_placeholder")

        getUserData()

        // Do any additional setup after loading the view.
    }
    
    func setUPUI(){
        btnAccept.layer.shadowOpacity = 0.5
        btnAccept.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnAccept.layer.shadowRadius = 5.0
        btnAccept.layer.shadowColor = UIColor.blue.cgColor
        
        btnReject.layer.shadowOpacity = 0.5
        btnReject.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnReject.layer.shadowRadius = 5.0
        btnReject.layer.shadowColor = UIColor.blue.cgColor
        
        
        let cgFloat: CGFloat = self.profilePic.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        WAShareHelper.setViewCornerRadius(self.profilePic, radius: CGFloat(someFloat))
    }
    
    func getUserData() {
        
        let serviceURL =  CLIENT_REQUESTFORNotaryInfo + "\(requestId!)" + "?api_token=\(localUserData.apiToken!)"
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Service List", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            if  self.responseObj?.success == true {

                self.lblCompanyName.text = self.responseObj?.requestClientData?.company_name
                self.lblBuisnessEmail.text = self.responseObj?.requestClientData?.business_email
                self.lblMeetMeAt.text = self.responseObj?.requestClientData?.company_name
                self.lblServiceType.text = self.responseObj?.requestClientData?.payment_type
                self.lblDateAndtime.text = self.responseObj?.requestClientData?.appointment

                
                
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPBookingNotarifyVC") as? MPBookingNotarifyVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnBack_Pressed(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
        }

    
    @IBAction func btnAcceptNotaifir_Pressed(_ sender: UIButton) {
        
        let cliendId = self.responseObj?.requestClientData?.client_id
        
        let serviceParm =  [ "api_token"               : localUserData.apiToken!,
                             "client_request_id"       :  "\(cliendId!)"  ,
                             "offer_details"           : "TechEase Solutions"
            ] as [String : Any]


        WebServiceManager.post(params:serviceParm as Dictionary<String, AnyObject> , serviceName: NOTARYSENDOFFER, serviceType: "Profile Notary", modelType: UserResponse.self, success: { (response) in
            self.notaryAcceptedOffer = (response as! UserResponse)
//
            if self.notaryAcceptedOffer?.success == true {
         
                self.showCustomPop(popMessage: (self.notaryAcceptedOffer?.message)!)
            }else {

                JSSAlertView().danger(self, title: KMessageTitle , text: self.notaryAcceptedOffer?.message!)

            }

        }, fail: { (error) in
            JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
        }, showHUD: true)
    
//
       
        
    }

}
