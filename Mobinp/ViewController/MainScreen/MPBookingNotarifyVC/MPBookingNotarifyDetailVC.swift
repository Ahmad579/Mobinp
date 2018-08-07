//
//  MPBookingNotarifyDetailVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 11/04/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPBookingNotarifyDetailVC: UIViewController {

    var requestObj : ServiceRequestObject?
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var lblDate: UILabel!
    
    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet var lblFirstLetter: UILabel!
    @IBOutlet var lblDocumentName: UILabel!
    
    @IBOutlet var imageOfDocument: UIImageView!
    @IBOutlet weak var imageOfBooking: UIImageView!
    @IBOutlet var btnSubmitFile: UIButton!

    let photoPicker = PhotoPicker()
    var cover_image: UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblName.text = requestObj?.company_name
        lblDate.text = requestObj?.appointment
        lblTime.text = requestObj?.appointment
        lblDocumentName.text = requestObj?.documentObject![0].name
        
        if requestObj?.documentObject![0].verified == true {
            btnSubmitFile.isHidden = true
            imageOfBooking.image = UIImage(named: "verified")

        } else {
            btnSubmitFile.isHidden = false

            imageOfBooking.image = UIImage(named: "document")

        }
        

        
       
        // Do any additional setup after loading the view.
    }

    @IBAction func btnUploadDocument(_ sender: UIButton) {
       
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSubmit_Pressed(_ sender: UIButton) {
        
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            self.imageOfDocument.image = orignal
            let cgFloat: CGFloat = self.imageOfDocument.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self.imageOfDocument, radius: CGFloat(someFloat))
            self.cover_image = orignal
            
            let documentID  = self.requestObj?.documentObject![0].idofDocument!
            let requestId = self.requestObj?.documentObject![0].request_id!
            let params =         ["api_token"                    :  localUserData.apiToken!  ,
                                  "client_request_id"            :  "\(requestId!)" ,
                                  "request_document_id"            :  "\(documentID!)"
                ] as [String : Any]
            
            WebServiceManager.multiPartImage(params: params  as Dictionary<String, AnyObject> , serviceName: GETNotaryRequestDocument, imageParam:"document_image", serviceType: "Update Avatar", profileImage: self.imageOfDocument.image, cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
                
                if let responseObj = response as? UserResponse {
                    if responseObj.success == true {
                        self.imageOfBooking.image = UIImage(named: "verified")
                         self.btnSubmitFile.isHidden = true
                        
                        
                        self.showCustomPop(popMessage: (responseObj.message!))
                    }
                    else
                    {
                        self.btnSubmitFile.isHidden = false
                        JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)
                    }
                
                } else {
                    JSSAlertView().danger(self, title: KMessageTitle , text: "Some Error in Api")
                    
                }
                
                
                
            }) { (error) in
                JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
                
                
            }
            
            
        }

        
//
        
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
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
