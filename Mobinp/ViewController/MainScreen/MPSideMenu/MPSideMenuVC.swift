//
//  MPSideMenuVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit

class MPSideMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnProfile_Pressed(_ sender: UIButton) {
        
        WAShareHelper.goToHomeController(vcIdentifier: "MPClientProfileVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuVC")
        
    }
    
    @IBAction func btnJob_Pressed(_ sender: UIButton) {
        
        WAShareHelper.goToHomeController(vcIdentifier: "MPJobPendOrCompleteVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuVC")
        
    }
    
    @IBAction func btnShare_Pressed(_ sender: UIButton) {
        
        WAShareHelper.goToHomeController(vcIdentifier: "MPShareVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuVC")
        
    }
 
    @IBAction func btnAboutUS_Pressed(_ sender: UIButton) {
        
        WAShareHelper.goToHomeController(vcIdentifier: "NPAboutUSVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuVC")
        
    }
    
    
    @IBAction func btnContantUS_Pressed(_ sender: UIButton) {
        
        
        WAShareHelper.goToHomeController(vcIdentifier: "MPContactVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuVC")
        
    }
    
    @IBAction func btnHome_Pressed(_ sender: UIButton) {

        WAShareHelper.goToHomeController(vcIdentifier: "MPSelectService", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuVC")

    }
    
    @IBAction func btnLogout_Pressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        UserDefaults.standard.set(nil  , forKey : "id")
        UserDefaults.standard.set(nil  , forKey : "user_token")
        UserDefaults.standard.set(nil  , forKey : "password")
        UserDefaults.standard.set(nil  , forKey : "email")
        localUserData = nil
        UIApplication.shared.keyWindow?.rootViewController = vc

//        WAShareHelper.goToHomeController(vcIdentifier: "MPSelectService", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuVC")
        
    }
    
    

}
