//
//  MPContactVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 03/07/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPContactVC: UIViewController , UITextViewDelegate {
  
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPhoneNo: UITextField!
    @IBOutlet var txtDetail: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSubmit.layer.shadowOpacity = 0.5
        btnSubmit.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnSubmit.layer.shadowRadius = 5.0
        btnSubmit.layer.shadowColor = UIColor.blue.cgColor
        txtName.setLeftPaddingPoints(10)
        txtEmail.setLeftPaddingPoints(10)
        txtPhoneNo.setLeftPaddingPoints(10)
        
        txtDetail.delegate = self
        txtDetail.setPlaceholder()

        UtilityHelper.setViewBorder(txtName, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtEmail, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))

        UtilityHelper.setViewBorder(txtPhoneNo, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtDetail, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))


        // Do any additional setup after loading the view.
    }

    func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)

        
    }
    
    @IBAction func btnSubmit_Pressed(_ sender: UIButton) {
        
        let loginParam =  [ "api_token"           : localUserData.apiToken!,
                            "name"                : txtName.text!,
                            "email"               : txtEmail.text! ,
                            "phone"               : txtPhoneNo.text! ,
                            "message"             : txtDetail.text!
            ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: CONTACTUS, serviceType: "Add Luanguage", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            
            if responseObj.success == true {
                self.showCustomPop(popMessage: responseObj.message!, imageName: "lightbulb")
            }
            else {
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

extension UITextView{
    
    func setPlaceholder() {
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Detail..."
        placeholderLabel.font = UIFont.boldSystemFont(ofSize: (self.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 222
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0)
        placeholderLabel.isHidden = !self.text.isEmpty
        
        self.addSubview(placeholderLabel)
    }
    
    func checkPlaceholder() {
        let placeholderLabel = self.viewWithTag(222) as! UILabel
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
}
