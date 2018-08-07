//
//  MPFindingNotary.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MPFindingNotary: UIViewController , NVActivityIndicatorViewable {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)

        
        let size = CGSize(width: 60, height: 60)
        
        startAnimating(size, message: "Waiting For Notary to accept the Request", type: NVActivityIndicatorType(rawValue: 16))

        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "NotaryRequest") , object: nil, queue: nil, using: { notification in
            self.stopAnimating()

            let userData = notification.userInfo
            let selectDay = userData![AnyHashable("request_id")]!
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPClientReciveNotaryInfoVC") as? MPClientReciveNotaryInfoVC
            vc?.requestId = selectDay as? Int
            self.navigationController?.pushViewController(vc!, animated: true)
            
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnFindNotary_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPNotaryAceptedCopy") as? MPNotaryAceptedCopy
        self.navigationController?.pushViewController(vc!, animated: true)

    }

    @IBAction func btnBAck_Pressed(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }

    
}
