//
//  MPSideMenuNotaryVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit

class MPSideMenuNotaryVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func btnService_Pressed(_ sender: UIButton) {
        
        WAShareHelper.goToHomeController(vcIdentifier: "MPNotatyServiceVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuNotaryVC")
        
    }
   
    @IBAction func btnReport_Pressed(_ sender: UIButton) {
        
        WAShareHelper.goToHomeController(vcIdentifier: "MPReportVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuNotaryVC")
        
    }
    
    @IBAction func btnHome_Pressed(_ sender: UIButton) {
        
        WAShareHelper.goToHomeController(vcIdentifier: "MPBookingNotarifyVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuNotaryVC")
        
    }
    @IBAction func btnJobs_Pressed(_ sender: UIButton) {
        
        WAShareHelper.goToHomeController(vcIdentifier: "MPJobPendOrCompleteVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuNotaryVC")
        
    }
    
    @IBAction func btnShare_Pressed(_ sender: UIButton) {
        
        WAShareHelper.goToHomeController(vcIdentifier: "MPShareVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuNotaryVC")

    }
    
    @IBAction func btnProfile_Pressed(_ sender: UIButton) {
        
        WAShareHelper.goToHomeController(vcIdentifier: "MPNotaryProfileVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuNotaryVC")
        
    }
    
    @IBAction func btnAbout_Pressed(_ sender: UIButton) {
        WAShareHelper.goToHomeController(vcIdentifier: "NPAboutUSVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "MPSideMenuNotaryVC")
        
    }

}
