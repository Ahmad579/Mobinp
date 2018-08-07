//
//  MPPaymentVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 11/05/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import DatePickerDialog
import JSSAlertView

class MPPaymentVC: UIViewController , CardIOPaymentViewControllerDelegate {
   
    
    var cardInfo: UserResponse?

    @IBOutlet weak var txtOfAccountNum: UITextField!
    @IBOutlet weak var txtAccountName: UITextField!
    @IBOutlet weak var txtCvcNumber: UITextField!

    @IBOutlet weak var viewOfAccountNum: UIView!
    
    var cardExpiryMonth : String?
    var cardExpiryYear : String?

    @IBOutlet weak var btnSelectExpiryDate: UIButton!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var btnScan_Pressed : UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        btnAddCard.layer.shadowOpacity = 0.5
        btnAddCard.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnAddCard.layer.shadowRadius = 5.0
        btnAddCard.layer.shadowColor = UIColor.blue.cgColor
        
        
        txtAccountName.setLeftPaddingPoints(10)
        txtCvcNumber.setLeftPaddingPoints(10)

        
        UtilityHelper.setViewBorder(txtAccountName, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))

        UtilityHelper.setViewBorder(txtCvcNumber, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))

        UtilityHelper.setViewBorder(viewOfAccountNum, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))

        UtilityHelper.setViewBorder(btnSelectExpiryDate, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
    }

    @IBAction func btnSelectDate_Pressed(_ sender: UIButton) {
        datePickerTapped()
    }
    
    @IBAction func btnAddCardNum_Pressed(_ sender: UIButton) {
//        let serviceURL =  GETSERVICE_LIST + "?api_token=\(localUserData.apiToken!)"
        
        let serviceParm =  [ "api_token"               : localUserData.apiToken!,
                             "card_holder_name"        : txtAccountName.text! ,
                             "card_no"                 : txtOfAccountNum.text!,
                             "ccExpiryMonth"           : cardExpiryMonth! ,
                             "ccExpiryYear"            : cardExpiryYear! ,
                             "cvvNumber"               : txtCvcNumber.text! ,
            
            ] as [String : Any]
        
        
        WebServiceManager.post(params:serviceParm as Dictionary<String, AnyObject> , serviceName: ADDCARDINFO, serviceType: "", modelType: UserResponse.self, success: { (response) in
            self.cardInfo = (response as! UserResponse)
            
            if self.self.cardInfo?.success == true {
                self.showCustomPop(popMessage: (self.cardInfo?.message!)!)
            }else {

                JSSAlertView().danger(self, title: KMessageTitle , text: self.cardInfo?.message!)

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

    @IBAction func btnBAck_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnScnaCard_pressed(_ sender: UIButton) {
        
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC?.modalPresentationStyle = .formSheet
        present(cardIOVC!, animated: true, completion: nil)

    }
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
//        resultLabel.text = "user canceled"
        paymentViewController?.dismiss(animated: true, completion: nil)

    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            txtOfAccountNum.text = info.cardNumber
            txtAccountName.text = info.cardholderName
            txtCvcNumber.text = info.cvv
            self.cardExpiryYear = String(info.expiryYear)
            self.cardExpiryMonth = String(info.expiryMonth)
            self.txtOfAccountNum.isUserInteractionEnabled = false
            self.txtCvcNumber.isUserInteractionEnabled = false
            self.btnSelectExpiryDate.isUserInteractionEnabled = false
            
            let expiryYear = "\(self.cardExpiryYear!)-\(self.cardExpiryMonth!)"
            self.btnSelectExpiryDate.setTitle(expiryYear , for: .normal)
            
            
            print(str)
//            resultLabel.text = str as String
        }
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    
    func addCardInfo(cardNo : String , expiryMonth : String , expiryYear : String , cvvNumber : String) {
//        ADDCARDINFO
    }
    
    
//    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
//
//    }
//
//    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                                self.btnSelectExpiryDate.setTitle(dateValue, for: .normal)
                                
                                let formatters = DateFormatter()
                                formatters.dateFormat = "yyyy"
                                let dateValues = formatters.string(from: dt)
//                                self.btnSelectExpiryDate.setTitle(dateValue, for: .normal)
                                self.cardExpiryYear = dateValues
                                
                                let monthFormater = DateFormatter()
                                monthFormater.dateFormat = "MM"
                                let monthValue = monthFormater.string(from: dt)
                                //                                self.btnSelectExpiryDate.setTitle(dateValue, for: .normal)
                                self.cardExpiryMonth = monthValue

                                
                            }
        }
    }
    
}
