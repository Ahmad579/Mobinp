//
//  MPJobPendOrCompleteVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPJobPendOrCompleteVC: UIViewController {

    @IBOutlet var imgOgPending: UIImageView!
    @IBOutlet var imgComplete: UIImageView!

    @IBOutlet var btnPending: UIButton!
    @IBOutlet var btnComplete: UIButton!
    @IBOutlet var tblView: UITableView!
    var isCompletedOrPending : Bool?
    @IBOutlet var viewOfPendingCompleteJob: UIView!
    var responseObj: UserResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPending.isSelected = true
        isCompletedOrPending = true
        UtilityHelper.setViewBorder(viewOfPendingCompleteJob, withWidth: 5.0 , andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        imgOgPending.image = UIImage(named: "nevigationbar_left")
        imgComplete.image = UIImage(named: "")
        getRequestedList()
        // Do any additional setup after loading the view.
    }

    
    func getRequestedList() {
        let serviceURL =  GETCLientREQUEST + "?api_token=\(localUserData.apiToken!)"
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Service List", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            if  self.responseObj?.success == true {
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
            }
            else {
                
                self.showCustomPop(popMessage: (self.responseObj?.message!)!)
                
            }
        }) { (error) in
            
            JSSAlertView().danger(self, title: KMessageTitle , text: error.description)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnPending_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnPending.isSelected = true
        btnComplete.isSelected = false
        imgOgPending.image = UIImage(named: "nevigationbar_left")
        imgComplete.image = UIImage(named: "")
        isCompletedOrPending = true
        getRequestedList()
        
        

    }
    
    @IBAction func btnComplete_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnPending.isSelected = false
        btnComplete.isSelected = true
        imgOgPending.image = UIImage(named: "")
        imgComplete.image = UIImage(named: "nevigationbar_right")
        isCompletedOrPending = false

        getRequestedList()



    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
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

}
extension MPJobPendOrCompleteVC : UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView,
//                   titleForHeaderInSection section: Int) -> String? {
//        return self.section[section]
//
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if isCompletedOrPending == true {
            if  self.responseObj?.listOfRequest?.listOfClientPendinfJob?.isEmpty == false {
                numOfSections = 1
                tblView.backgroundView = nil
            }
            else {
                let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
                noDataLabel.numberOfLines = 10
                if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                    noDataLabel.font = aSize
                }
                noDataLabel.text = "There are currently no Pending Job."
                noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
                noDataLabel.textAlignment = .center
                tblView.backgroundView = noDataLabel
                tblView.separatorStyle = .none
            }
            return numOfSections
        } else {
            if   self.responseObj?.listOfRequest?.listOfClientCompleteJob?.isEmpty == false {
                numOfSections = 1
                tblView.backgroundView = nil
            }
            else {
                let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
                noDataLabel.numberOfLines = 10
                if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                    noDataLabel.font = aSize
                }
                noDataLabel.text = "There are currently no Complete Job."
                noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
                noDataLabel.textAlignment = .center
                tblView.backgroundView = noDataLabel
                tblView.separatorStyle = .none
            }
            return numOfSections
        }
       
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isCompletedOrPending == true {
            return   (self.responseObj?.listOfRequest?.listOfClientPendinfJob?.count)!
        } else {
            return   (self.responseObj?.listOfRequest?.listOfClientCompleteJob?.count)!

        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MPJobCell", for: indexPath) as? MPJobCell
        if isCompletedOrPending == true {
            cell?.lblUserName.text = self.responseObj?.listOfRequest?.listOfClientPendinfJob![indexPath.row].company_name
            cell?.lblCompanyName.text = self.responseObj?.listOfRequest?.listOfClientPendinfJob![indexPath.row].company_name
            cell?.lblDate.text = self.responseObj?.listOfRequest?.listOfClientPendinfJob![indexPath.row].created_at
            cell?.lblCost.text = self.responseObj?.listOfRequest?.listOfClientPendinfJob![indexPath.row].payment_type

            
            //            WAShareHelper.loadImage(urlstring: (self.responseObj?.certificateList![indexPath.row].url)! , imageView: cell.imgOfCertificate, placeHolder: "rectangle_placeholder")

            
        } else {
            cell?.lblUserName.text = self.responseObj?.listOfRequest?.listOfClientCompleteJob![indexPath.row].company_name
            cell?.lblCompanyName.text = self.responseObj?.listOfRequest?.listOfClientCompleteJob![indexPath.row].company_name
            cell?.lblDate.text = self.responseObj?.listOfRequest?.listOfClientCompleteJob![indexPath.row].created_at
            cell?.lblCost.text = self.responseObj?.listOfRequest?.listOfClientCompleteJob![indexPath.row].payment_type

        }
        
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121.0
    }
    
}

extension MPJobPendOrCompleteVC : UITableViewDataSource  {
    
    
}



