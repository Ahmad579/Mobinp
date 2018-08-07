//
//  MPForgotPassVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView


class MPForgotPassVC: UIViewController {
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet weak var btnSendCode: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
       setUPUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setUPUI(){
        btnSendCode.layer.shadowOpacity = 0.5
        btnSendCode.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnSendCode.layer.shadowRadius = 5.0
        btnSendCode.layer.shadowColor = UIColor.blue.cgColor
        UtilityHelper.setViewBorder(txtEmail, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        txtEmail.setLeftPaddingPoints(10)
    }
    
    func isViewPassedForgotPassValidation() -> Bool
    {
        
        var validInput = true
        if self.txtEmail.text!.count < kUserNameRequiredLength {
            validInput = false
            self.txtEmail.becomeFirstResponder()

            self.showCustomPop(popMessage: kValidationMessageMissingInput , imageName: "lightbulb")

//            self.showAlertViewWithTitle(title: kEmptyString, message: kValidationMessageMissingInput, dismissCompletion: {
//                self.txtEmail.becomeFirstResponder()
//            })
        }
            
        else  if !WAShareHelper.isValidEmail(email: txtEmail.text!) {
            validInput = false
            self.txtEmail.becomeFirstResponder()

            self.showCustomPop(popMessage: kValidationEmailInvalidInput , imageName: "lightbulb")

//            self.showAlertViewWithTitle(title : kEmptyString, message: kValidationEmailInvalidInput, dismissCompletion: {
//                self.txtEmail.becomeFirstResponder()
//            })
            
        }
      
        return validInput
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCross_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSendCode_Pressed(_ sender: UIButton) {
        if isViewPassedForgotPassValidation()
        {
            
            let loginParam = [ "email"        : txtEmail.text!
                ] as [String : Any]
            
            WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: FORGOT_Password, serviceType: "Forgot", modelType: UserResponse.self, success: { (response) in
                let responseObj = response as! UserResponse
                if responseObj.success == true {
                    
                 let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyCodeVC") as? VerifyCodeVC
                    vc?.emailPass = self.txtEmail.text!
                self.navigationController?.pushViewController(vc!, animated: true)
                }else {
                    JSSAlertView().danger(self, title: KMessageTitle, text: responseObj.message!)
                }
                
                
            }, fail: { (error) in
                JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
            }, showHUD: true)
            
        }
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
