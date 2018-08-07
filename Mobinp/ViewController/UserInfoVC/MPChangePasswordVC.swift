//
//  MPChangePasswordVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPChangePasswordVC: UIViewController {

    @IBOutlet var txtPass: UITextField!
    @IBOutlet var txtConfimPass: UITextField!
    var codePass : String?

    @IBOutlet weak var btnChange: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
       
    }
    
    func setUpUI(){
        btnChange.layer.shadowOpacity = 0.5
        btnChange.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnChange.layer.shadowRadius = 5.0
        btnChange.layer.shadowColor = UIColor.blue.cgColor
        UtilityHelper.setViewBorder(txtPass, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtConfimPass, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        txtPass.setLeftPaddingPoints(10)
        txtConfimPass.setLeftPaddingPoints(10)
    }
    
    @IBAction func btnCross_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnChangeBtn_Pressed(_ sender: UIButton) {
        
        let loginParam = [ "api_token"             :  localUserData.apiToken!,
                           "password"              :  txtPass.text! ,
                           "password_confirmation" :  txtConfimPass.text!
            ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: RESET_PASSWORD, serviceType: "Code Send", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.success == true {
                
                self.showCustomPop(popMessage: responseObj.message! , imageName: "lightbulb")

            }else {
                JSSAlertView().danger(self, title: KMessageTitle, text: responseObj.message!)

//                self .showAlert(title: "Mobinp", message: responseObj.message! , controller: self)
            }
            
            
        }, fail: { (error) in
            JSSAlertView().danger(self, title: KMessageTitle , text: error.description)

//            self.showAlert(title: "Mobinp", message: error.description , controller: self)
        }, showHUD: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func showCustomPop(popMessage : String , imageName : String) {
        let customIcon = UIImage(named: imageName)
        let alertview = JSSAlertView().show(self,
                                            title: KMessageTitle ,
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
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)

//        print("Close callback called")
    }


}
