//
//  MPBookingNotarifyVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPBookingNotarifyVC: UIViewController {
    @IBOutlet weak var tblViewss: UITableView!
    var responseObj: UserResponse?

//    let section = ["Monday", "Tuesday", "Wednesday"]
//    let items = [["Ahmad", "Check", "HELLO"], ["sausage", "meat lovers", "veggie lovers"], ["sausage", "chicken pesto", "prawns", "mushrooms"]]

    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  MPBookingCell
        tblViewss.register(UINib(nibName: "MPBookingCell", bundle: nil), forCellReuseIdentifier: "MPBookingCell")
        tblViewss.register(UINib(nibName: "ServiceHeaderCell", bundle: nil), forCellReuseIdentifier: "ServiceHeaderCell")
        NotificationCenter.default.addObserver(self, selector: #selector(MPBookingNotarifyVC.NotaryUserSelect(_:)), name: NSNotification.Name(rawValue: "NotaryRequest"), object: nil)
//        selectNotary()
        getAllNotaryBooking()
        // Do any additional setup after loading the view.
    }
    
//
    
    
    func getAllNotaryBooking() {
        let serviceURL =  GETCLientREQUEST + "?api_token=\(localUserData.apiToken!)"
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Client Request", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            
            
            if  self.responseObj?.success == true {
                //                self.showCustomPop(popMessage: (self.responseObj?.message!)!)
                self.tblViewss.delegate = self
                self.tblViewss.dataSource = self
                self.tblViewss.reloadData()
            }
            else {
                
                self.showCustomPop(popMessage: (self.responseObj?.message!)!)
                
                //            self.showAlert(title: "blink", message: (self.categoriesList?.message)!, controller: self)
            }
        }) { (error) in
            
            JSSAlertView().danger(self, title: KMessageTitle , text: error.description)
            
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

    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
   

    @objc func NotaryUserSelect(_ notification: NSNotification) {
        
        let userData = notification.userInfo
        let selectDay = userData![AnyHashable("request_id")]!
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPNotaryAceptedCopy") as? MPNotaryAceptedCopy
        vc?.requestId = selectDay as? Int
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}

extension MPBookingNotarifyVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?   {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "ServiceHeaderCell") as! ServiceHeaderCell
        headerCell.titleOfHeader.text = self.responseObj?.notaryAllList?.selectNotaryList![section].type
        return headerCell.contentView

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.responseObj?.notaryAllList?.selectNotaryList?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.responseObj?.notaryAllList?.selectNotaryList?[section].typeObject?.count)!
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "MPBookingCell", for: indexPath) as? MPBookingCell
        
        cell?.lblTitleOfUser.text = self.responseObj?.notaryAllList?.selectNotaryList?[indexPath.section].typeObject![indexPath.row].company_name
        cell?.lblTime.text = self.responseObj?.notaryAllList?.selectNotaryList?[indexPath.section].typeObject![indexPath.row].appointment
        cell?.lblDate.text = self.responseObj?.notaryAllList?.selectNotaryList?[indexPath.section].typeObject![indexPath.row].appointment
        cell?.lblLoadSigning.text = self.responseObj?.notaryAllList?.selectNotaryList?[indexPath.section].typeObject![indexPath.row].payment_type
        if   self.responseObj?.notaryAllList?.selectNotaryList?[indexPath.section].typeObject![indexPath.row].documentObject![0].verified == true {
            cell?.imageOfBooking.image = UIImage(named: "verified")
        } else {
            cell?.imageOfBooking.image = UIImage(named: "document")

        }
        
        



//        cell?.lblTitleOfUser?.text = self.items[indexPath.section][indexPath.row]
        
        return cell!

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPBookingNotarifyDetailVC") as? MPBookingNotarifyDetailVC
        vc?.requestObj = self.responseObj?.notaryAllList?.selectNotaryList?[indexPath.section].typeObject![indexPath.row]
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60.0
        
    }
}

extension MPBookingNotarifyVC : UITableViewDataSource  {


}
