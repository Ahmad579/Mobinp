//
//  MPJobCompleteVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 02/06/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView
import SCLAlertView
import Cosmos
class MPJobCompleteVC: UIViewController {
    
    var requestId : Int?

    var responseObj: UserResponse?
    
    @IBOutlet weak var imgOFNotary: UIImageView!
    
    @IBOutlet weak var nameOfNotary: UILabel!
    @IBOutlet weak var viewOfPopReview: UIView!
    
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var lblDate: UILabel!
    
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblJobType: UILabel!

    @IBOutlet var lblFirstLetter: UILabel!
    @IBOutlet var lblDocumentName: UILabel!
    
    @IBOutlet weak var viewOfReview: CosmosView!
    @IBOutlet var imageOfDocument: UIImageView!
    @IBOutlet weak var imageOfBooking: UIImageView!
    var completeJob: UserResponse?
    var isPopAppear : Bool?
    var ratingOfUser : Double?


    override func viewDidLoad() {
        super.viewDidLoad()
        isPopAppear = false
        viewOfReview.didTouchCosmos = didTouchCosmos
        viewOfReview.didFinishTouchingCosmos = didFinishTouchingCosmos
        
        
//        var requestClientData        :       ServiceRequestObject?
        
        getRequestOfNotary()
        // Do any additional setup after loading the view.
    }

    private class func formatValue(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    private func didTouchCosmos(_ rating: Double) {
        //        ratingSlider.value = Float(rating)
        //        ratingLabel.text = ViewController.formatValue(rating)
        //        ratingLabel.textColor = UIColor(red: 133/255, green: 116/255, blue: 154/255, alpha: 1)
        
        print(rating)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        ratingOfUser = rating
        print(rating)
        
    }
    
    func getRequestOfNotary() {
        let serviceURL =  GETCLientREQUEST + "/\(requestId!)" + "?api_token=\(localUserData.apiToken!)"
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Get Request", modelType: UserResponse.self, success: { (response) in
            self.responseObj  = (response as! UserResponse)
            if self.responseObj?.success == true {
                self.lblName.text = self.responseObj?.requestClientData?.clientGetNotaryObject?.username
                self.lblDate.text = self.responseObj?.requestClientData?.appointment
                self.lblTime.text = self.responseObj?.requestClientData?.appointment
                let cgFloat: CGFloat = self.imageOfBooking.frame.size.width/2.0
                let someFloat = Float(cgFloat)
                WAShareHelper.setViewCornerRadius(self.imageOfBooking , radius: CGFloat(someFloat))
                let imageOfUser = self.responseObj?.requestClientData?.clientGetNotaryObject?.avatar_url?.replacingOccurrences(of: " ", with: "%20")
                WAShareHelper.loadImage(urlstring:imageOfUser! , imageView: self.imageOfBooking!, placeHolder: "user")
                
                WAShareHelper.setViewCornerRadius(self.imgOFNotary , radius: CGFloat(someFloat))
                let imageOfNotary = self.responseObj?.requestClientData?.clientGetNotaryObject?.avatar_url?.replacingOccurrences(of: " ", with: "%20")
             
                WAShareHelper.loadImage(urlstring:imageOfNotary! , imageView: self.imgOFNotary!, placeHolder: "user")
                self.nameOfNotary.text = self.responseObj?.requestClientData?.clientGetNotaryObject?.username

                
                
                self.lblJobType.text = self.responseObj?.requestClientData?.clientGetNotaryObject?.type
                self.lblDocumentName.text = self.responseObj?.requestClientData?.documentObject![0].name
            } else {
                self.showCustomPop(popMessage: (self.responseObj?.message!)!)

            }
            
            
        }) { (error) in
            
        }
        
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnDoneReview(_ sender: UIButton) {
//
        
        let notaryId = self.responseObj?.requestClientData?.notary_id

        
        let completeJobParam =  [ "api_token"               : localUserData.apiToken!,
                                  "notary_id"               : notaryId! ,
                                  "rating"                  : ratingOfUser! ,
                                  "comment"                 : "This is Awesome"
            ] as [String : Any]
        
        WebServiceManager.post(params:completeJobParam as Dictionary<String, AnyObject> , serviceName: CLIENTREVIEWNOTARY, serviceType: "Client Pay", modelType: UserResponse.self, success: { (response) in
            self.completeJob = (response as! UserResponse)
            
            if self.completeJob?.success == true {
                self.viewOfPopReview.isHidden = true
                
            }else {
                self.showCustomPop(popMessage: (self.completeJob?.message!)!)
            }
        }, fail: { (error) in
            JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
        }, showHUD: true)
        
    }
    
