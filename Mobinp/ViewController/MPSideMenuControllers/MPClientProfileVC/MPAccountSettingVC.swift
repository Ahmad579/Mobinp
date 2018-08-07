//
//  MPAccountSettingVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPAccountSettingVC: UIViewController {
    @IBOutlet weak var btnSave: UIButton!

    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtMobileNum: UITextField!
    @IBOutlet var txtAddress: UITextField!
    @IBOutlet var txtZipCode: UITextField!
    var responseObj: UserResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUPUI()

        // Do any additional setup after loading the view.
    }
    
    func setUPUI(){
        btnSave.layer.shadowOpacity = 0.5
        btnSave.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnSave.layer.shadowRadius = 5.0
        btnSave.layer.shadowColor = UIColor.blue.cgColor
        
        txtEmail.text = localUserData.email
        txtName.text = localUserData.username
        txtMobileNum.text = localUserData.phone_no
        txtAddress.text = localUserData.address
        txtZipCode.text = localUserData.zipCode
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSubmit_Pressed(_ sender: UIButton) {
        //UPDATE_PROFILE_INFO
        
        
        let serviceParm =  [ "api_token"               : localUserData.apiToken!,
                             "name"                    : txtName.text!,
                             "email"                   : txtEmail.text! ,
                             "phone_no"                : txtMobileNum.text! ,
                             "address"                 : DEVICE_ADDRESS,
                             "zip_code"                : txtZipCode.text! ,
                             "is_available"            : "\(1)"
                             
            ] as [String : Any]
        
        
        WebServiceManager.post(params:serviceParm as Dictionary<String, AnyObject> , serviceName: UPDATE_PROFILE_INFO , serviceType: "Profile Notary", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            
            if self.self.responseObj?.success == true {
                localUserData = self.responseObj?.data
                self.showCustomPop(popMessage: (self.responseObj?.message!)!)
             }else {
                JSSAlertView().danger(self, title: KMessageTitle , text: self.responseObj?.message!)
            }
            
        }, fail: { (error) in
            JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
        }, showHUD: true)
        
        
    
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
        print("Close callback called")
    }

}
