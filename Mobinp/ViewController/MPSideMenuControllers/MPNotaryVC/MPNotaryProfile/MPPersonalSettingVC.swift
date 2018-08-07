//
//  MPPersonalSettingVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 09/03/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import DatePickerDialog
import JSSAlertView

class MPPersonalSettingVC: UIViewController {

    
    @IBOutlet weak var btnDone: UIButton!

    @IBOutlet var txtNotatyType: UITextField!
    @IBOutlet var txtCommisionNo: UITextField!
    @IBOutlet var txtBondInfo: UITextField!
    @IBOutlet var txtEandOInsurance: UITextField!
    @IBOutlet var txtSuggesdForService: UITextField!
    @IBOutlet var txtNotatyQual: UITextField!
    @IBOutlet var txtDeliveryCharges: UITextField!


    @IBOutlet weak var btnActivateDate: UIButton!
    @IBOutlet weak var btnExpirayDate: UIButton!
    @IBOutlet weak var btnSelectNotaryType: UIButton!
    var isActivationDateOrExpirayDateSelected : Bool?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }

    func setUpUI() {
        isActivationDateOrExpirayDateSelected = false
        
        btnDone.layer.shadowOpacity = 0.5
        btnDone.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnDone.layer.shadowRadius = 5.0
        btnDone.layer.shadowColor = UIColor.blue.cgColor
        
        
        UtilityHelper.setViewBorder(btnSelectNotaryType, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtCommisionNo, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtBondInfo, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtEandOInsurance, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtSuggesdForService, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtNotatyQual, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(btnActivateDate, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(btnExpirayDate , withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        
        txtNotatyQual.setLeftPaddingPoints(10)
        txtSuggesdForService.setLeftPaddingPoints(10)
        txtEandOInsurance.setLeftPaddingPoints(10)
        txtBondInfo.setLeftPaddingPoints(10)
        txtCommisionNo.setLeftPaddingPoints(10)
//        txtNotatyType.setLeftPaddingPoints(10)
        getNotaryProfileService()
    }

    @IBAction func btnCross_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnSelectNotaryType_Pressed(_ sender: UIButton) {
        ActionSheetStringPicker.show(withTitle: "Select Notary Type", rows: ["ABC", "ABC Law" , "Software Engineer"], initialSelection: 0 , doneBlock: { (picker, index, value) in
            
            self.btnSelectNotaryType.setTitle(value as? String , for: .normal)
            print("values = \(value!)")
            print("indexes = \(index)")
            print("picker = \(picker!)")
            return
        }, cancel: { (actionStrin ) in
            
        }, origin: sender)
    }
    
    func getNotaryProfileService() {
        
        let serviceURL =  GETNOTARIFYPROFILE + "?api_token=\(localUserData.apiToken!)"

        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Categories List", modelType: UserResponse.self, success: { (response) in
//            let responseObj = response as! UserResponse

            if let responseObj = response as? UserResponse {
                if  responseObj.success == true {
                    
                    self.txtCommisionNo.text = responseObj.notaryProfile?.commission_no
                    self.txtBondInfo.text = responseObj.notaryProfile?.surety_bond_information
                    self.txtEandOInsurance.text = responseObj.notaryProfile?.e_and_o_insurance
                    if let serviceValue = responseObj.notaryProfile?.suggested_fees_for_services {
                        self.txtSuggesdForService.text = ("\(serviceValue)")
                        
                    }
                    
                    self.txtNotatyQual.text = responseObj.notaryProfile?.notary_qualifications
                    self.btnSelectNotaryType.setTitle(responseObj.notaryProfile?.notary_type , for: .normal)
                    self.btnActivateDate.setTitle(responseObj.notaryProfile?.activation_date , for: .normal)
                    self.btnExpirayDate.setTitle(responseObj.notaryProfile?.expiration_date , for: .normal)
                    
                    
                }
                else {
                    
                    //            self.showAlert(title: "blink", message: (self.categoriesList?.message)!, controller: self)
                }
                
            } else {
                JSSAlertView().danger(self, title: KMessageTitle , text: "Some Error in Api")
                
            }
            
          
        }) { (error) in

            
            //            self.showAlert(title: "Blink", message: (self.categoriesList?.message)!, controller: self)
        }
    }
    
    
    @IBAction func btnActivationDate_Pressed(_ sender: UIButton) {
        isActivationDateOrExpirayDateSelected = true
        datePickerTapped()
    }
    
    @IBAction func btnExpirationDate_Pressed(_ sender: UIButton) {
        isActivationDateOrExpirayDateSelected = false
        datePickerTapped()
    }
    
    func datePickerTapped() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = 1970
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: .black,
                                          buttonColor: .black,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show("Date Picker Dialog",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                
                                formatter.dateFormat = "yyyy-MM-dd"
                                let dateValue = formatter.string(from: dt)
                                if self.isActivationDateOrExpirayDateSelected == true {
                                    self.btnActivateDate.setTitle(dateValue, for: .normal)
                                    
                                } else {
                                    self.btnExpirayDate.setTitle(dateValue, for: .normal)
                                    
                                }
                                
                            }
        }
    }
    
    
    @IBAction func btnSave_Pressed(_ sender: UIButton) {
        let activeDate = btnActivateDate.titleLabel?.text
        let expiryDate = btnExpirayDate.titleLabel?.text
        let notaryType = btnSelectNotaryType.titleLabel?.text
        
        
        let loginParam =  [ "api_token"                      : localUserData.apiToken!,
                            "notary_type"                    : notaryType!,
                            "commission_no"                  : txtCommisionNo.text! ,
                            "activation_date"                : activeDate! ,
                            "expiration_date"                : expiryDate! ,
                            "surety_bond_information"        : "N/A" ,
                            "e_and_o_insurance"              : "Yes" ,
                            "delivery_charges"               : txtDeliveryCharges.text! ,
                            "suggested_fees_for_services"    : txtSuggesdForService.text!,
                            "notary_qualifications"          : txtNotatyQual.text! ,
                            "_method"               : "PUT"
            ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: PROFILENOTARYUpdate, serviceType: "Profile Notary", modelType: UserResponse.self, success: { (response) in
//            let responseObj = response as! UserResponse
            
            if let responseObj = response as? UserResponse {
                if responseObj.success == true {
                    
                    self.showCustomPop(popMessage: responseObj.message!)
                    self.txtCommisionNo.text = responseObj.notaryProfile?.commission_no
                    self.txtBondInfo.text = responseObj.notaryProfile?.surety_bond_information
                    self.txtEandOInsurance.text = responseObj.notaryProfile?.e_and_o_insurance
                    //                self.txtSuggesdForService.text =
                    
                    //                let serviceValue = responseObj.notaryProfile?.suggested_fees_for_services
                    
                    if let serviceValue = responseObj.notaryProfile?.suggested_fees_for_services {
                        self.txtSuggesdForService.text = ("\(serviceValue)")
                        
                    }
                    self.txtNotatyQual.text = responseObj.notaryProfile?.notary_qualifications
                    self.btnSelectNotaryType.setTitle(responseObj.notaryProfile?.notary_type , for: .normal)
                    self.btnActivateDate.setTitle(responseObj.notaryProfile?.activation_date , for: .normal)
                    self.btnExpirayDate.setTitle(responseObj.notaryProfile?.expiration_date , for: .normal)
                    
                    
                }else {
                    
                    JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)
                    
                }
                
            } else {
                JSSAlertView().danger(self, title: KMessageTitle , text: "Some Error in Api")
                
            }
            
            
           
            
        }, fail: { (error) in
            JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
        }, showHUD: true)
    
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
