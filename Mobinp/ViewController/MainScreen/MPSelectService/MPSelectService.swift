//
//  MPSelectService.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit

class MPSelectService: UIViewController {
    @IBOutlet var selectServieType: UIImageView!
    @IBOutlet var selectPaymentType: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(MPSelectService.selectServiceType(img:)))
        selectServieType.isUserInteractionEnabled = true
        selectServieType.addGestureRecognizer(tapGestureRecognizerforDp)
        
        
        let tapGestureRecognizerforPayment = UITapGestureRecognizer(target:self, action:#selector(MPSelectService.selectPaymentService(img:)))
        selectPaymentType.isUserInteractionEnabled = true
        selectPaymentType.addGestureRecognizer(tapGestureRecognizerforPayment)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MPSelectService.goToJobCompletedScreen(_:)), name: NSNotification.Name(rawValue: "uploadVerifyDocument"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MPSelectService.profileOfAcceptedUser(_:)), name: NSNotification.Name(rawValue: "ClientReceiveRequest"), object: nil)

      

        // Do any additional setup after loading the view.
    }
    
    @objc func selectServiceType(img: AnyObject)
    {
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPJobCompleteVC")  as? MPJobCompleteVC
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPSelectNotaryVC") as? MPSelectNotaryVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @objc func selectPaymentService(img: AnyObject) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPPaymentVC") as? MPPaymentVC
        self.navigationController?.pushViewController(vc!, animated: true)

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func goToJobCompletedScreen(_ notification: NSNotification) {
        let userData = notification.userInfo
        let selectRequestId = userData![AnyHashable("request_id")]!
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPJobCompleteVC")  as? MPJobCompleteVC
        vc?.requestId = selectRequestId as? Int
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    

    @objc func profileOfAcceptedUser(_ notification: NSNotification) {
        let userData = notification.userInfo
        let selectDay = userData![AnyHashable("request_id")]!
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPClientReciveNotaryInfoVC") as? MPClientReciveNotaryInfoVC
        vc?.requestId = selectDay as? Int
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
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
