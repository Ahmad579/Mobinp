//
//  MPChanegPassProfileVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPChanegPassProfileVC: UIViewController {
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet var txtExistingPass: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtConfirmedPass: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()

        // Do any additional setup after loading the view.
    }

    
//
    func setUPUI(){
        btnSave.layer.shadowOpacity = 0.5
        btnSave.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnSave.layer.shadowRadius = 5.0
        btnSave.layer.shadowColor = UIColor.blue.cgColor
        
        
        UtilityHelper.setViewBorder(txtExistingPass, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtPassword, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtConfirmedPass, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        
        txtExistingPass.setLeftPaddingPoints(10)
        txtPassword.setLeftPaddingPoints(10)
        txtConfirmedPass.setLeftPaddingPoints(10)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func btnChangePass_Pressed(_ sender: UIButton) {
        
            let loginParam = [ "api_token"               : localUserData.apiToken!,
                               "password"                : txtPassword.text!,
                               "password_confirmation"   : txtConfirmedPass.text! ,
                               "old_password"            : txtExistingPass.text!
                
                ] as [String : Any]
            
            WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: CHANGE_PASSPRofile, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
                let responseObj = response as! UserResponse
                
                if responseObj.success == true {
                    self.showCustomPop(popMessage: responseObj.message! , imageName: "lightbulb")
                }else {
                    
                    JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)
                    
                }
                
            }, fail: { (error) in
                JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
            }, showHUD: true)
            
        
    }

    
    func showCustomPop(popMessage : String , imageName : String) {
        let customIcon = UIImage(named: imageName)
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
