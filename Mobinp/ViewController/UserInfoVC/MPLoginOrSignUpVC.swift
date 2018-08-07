//
//  MPLoginOrSignUpVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit

class MPLoginOrSignUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignIn_Pressed(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPLoginVC") as? MPLoginVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnSignUp_Pressed(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPSignUpVC") as? MPSignUpVC
        self.navigationController?.pushViewController(vc!, animated: true)
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
