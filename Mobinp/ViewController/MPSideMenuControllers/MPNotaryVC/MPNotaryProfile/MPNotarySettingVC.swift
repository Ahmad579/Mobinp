//
//  MPNotarySettingVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit

class MPNotarySettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func btnNotification(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPNotificationSetVC") as? MPNotificationSetVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    @IBAction func btnAccountSettin_Pressed(_ sender: UIButton) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPAccountSettingVC") as? MPAccountSettingVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func btnPersonSetting_Pressed(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPPersonalSettingVC") as? MPPersonalSettingVC
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    @IBAction func btnChanegPassword_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPChanegPassProfileVC") as? MPChanegPassProfileVC
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    @IBAction func btnAddLanguage_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPAddLuanguageVC") as? MPAddLuanguageVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }

    @IBAction func btnLogout_Pressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        UserDefaults.standard.set(nil  , forKey : "id")
        UserDefaults.standard.set(nil  , forKey : "user_token")
        UserDefaults.standard.set(nil  , forKey : "password")
        UserDefaults.standard.set(nil  , forKey : "email")
        localUserData = nil
        UIApplication.shared.keyWindow?.rootViewController = vc
        
    }
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

  

}
