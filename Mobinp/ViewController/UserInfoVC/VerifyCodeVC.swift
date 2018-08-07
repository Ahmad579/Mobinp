//
//  VerifyCodeVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class VerifyCodeVC: UIViewController , UITextFieldDelegate {

    @IBOutlet var txtFieldFirst: UITextField!
    @IBOutlet var txtFieldSecond: UITextField!
    @IBOutlet var txtFieldThird: UITextField!
    @IBOutlet var txtFieldFourth : UITextField!
    @IBOutlet var txtFieldFifth: UITextField!
    @IBOutlet var txtFieldSixth: UITextField!

    @IBOutlet weak var btnVerify: UIButton!
    var emailPass : String?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUPUI()
//        txtEmail.setLeftPaddingPoints(10)

        // Do any additional setup after loading the view.
    }

    
    func setUPUI(){
        btnVerify.layer.shadowOpacity = 0.5
        btnVerify.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnVerify.layer.shadowRadius = 5.0
        btnVerify.layer.shadowColor = UIColor.blue.cgColor
        UtilityHelper.setViewBorder(txtFieldFirst, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtFieldSecond, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtFieldThird, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtFieldFourth, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtFieldFifth, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtFieldSixth, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))

    }
    
    @IBAction func btnCross_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func checkTF() {
        if (txtFieldFirst.text?.count == 1) {
            txtFieldSecond.becomeFirstResponder()
        }
        if (txtFieldSecond.text?.count == 1) {
            txtFieldThird.becomeFirstResponder()
        }
        if (txtFieldThird.text?.count == 1) {
            txtFieldFourth.becomeFirstResponder()
        }
        if (txtFieldFourth.text?.count == 1) {
            txtFieldFifth.becomeFirstResponder()
        }
        if (txtFieldFifth.text?.count == 1) {
            txtFieldSixth.becomeFirstResponder()
        }
        if (txtFieldSixth.text?.count == 1) {
            txtFieldSixth.resignFirstResponder()
        }
        
//        if (txtFieldFourth.text.length == 1) {
//            tfFouthTxt.resignFirstResponder()
//            if isUserInputValid() {
//                perform(#selector(self.callApiSendPhone), with: nil, afterDelay: 0.5)
//            }
//        }
    }

    
    @IBAction func btnVerify_Pressed(_ sender: UIButton) {
        
        var codeEnter = txtFieldFirst.text!
        codeEnter    += txtFieldSecond.text!
        codeEnter    += txtFieldThird.text!
        codeEnter    += txtFieldFourth.text!
        codeEnter    += txtFieldFifth.text!
        codeEnter    += txtFieldSixth.text!
        
        
        let loginParam = ["verification_code" : codeEnter ,
                          "email" : emailPass!
            ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: VERIFY_CODE, serviceType: "Code Send", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.success == true {
                
                localUserData = responseObj.data
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPChangePasswordVC") as? MPChangePasswordVC
                vc?.codePass = codeEnter ;
                self.navigationController?.pushViewController(vc!, animated: true)

                
                
            }else {
//                self .showAlert(title: "ADM", message: responseObj.message! , controller: self)
                JSSAlertView().danger(self, title: KMessageTitle, text: responseObj.message!)

            }
            
            
        }, fail: { (error) in
//            self.showAlert(title: "Where App", message: error.description , controller: self)
            JSSAlertView().danger(self, title: KMessageTitle, text: error.description)

        }, showHUD: true)
        
        
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        if textField == txtFieldFirst {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == txtFieldSecond {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == txtFieldThird {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == txtFieldFourth {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == txtFieldFifth {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == txtFieldSixth {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }


        return true
    }

}
