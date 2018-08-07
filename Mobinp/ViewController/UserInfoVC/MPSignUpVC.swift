//
//  MPSignUpVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPSignUpVC: UIViewController {

    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtAddress: UITextField!
    @IBOutlet var txtZipCode: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtPhoneNumber: UITextField!
    @IBOutlet var profilePic: UIImageView!
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?
    var isClientSelect : Bool?
    var isNotarySelect : Bool?
    var userInfo: UserResponse?
    var isClientOrNotary : String?

    @IBOutlet weak var btnClientSelect: UIButton!
    @IBOutlet weak var btnNotarySelect: UIButton!

    

    @IBOutlet weak var btnSignUp: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpUI()
        
        btnClientSelect.isSelected = true
        isClientOrNotary = "Client"
        // Do any additional setup after loading the view.
    }
    
    
    func setUpUI(){
        isClientSelect = false
        isNotarySelect = false
        btnClientSelect.isSelected = false
        btnNotarySelect.isSelected = false
        
        btnSignUp.layer.shadowOpacity = 0.5
        btnSignUp.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnSignUp.layer.shadowRadius = 5.0
        btnSignUp.layer.shadowColor = UIColor.blue.cgColor
        
        
        UtilityHelper.setViewBorder(txtName, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtEmail, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtAddress, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtZipCode, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtPassword, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtPhoneNumber, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        
        txtName.setLeftPaddingPoints(10)
        txtEmail.setLeftPaddingPoints(10)
        txtPassword.setLeftPaddingPoints(10)
        txtZipCode.setLeftPaddingPoints(10)
        txtAddress.setLeftPaddingPoints(10)
        txtPhoneNumber.setLeftPaddingPoints(10)
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(MPSignUpVC.imageTappedForDp(img:)))
        profilePic.isUserInteractionEnabled = true
        profilePic.addGestureRecognizer(tapGestureRecognizerforDp)
    }
    @IBAction func btnClientSelect(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isClientOrNotary = "Client"

        isClientSelect = true
        isNotarySelect = false
        btnClientSelect.isSelected = true
        btnNotarySelect.isSelected = false
    }
    @IBAction func btnNotary_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isClientOrNotary = "Notary"

        isNotarySelect = true
        isClientSelect = false
        btnClientSelect.isSelected = false
        btnNotarySelect.isSelected = true
  }
    
    
    @IBAction func btnSignUp_Pressed(_ sender: UIButton) {
        
        let params =      ["email"                    :  txtEmail.text!  ,
                           "password"                 :  txtPassword.text! ,
                           "name"                     :  txtName.text! ,
                           "password_confirmation"    :  txtPassword.text!,
                           "phone_no"                 :  txtPhoneNumber.text! ,
                           "type"                     :  isClientOrNotary! ,
                           "address"                  :  txtAddress.text! ,
                           "zip_code"                 :  txtZipCode.text!    ,
                           "device_type"              :  "ios" ,
                           "device_token"             :  "aewflkjawfwoifjwfdoijasdfoidsa" ,
                           ] as [String : Any]
        
        WebServiceManager.multiPartImage(params: params as Dictionary<String, AnyObject> , serviceName: SIGNUP, imageParam:"profile_image", serviceType: "Sign Up", profileImage: profilePic.image, cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
           
            
            let responseObj = response as! UserResponse

            
            if responseObj.success == true {

                localUserData = responseObj.data
                UserDefaults.standard.set(self.txtEmail.text! , forKey: "email")
                UserDefaults.standard.set(localUserData.id , forKey: "id")
                UserDefaults.standard.set(self.txtPassword.text! , forKey: "password")
                UserDefaults.standard.set(localUserData.apiToken , forKey: "user_token")

                if localUserData.type == "Client" {
                    self.showCustomPop(popMessage: (responseObj.message!))

                    
                } else  {
                  
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPNotaryPaymentVC") as? MPNotaryPaymentVC
                    self.navigationController?.pushViewController(vc!, animated: true)
                    
                }
            }
            else
            {

                JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)

            }

        }) { (error) in
            JSSAlertView().danger(self, title: KMessageTitle, text: error.description)

            
        }
        
        

//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPNotaryPaymentVC") as? MPNotaryPaymentVC
//        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    
    
    @IBAction func btnCross_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            
            self.profilePic.image = orignal
            let cgFloat: CGFloat = self.profilePic.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self.profilePic, radius: CGFloat(someFloat))
            self.cover_image = orignal
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
