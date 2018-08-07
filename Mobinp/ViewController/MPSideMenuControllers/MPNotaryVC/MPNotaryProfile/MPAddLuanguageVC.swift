//
//  MPAddLuanguageVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 02/07/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPAddLuanguageVC: UIViewController {
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet var txtAddLuanguage: UITextField!
    var isPreferedLuanguage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSubmit.layer.shadowOpacity = 0.5
        btnSubmit.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnSubmit.layer.shadowRadius = 5.0
        btnSubmit.layer.shadowColor = UIColor.blue.cgColor
        txtAddLuanguage.setLeftPaddingPoints(10)
        
        UtilityHelper.setViewBorder(txtAddLuanguage, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))

        // Do any additional setup after loading the view.
    }

    @IBAction func btnPreferenceLuanguage(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            isPreferedLuanguage = 1
        } else  {
            isPreferedLuanguage = 0
        }
        
        
    }
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSubmit_Pressed(_ sender: UIButton) {
//
    
        let loginParam =  [ "api_token"           : localUserData.apiToken!,
                            "language_name"       : txtAddLuanguage.text!,
                            "prefered"            : "\(isPreferedLuanguage)" ,
                          ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: ADDLUANGUAGE, serviceType: "Add Luanguage", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            
            if responseObj.success == true {
                self.showCustomPop(popMessage: responseObj.message!, imageName: "lightbulb")
            }else {
                JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)
            }
            
        }, fail: { (error) in
            JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
        }, showHUD: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
