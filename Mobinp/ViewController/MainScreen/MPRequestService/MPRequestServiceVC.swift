//
//  MPRequestServiceVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import DatePickerDialog
import ActionSheetPicker_3_0
import JSSAlertView


class MPRequestServiceVC: UIViewController {
  
    @IBOutlet var txtDocumentName: UITextField!

    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtCompanyName: UITextField!
    @IBOutlet var txtMeetMeAt: UITextField!

    @IBOutlet weak var btnServiceType: UIButton!
    @IBOutlet weak var btnPayment_Type: UIButton!
    @IBOutlet weak var btnChooseDate: UIButton!
    @IBOutlet weak var btnChoseTime: UIButton!
    @IBOutlet weak var btnSendRequest: UIButton!
    var selectNotaryList: UserInformation?
    @IBOutlet var profilePic: UIImageView!
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?
    var selectService : Int?
    var isDefaultOrCurrent : String?
    @IBOutlet weak var btnSelectCurrent: UIButton!
    @IBOutlet weak var btnSelectDefault: UIButton!
    var isCurrent : Bool?
    var isDefault : Bool?

    var isOnTimeOnGoing : String?
    @IBOutlet weak var btnOnTime: UIButton!
    @IBOutlet weak var btnOnGoing: UIButton!
    var isOnTime : Bool?
    var isOnGoing : Bool?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     setUPUI()
    

        // Do any additional setup after loading the view.
    }

    func setUPUI(){
        
        isCurrent = false
        isDefault = false
        
        
        isOnTime = false
        isOnGoing = false
        isDefaultOrCurrent = "current"
        isOnTimeOnGoing = "0"
        btnSendRequest.layer.shadowOpacity = 0.5
        btnSendRequest.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnSendRequest.layer.shadowRadius = 5.0
        btnSendRequest.layer.shadowColor = UIColor.blue.cgColor
        
        UtilityHelper.setViewBorder(txtDocumentName, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))

        UtilityHelper.setViewBorder(txtEmail, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtCompanyName, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtMeetMeAt, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(btnServiceType, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(btnPayment_Type, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(btnChooseDate, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(btnChoseTime, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        
        txtEmail.setLeftPaddingPoints(10)
        txtDocumentName.setLeftPaddingPoints(10)

        txtCompanyName.setLeftPaddingPoints(10)
        txtMeetMeAt.setLeftPaddingPoints(10)
        
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(MPRequestServiceVC.imageTappedForDp(img:)))
        profilePic.isUserInteractionEnabled = true
        profilePic.addGestureRecognizer(tapGestureRecognizerforDp)


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            
            self.profilePic.image = orignal
            let cgFloat: CGFloat = self.profilePic.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self.profilePic, radius: CGFloat(someFloat))
            self.cover_image = orignal
        }
    }
    
    @IBAction func btnBack_Presed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func btnDatePicker_Pressed(_ sender: UIButton) {
            datePickerTapped()
    }
    
    
    
    @IBAction func btnServiceTypeSelect(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        ActionSheetStringPicker.show(withTitle: "Select Service Type", rows: ["Blah ", "Blah" ,"Hello"], initialSelection: 0 , doneBlock: { (picker, index, value) in
            
            self.btnServiceType.setTitle(value as? String , for: .normal)
            print("values = \(value!)")
            print("indexes = \(index)")
            print("picker = \(picker!)")
            self.selectService = index
            return
        }, cancel: { (actionStrin ) in
            
        }, origin: sender)
    }
    
    @IBAction func btnSelectPayment(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected

        ActionSheetStringPicker.show(withTitle: "Select PAyment Method", rows: ["Manual", "Paypal"], initialSelection: 0 , doneBlock: { (picker, index, value) in
          
            self.btnPayment_Type.setTitle(value as? String , for: .normal)
            print("values = \(value!)")
            print("indexes = \(index)")
            print("picker = \(picker!)")
            return
        }, cancel: { (actionStrin ) in
            
        }, origin: sender)
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
        datePicker.show("DatePickerDialog",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
                                let dateValue = formatter.string(from: dt)
                                self.btnChooseDate.setTitle(dateValue, for: .normal)
                                
            }
        }
    }
    
    @IBAction func btnTimePicker_Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        timePickerTapped()
    }
    
    func timePickerTapped() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = 1970
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: .black,
                                          buttonColor: .black,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show("Time Picker Dialog",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .time) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "HH:mm:ss"
                                let dateValue = formatter.string(from: dt)
                                self.btnChoseTime.setTitle(dateValue, for: .normal)
                                
                            }
                }
    }
    
    @IBAction func btnDefault_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        isDefaultOrCurrent = "current"
        isDefault = true
        isCurrent = false
        btnSelectCurrent.isSelected = false
        btnSelectDefault.isSelected = true
    }
    @IBAction func btnCurrent_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isDefaultOrCurrent = "default"

        isDefault = false
        isCurrent = true

        btnSelectCurrent.isSelected = true
        btnSelectDefault.isSelected = false
    }
    
    
    @IBAction func btnOnTime_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isOnTimeOnGoing = "0"
        isOnTime = true
        isOnGoing = false
        btnOnTime.isSelected = true
        btnOnGoing.isSelected = false
    }
    @IBAction func btnOnGoing_PRessed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isOnTimeOnGoing = "1"

        isOnGoing = true
        isOnTime = false
        
        btnOnGoing.isSelected = true
        btnOnTime.isSelected = false
    }
    
    
    @IBAction func btnSendRequest_Pressed(_ sender: UIButton) {
        
        let serviceURL =  PAYMENTCARD + "?api_token=\(localUserData.apiToken!)"
        
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Card Data", modelType: UserResponse.self , success: { (cardResponse) in
            let cardInfo = cardResponse as? UserResponse
            if cardInfo?.cardInfoObject?.count == 0 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPPaymentVC") as? MPPaymentVC
                
                self.navigationController?.pushViewController(vc!, animated: true)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPConfirmationVC") as? MPConfirmationVC
                vc?.selectDate = self.btnChooseDate.titleLabel?.text
                vc?.selectTime = self.btnChoseTime.titleLabel?.text
                vc?.selectService = self.selectService
                vc?.selectServiceValue = self.btnServiceType.titleLabel?.text
                vc?.paymentType = self.btnPayment_Type.titleLabel?.text
                var notaryId: Any
                if  (self.selectNotaryList != nil) {
                    
                    let notarySelected = self.selectNotaryList?.id
                    notaryId = notarySelected!
                }
                else {
                    notaryId = ""
                    
                }
                
                vc?.selectNotaryList = self.selectNotaryList
                
                vc?.notaryId = notaryId as? Int
                vc?.company_name = self.txtCompanyName.text!
                vc?.business_email = self.txtEmail.text!
                vc?.isDefaultOrCurrent = self.isDefaultOrCurrent
                vc?.on_going = self.isOnTimeOnGoing
                vc?.document_name = self.txtDocumentName.text
                vc?.cover_image = self.cover_image
                vc?.profilePic = self.profilePic.image
                self.navigationController?.pushViewController(vc!, animated: true)

            }
            
        }, fail: { (error) in
            
        })

       
