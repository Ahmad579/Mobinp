//
//  MPLoginVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPLoginVC: UIViewController {
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!

    @IBOutlet weak var btnSignIn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
//        txtEmail.text = "ahmadyar@ibexglobal.com"
//        txtPassword.text = "123456789"
        setUpUI()
    }
    
    func setUpUI() {
        btnSignIn.layer.shadowOpacity = 0.5
        btnSignIn.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnSignIn.layer.shadowRadius = 5.0
        btnSignIn.layer.shadowColor = UIColor.blue.cgColor
        UtilityHelper.setViewBorder(txtEmail, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtPassword, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        txtEmail.setLeftPaddingPoints(10)
        txtPassword.setLeftPaddingPoints(10)
    }

    @IBAction func btnForgotPassword(_ sender: UIButton) {
       let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPForgotPassVC") as? MPForgotPassVC
        self.navigationController?.pushViewController(vc!, animated: true)
 
    }
    
    @IBAction func btnCross_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnSign_Pressed(_ sender: UIButton) {
        if isViewPassedSignValidation()
        {
            
            var deviceToken =  UserDefaults.standard.value(forKey: "device_token") as? String
            
            if deviceToken == nil {
                deviceToken = "-1"
            }
            let loginParam =  [ "email"         : txtEmail.text!,
                               "password"       : txtPassword.text!,
                               "device_type"    : "ios" ,
                               "device_token"   : deviceToken!
                               
                ] as [String : Any]
       
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: LOGIN, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
                let responseObj = response as! UserResponse
            
                if responseObj.success == true {
                  localUserData = responseObj.data
                    UserDefaults.standard.set(self.txtEmail.text! , forKey: "email")
                    UserDefaults.standard.set(responseObj.data?.id , forKey: "id")
                    UserDefaults.standard.set(self.txtPassword.text! , forKey: "password")
                    
                    UserDefaults.standard.set(localUserData.apiToken , forKey: "user_token")

                    if localUserData.type == "Client" {
                        WAShareHelper.goToHomeController(vcIdentifier: "MPSelectService", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "MPSideMenuVC")

                    } else  {
                        WAShareHelper.goToHomeController(vcIdentifier: "MPBookingNotarifyVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "MPSideMenuNotaryVC")

                    }
                }else {
                    
                    JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)

                }
                
            }, fail: { (error) in
                JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
            }, showHUD: true)
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isViewPassedSignValidation() -> Bool
    {
        
        var validInput = true
        if self.txtEmail.text!.count < kUserNameRequiredLength {
            validInput = false
            self.txtEmail.becomeFirstResponder()

            self.showCustomPop(popMessage: kValidationMessageMissingInput ,imageName: "lightbulb")
        }
            
        else  if !WAShareHelper.isValidEmail(email: txtEmail.text!) {
            validInput = false
            
            self.txtEmail.becomeFirstResponder()

            self.showCustomPop(popMessage: kValidationEmailInvalidInput , imageName: "lightbulb")
            
        }
            
            
        else if   self.txtPassword.text!.count ==  0 {
            validInput = false
            
            self.showCustomPop(popMessage: KValidationPassword , imageName: "lightbulb")
        }
        else if   self.txtPassword.text!.count < kPasswordRequiredLength {
            validInput = false
            self.txtPassword.becomeFirstResponder()
            self.showCustomPop(popMessage: KValidationPassword , imageName: "lightbulb")
        }
        return validInput
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


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}