    @IBAction func btnCompleteJob_Pressed(_ sender: UIButton) {
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false,
            dynamicAnimatorActive: true,
            buttonsLayout: .horizontal
        )
        let alert = SCLAlertView(appearance: appearance)
        _ = alert.addButton("Yes", target:self, selector:#selector(MPJobCompleteVC.firstButton))
        _ = alert.addButton("No", target:self, selector:#selector(MPJobCompleteVC.secondButton))
        let icon = UIImage(named:"user")
        let color = UIColor.orange
        
        _ = alert.showCustom("MobiNP", subTitle: "Are you sure to end this Job", color: color, circleIconImage: icon!)
        
       
        
    
    }
    
    @objc func firstButton() {
        
        let serviceParm =  [ "api_token"               : localUserData.apiToken!,
                             "request_id"              : 332
            ] as [String : Any]
        WebServiceManager.post(params:serviceParm as Dictionary<String, AnyObject> , serviceName: COMPLETEJOB, serviceType: "Profile Notary", modelType: UserResponse.self, success: { (response) in
            self.completeJob = (response as! UserResponse)
            
            if self.completeJob?.success == true {
                
                let notaryId = self.responseObj?.requestClientData?.notary_id
                let clientId = self.responseObj?.requestClientData?.client_id
                let cardHolderName = self.responseObj?.requestClientData?.clientObj?.paymentInfo?.card_holder_name
                let card_no = self.responseObj?.requestClientData?.clientObj?.paymentInfo?.card_number
                let expiryMonth = self.responseObj?.requestClientData?.clientObj?.paymentInfo?.expiration_month
                let expiryYear = self.responseObj?.requestClientData?.clientObj?.paymentInfo?.expiration_year
                let ccvNum = self.responseObj?.requestClientData?.clientObj?.paymentInfo?.cvv
                let completeJobParam =  [ "api_token"               : localUserData.apiToken!,
                                          "request_id"              : self.requestId! ,
                                          "notary_id"               : notaryId! ,
                                          "client_id"               : clientId! ,
                                          "card_holder_name"        : cardHolderName! ,
                                          "card_no"                 : "4242424242424242",
                                          "ccExpiryMonth"           : "12" ,
                                          "ccExpiryYear"            : "2018",
                                          "cvvNumber"               : "123" ,
                                          "amount"                  : 100
                                        ] as [String : Any]
             
                WebServiceManager.post(params:completeJobParam as Dictionary<String, AnyObject> , serviceName: CLIENTPAYTONOTARY, serviceType: "Client Pay", modelType: UserResponse.self, success: { (response) in
                    self.completeJob = (response as! UserResponse)
                    
                    if self.completeJob?.success == true {
//                        self.isPopAppear = true
//                        self.showCustomPop(popMessage: "Completed Job Successfully")
                        self.viewOfPopReview.isHidden = false
                        
                    }else {
                        self.isPopAppear = true
                        self.showCustomPop(popMessage: (self.completeJob?.message!)!)

//                        JSSAlertView().danger(self, title: KMessageTitle , text: self.completeJob?.message!)
                        
                    }
                }, fail: { (error) in
                    JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
                }, showHUD: true)
//
                
            }else {
                
                JSSAlertView().danger(self, title: KMessageTitle , text: self.completeJob?.message!)
                
            }
            
        }, fail: { (error) in
            JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
        }, showHUD: true)
    }
    
    @objc func secondButton() {
//        self.isRequestAceeptOrReject(hasAccepted: 1 , acceptOrReject: NURSEDECLINE , isAcceptOrReject: false)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if  isPopAppear == true {
            self.navigationController?.popToRootViewController(animated: true)
        }

    }

}
