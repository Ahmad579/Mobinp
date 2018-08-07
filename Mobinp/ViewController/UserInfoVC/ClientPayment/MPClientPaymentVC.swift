//
//  MPClientPaymentVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit

class MPClientPaymentVC: UIViewController  {

    @IBOutlet var txtCardNumber: UITextField!
    @IBOutlet var txtCvvNumber: UITextField!
    @IBOutlet var txtExpirateDate: UITextField!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var btnPaypal: UIButton!
    
    var payPalConfig = PayPalConfiguration()
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var acceptCreditCards: Bool = true {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()

        
        // Do any additional setup after loading the view.
    }
    func setUPUI(){
        btnAddCard.layer.shadowOpacity = 0.5
        btnAddCard.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnAddCard.layer.shadowRadius = 5.0
        btnAddCard.layer.shadowColor = UIColor.blue.cgColor
        
        btnPaypal.layer.shadowOpacity = 0.5
        btnPaypal.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnPaypal.layer.shadowRadius = 5.0
        btnPaypal.layer.shadowColor = UIColor.black.cgColor
        
        UtilityHelper.setViewBorder(txtCardNumber, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtCvvNumber, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(txtExpirateDate, withWidth: 0.8, andColor: UIColor(red: 173/255.0, green: 191/255.0, blue: 248/255.0, alpha: 1.0))
        
        txtCardNumber.setLeftPaddingPoints(10)
        txtCvvNumber.setLeftPaddingPoints(10)
        txtExpirateDate.setLeftPaddingPoints(10)
        
        
        payPalConfig.acceptCreditCards = acceptCreditCards;
        payPalConfig.merchantName = "Siva Ganesh Inc."
        ////        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.sivaganesh.com/privacy.html")! as? URL
        //        payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.sivaganesh.com/useragreement.html") as URL?
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal
        
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    @IBAction func btnCross_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func payPressed(sender: AnyObject) {
        
        // Process Payment once the pay button is clicked.
        
        let item1 = PayPalItem(name: "Siva Ganesh Test Item", withQuantity: 1, withPrice: NSDecimalNumber(string: "9.99"), withCurrency: "USD", withSku: "SivaGanesh-0001")
        
        let items = [item1]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "0.00")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Siva Ganesh Test", intent: .sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            
            print("Payment not processalbe: \(payment)")
        }
        
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

extension MPClientPaymentVC : PayPalPaymentDelegate {
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        
    }
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, willComplete completedPayment: PayPalPayment, completionBlock: @escaping PayPalPaymentDelegateCompletionBlock) {
        
    }
    
}

