//
//  MPShareVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 03/07/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit

class MPShareVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let textToShareBtn = "Check"
        let txtToShare = "I have voted for  Share and   downloading MobinP App"
        
        
        
        if let imageOfModel = NSURL(string: BASE_URLFOR_GALLERY_Image) {
            let objectsToShare = [txtToShare, imageOfModel] as [Any]
            
            
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }
    }
        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
