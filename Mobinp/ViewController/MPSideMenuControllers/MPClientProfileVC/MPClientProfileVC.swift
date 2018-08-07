//
//  MPClientProfileVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPClientProfileVC: UIViewController {

    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var imgeOfUser: UIImageView!
    let photoPicker = PhotoPicker()
    var userInfo: UserResponse?

    var cover_image: UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUserName.text = localUserData.username
//        let cgFloat: CGFloat = self.imgeOfUser.frame.size.width/2.0
//        let someFloat = Float(cgFloat)
        
        let cgFloat: CGFloat = self.imgeOfUser.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        WAShareHelper.setViewCornerRadius(imgeOfUser , radius: CGFloat(someFloat))
        let imageOfUser = localUserData.avatar_url?.replacingOccurrences(of: " ", with: "%20")
        WAShareHelper.loadImage(urlstring:imageOfUser! , imageView: imgeOfUser!, placeHolder: "image_placeholder")
        
        
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(MPClientProfileVC.imageTappedForDp(img:)))
        imgeOfUser.isUserInteractionEnabled = true
        imgeOfUser.addGestureRecognizer(tapGestureRecognizerforDp)

        // Do any additional setup after loading the view.
    }

    
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            
            self.imgeOfUser.image = orignal
            let cgFloat: CGFloat = self.imgeOfUser.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self.imgeOfUser, radius: CGFloat(someFloat))
            self.cover_image = orignal
            
            let params =      ["api_token"                    :  localUserData.apiToken!  ,
                              ] as [String : Any]
            
            WebServiceManager.multiPartImage(params: params  as Dictionary<String, AnyObject> , serviceName: UPDATE_PROFILE_PIC, imageParam:"profile_image", serviceType: "Update Avatar", profileImage: self.imgeOfUser.image, cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
                let responseObj = response as! UserResponse

                if responseObj.success == true {
//                    self.userInfo = (response as? UserResponse)!
                    self.showCustomPop(popMessage: (responseObj.message!))
                }
                else
                {
                    JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)
                    
                }
                
            }) { (error) in
                JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
                
                
            }
            
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
    }
    
    @IBAction func btnAccountSetting_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPAccountSettingVC") as? MPAccountSettingVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnPaymentSetting_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPSelectPayment") as? MPSelectPayment
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnChangePassword(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPChanegPassProfileVC") as? MPChanegPassProfileVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnLogOut_Pressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        UserDefaults.standard.set(nil  , forKey : "id")
        UserDefaults.standard.set(nil  , forKey : "user_token")
        UserDefaults.standard.set(nil  , forKey : "password")
        UserDefaults.standard.set(nil  , forKey : "email")
        localUserData = nil
        UIApplication.shared.keyWindow?.rootViewController = vc
    
    
    }
    
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
