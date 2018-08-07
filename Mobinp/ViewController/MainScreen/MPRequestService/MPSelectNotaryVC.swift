//
//  MPSelectNotaryVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 21/03/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPSelectNotaryVC: UIViewController {
    var responseObj: UserResponse?
    @IBOutlet var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getNotaryList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnRandomRequest_Pressed(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPRequestServiceVC") as? MPRequestServiceVC
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
   
    func getNotaryList() {
        let serviceURL =  GETNOTARY_LIST + "?api_token=\(localUserData.apiToken!)"
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Service List", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            
            
            if  self.responseObj?.success == true {
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
    
    
    @IBAction func btnBack_Presed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
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

extension MPSelectNotaryVC : UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if    self.responseObj?.notaryList?.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }
        else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no data."
            noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
            noDataLabel.textAlignment = .center
            tblView.backgroundView = noDataLabel
            tblView.separatorStyle = .none
        }
        return numOfSections
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.responseObj?.notaryList?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectNotaryCell", for: indexPath) as? SelectNotaryCell
cell?.delegate = self
        
        
        cell?.btnRequestSent_Pressed.layer.shadowOpacity = 0.5
        cell?.btnRequestSent_Pressed.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        cell?.btnRequestSent_Pressed.layer.shadowRadius = 5.0
        cell?.btnRequestSent_Pressed.layer.shadowColor = UIColor.blue.cgColor

        cell?.index = indexPath
        cell?.userName.text = responseObj?.notaryList![indexPath.row].username
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPClientSeeNotaryProfileVC") as? MPClientSeeNotaryProfileVC
        vc?.selectNotaryList = self.responseObj?.notaryList![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77.0
    }
    
}

extension MPSelectNotaryVC : UITableViewDataSource  {
    
    
}

extension MPSelectNotaryVC : SelectNotaryUser {
   
    func selectUer(selectCell : SelectNotaryCell , indexPath : IndexPath)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPRequestServiceVC") as? MPRequestServiceVC
        vc?.selectNotaryList = self.responseObj?.notaryList![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
