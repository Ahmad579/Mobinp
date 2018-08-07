//
//  MPNotatyServiceVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPNotatyServiceVC: UIViewController {
    @IBOutlet var viewOfPop: UIView!

    @IBOutlet var tblView: UITableView!
    @IBOutlet var txtServiceName: UITextField!
    @IBOutlet var txtServiceCost: UITextField!

    @IBOutlet var btnAddService: UIButton!
    var responseObj: UserResponse?
    var newService : UserResponse?
    var notaryLuanguage : UserResponse?


    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()
        
       
        }

    
    func setUPUI() {
        btnAddService.layer.shadowOpacity = 0.5
        btnAddService.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnAddService.layer.shadowRadius = 5.0
        btnAddService.layer.shadowColor = UIColor.blue.cgColor
        viewOfPop.isHidden = true

        UtilityHelper.setViewBorder(txtServiceName, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtServiceCost, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        
        txtServiceName.setLeftPaddingPoints(10)
        txtServiceCost.setLeftPaddingPoints(10)
        tblView.register(UINib(nibName: "MPLuanguageHeaderCe", bundle: nil), forCellReuseIdentifier: "MPLuanguageHeaderCe")



    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnAddNewService_Pressed(_ sender: UIButton) {
        viewOfPop.isHidden = false
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
         getServicesList()
    }
    
    @IBAction func btnAddService_Pressed(_ sender: UIButton) {
        let serviceURL =  GETSERVICE_LIST + "?api_token=\(localUserData.apiToken!)"
        
        let serviceParm =  [ "api_token"               : localUserData.apiToken!,
                             "name"                    : txtServiceName.text!,
                             "price"                   : txtServiceCost.text!
                             ] as [String : Any]
        
        
        WebServiceManager.post(params:serviceParm as Dictionary<String, AnyObject> , serviceName: serviceURL, serviceType: "Profile Notary", modelType: UserResponse.self, success: { (response) in
            self.newService = (response as! UserResponse)
            
            if self.self.newService?.success == true {
                self.responseObj?.serviceList?.append((self.newService?.addServiceList)!)
                                                    
                self.viewOfPop.isHidden = true
                self.txtServiceName.text = nil
                self.txtServiceCost.text = nil

                
                self.tblView.reloadData()
            }else {
                
                JSSAlertView().danger(self, title: KMessageTitle , text: self.responseObj?.message!)
                
            }
            
        }, fail: { (error) in
            JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
        }, showHUD: true)
        
        
    }
    @IBAction func btnCross_Pressed(_ sender: UIButton) {
        
        viewOfPop.isHidden = true
    }
    
    
    
    func getServicesList() {
        let serviceURL =  GETSERVICE_LIST + "?api_token=\(localUserData.apiToken!)"
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Service List", modelType: UserResponse.self, success: { (response) in
             self.responseObj = (response as! UserResponse)
            

            if  self.responseObj?.success == true {
//                self.showCustomPop(popMessage: (self.responseObj?.message!)!)
//                self.tblView.delegate = self
//                self.tblView.dataSource = self
//                self.tblView.reloadData()
                    self.getLanguage()
            }
            else {
                
                self.showCustomPop(popMessage: (self.responseObj?.message!)!)

                //            self.showAlert(title: "blink", message: (self.categoriesList?.message)!, controller: self)
            }
        }) { (error) in
            
            JSSAlertView().danger(self, title: KMessageTitle , text: error.description)

        }
    }
    
    
    func getLanguage() {
        let serviceURL =  GETNOTARY_LUANGUAGE + "?api_token=\(localUserData.apiToken!)"
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Service List", modelType: UserResponse.self, success: { (response) in
            self.notaryLuanguage = (response as! UserResponse)
            
            
            if  self.notaryLuanguage?.success == true {
                //                self.showCustomPop(popMessage: (self.responseObj?.message!)!)
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
            }
            else {
                
                self.showCustomPop(popMessage: (self.responseObj?.message!)!)
                
                //            self.showAlert(title: "blink", message: (self.categoriesList?.message)!, controller: self)
            }
        }) { (error) in
            
            JSSAlertView().danger(self, title: KMessageTitle , text: error.description)
            
        }
    }
    
    
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
    }
    
    func showCustomPop(popMessage : String) {
        let customIcon = UIImage(named: "lightbulb")
        let alertview = JSSAlertView().show(self,
                                            title: "Mobinp",
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

    @objc func connected(sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPAddLuanguageVC") as? MPAddLuanguageVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension MPNotatyServiceVC : UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?   {
        if section == 0 {
            return nil
        } else {
            let  headerCell = tableView.dequeueReusableCell(withIdentifier: "MPLuanguageHeaderCe") as! MPLuanguageHeaderCe
//            headerCell.delegate = self
//            headerCell.index?.row = section
            headerCell.btnAddLuanguage.addTarget(self, action: #selector(MPNotatyServiceVC.connected(sender:)), for: .touchUpInside)

            return headerCell.contentView

        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
//         var numOfSections: Int = 0
//        if    self.responseObj?.serviceList?.isEmpty == false {
//            numOfSections = 1
//            tblView.backgroundView = nil
//        }
//        else {
//            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
//            noDataLabel.numberOfLines = 10
//            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
//                noDataLabel.font = aSize
//            }
//            noDataLabel.text = "There are currently no data."
//            noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
//            noDataLabel.textAlignment = .center
//            tblView.backgroundView = noDataLabel
//            tblView.separatorStyle = .none
//        }
//        return numOfSections

        return 2
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return (self.responseObj?.serviceList?.count)!

        } else {
            return (self.notaryLuanguage?.notaryLuanguageList?.count)!
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MPNotaryServiceCell", for: indexPath) as? MPNotaryServiceCell
            cell?.serviceName.text = responseObj?.serviceList![indexPath.row].name
            
            if let price = responseObj?.serviceList![indexPath.row].price {
                cell?.servicePrice.text = price
            } else {
                if  let prices = responseObj?.serviceList![indexPath.row].prices {
                    cell?.servicePrice.textColor = UIColor(red: 132/255.0, green: 132/255.0, blue: 132/255.0, alpha: 1.0)

                    cell?.servicePrice.text = "\(prices)"
                }
            }
            return cell!

        } else {
          
            let cell = tableView.dequeueReusableCell(withIdentifier: "MPNotaryServiceCell", for: indexPath) as? MPNotaryServiceCell
            
            cell?.serviceName.text = notaryLuanguage?.notaryLuanguageList![indexPath.row].language_name
            let prefered  = notaryLuanguage?.notaryLuanguageList![indexPath.row].prefered
            if prefered == 1 {
                cell?.servicePrice.text = "Prefered"
                cell?.servicePrice.textColor = UIColor(red: 13/255.0, green: 72/255.0, blue: 254/255.0, alpha: 1.0)
            } else {
                cell?.servicePrice.text = " "
            }
            return cell!
        }
        
     

        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0 {
            return 0.0
        } else {
            return 60.0

        }
        
    }
    
}

extension MPNotatyServiceVC : UITableViewDataSource  {
    
    
}

//extension  MPNotatyServiceVC : AddLuanguageDelegate  {
//
//    func addLuanguage(checkCell: MPLuanguageHeaderCe, indexPath: IndexPath) {
//        print("ahmad")
//    }
//}

