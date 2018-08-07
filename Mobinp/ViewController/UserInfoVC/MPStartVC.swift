//
//  MPStartVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPStartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureSizeOfViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verifyAutoLogin()
    }
    
    func configureSizeOfViews(){
        NotificationCenter.default.addObserver(self, selector: #selector(MPStartVC.verifyAutoLogin), name: Notification.Name(rawValue: "Auto"), object: nil)
    }
    
    
    @objc func verifyAutoLogin() {
//        var phone = UserDefaults.standard.string(forKey: "phone")
        let pass = UserDefaults.standard.string(forKey: "password")
        
        let email = UserDefaults.standard.string(forKey: "email")
        var deviceToken =  UserDefaults.standard.value(forKey: "device_token") as? String
        let user_token = UserDefaults.standard.string(forKey: "user_token")
        
        
        if user_token != nil && (user_token?.count)! > 0 {
            if deviceToken == nil {
                deviceToken = ""
            }
            let loginParam = [ "email"         : email! ,
                               "password"      : pass! ,
                               "device_type"   : "ios" ,
                               "device_token"  : deviceToken!
                
                ] as [String : Any]
            WebServiceManager.post(params: loginParam as Dictionary<String, AnyObject>, serviceName: LOGIN, serviceType: "autologin", modelType: UserResponse.self, success: { (response) in
                let responseObj = response as! UserResponse
                
                if responseObj.success == true {
                    localUserData = responseObj.data
                 
                    if localUserData.type == "Client" {
                        WAShareHelper.goToHomeController(vcIdentifier: "MPSelectService", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "MPSideMenuVC")
                        
                    } else  {
                        WAShareHelper.goToHomeController(vcIdentifier: "MPBookingNotarifyVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "MPSideMenuNotaryVC")
                        
                    }

                    
//                    WAShareHelper.goToHomeController(vcIdentifier: "MPSelectService", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "MPSideMenuVC")
                }else {
                    
                    JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)
                }
            }, fail: { (error) in
                self.showAlert(title: "Error", message: error.localizedDescription, controller: self)
            }, showHUD: true)
        }
    }
    
    @IBAction func btnGetStarted_Pressed(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPLoginOrSignUpVC") as? MPLoginOrSignUpVC
        self.navigationController?.pushViewController(vc!, animated: true)
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
