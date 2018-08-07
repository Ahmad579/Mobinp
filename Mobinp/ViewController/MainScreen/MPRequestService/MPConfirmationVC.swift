//
//  MPConfirmationVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/05/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPConfirmationVC: UIViewController {
    var selectDate : String?
    var selectTime : String?
    var selectService : Int?
    var notaryId: Int?
    var company_name : String?
    var business_email : String?
    var isDefaultOrCurrent : String?
    var on_going           : String?
    var document_name : String?
    var paymentType : String?
    var selectServiceValue : String?
    var cover_image: UIImage?
    var profilePic: UIImage?
    var selectNotaryList: UserInformation?

    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblBuisnessEmail: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblServiceType: UILabel!
    @IBOutlet weak var lblJob: UILabel!
    @IBOutlet weak var lblPaymentType: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblServiceCost: UILabel!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    
    @IBOutlet weak var lblTotalCost: UILabel!
    
    @IBOutlet weak var btnConfirm: UIButton!
    var isRequestSuccess : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnConfirm.layer.shadowOpacity = 0.5
        btnConfirm.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnConfirm.layer.shadowRadius = 5.0
        btnConfirm.layer.shadowColor = UIColor.blue.cgColor
        lblCompanyName.text = company_name
        lblBuisnessEmail.text = business_email
        lblLocation.text = DEVICE_ADDRESS
        lblServiceType.text = selectServiceValue
        lblJob.text = "Nothing"
        lblPaymentType.text = paymentType
        lblDate.text = selectDate
        lblTime.text = selectTime
        isRequestSuccess = false
        
        let serviceFee = selectNotaryList?.notaryProfile?.suggested_fees_for_services!
        lblServiceCost.text = "\(serviceFee!)"
        let deliveryCharges = selectNotaryList?.notaryProfile?.delivery_charges!
        lblDeliveryCost.text = "\(deliveryCharges!)"
        lblTax.text = "0"
        let totalCost:Int = serviceFee! + deliveryCharges!
        lblTotalCost.text = "\(totalCost)"
        
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnConfirmRequest(_ sender: UIButton) {
        confirmRequest()
    }
    func confirmRequest(){
        let params =      ["api_token"                :   localUserData.apiToken!  ,
                           "service_id"               :   "\(selectService!)" ,
                            "notary_id"                :   "\(notaryId!)",
                            "company_name"             :   company_name!,
                            "business_email"           :   business_email! ,
                            "location"                 :   isDefaultOrCurrent! ,
                            "address"                  :   DEVICE_ADDRESS ,
                            "appointment_date"         :   selectDate!  ,
                            "appointment_time"         :   selectTime! ,
                            "payment_type"             :   "Full" ,
                            "on_going"                 :   on_going! ,
                            "document_name"             :  document_name!
            ] as [String : Any]
        
        WebServiceManager.multiPartImage(params: params as Dictionary<String, AnyObject> , serviceName: CLIENT_REQUEST, imageParam:"document_image", serviceType: "Client Request", profileImage: profilePic , cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
            
            if let responseObj = response as? UserResponse {
                if responseObj.success == true {
                    self.isRequestSuccess = true
                    self.showCustomPop(popMessage: responseObj.message!)
                 }
                else
                {
                    JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)
                }
            } else {
                JSSAlertView().danger(self, title: KMessageTitle , text: "Some Error in Api")
                
            }
        }) { (error) in
            JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
            
            
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
        if self.isRequestSuccess == true {
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        
    }
}