//        let params =      ["api_token"                :   localUserData.apiToken!  ,
//                           "service_id"               :   "\(selectService!)" ,
//                           "notary_id"                :   "\(notaryId)",
//                           "company_name"             :   txtCompanyName.text!,
//                           "business_email"           :   txtEmail.text! ,
//                           "location"                 :   isDefaultOrCurrent! ,
//                           "address"                  :   DEVICE_ADDRESS ,
//                           "appointment_date"         :   selectDate!  ,
//                           "appointment_time"         :   selectTime! ,
//                           "payment_type"             :   "Full" ,
//                           "on_going"                 :   isOnTimeOnGoing! ,
//                           "document_name"             :  txtDocumentName.text!
//                           ] as [String : Any]
//
//        WebServiceManager.multiPartImage(params: params as Dictionary<String, AnyObject> , serviceName: CLIENT_REQUEST, imageParam:"document_image", serviceType: "Client Request", profileImage: profilePic.image , cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
//
//            if let responseObj = response as? UserResponse {
//                if responseObj.success == true {
//
//
////                    if responseObj.requestClientData?.payment_type == "Full" {
////
////                    }
//
//
////                    self.showCustomPop(popMessage: responseObj.message!)
//                    }
//                else
//                {
//
//                    JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)
//
//                }
//            } else {
//                JSSAlertView().danger(self, title: KMessageTitle , text: "Some Error in Api")
//
//            }
//        }) { (error) in
//            JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
//
//
//        }
        
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
        
    
    }
}


