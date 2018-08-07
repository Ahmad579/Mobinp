//
//  MPPaymentSettingVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit

class MPPaymentSettingVC: UIViewController {
    @IBOutlet weak var btnSave: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()
        // Do any additional setup after loading the view.
    }
    func setUPUI(){
        btnSave.layer.shadowOpacity = 0.5
        btnSave.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnSave.layer.shadowRadius = 5.0
        btnSave.layer.shadowColor = UIColor.blue.cgColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
