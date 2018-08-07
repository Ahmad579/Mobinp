//
//  MPNotaryProfileVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 23/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPNotaryProfileVC: UIViewController {
 
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var imgeOfUser: UIImageView!
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?
    var responseObj: UserResponse?
    var certifcateResponse : UserResponse?
    var addNewCertificate : UserResponse?

    @IBOutlet var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        lblUserName.text = localUserData.username
        
        let cgFloat: CGFloat = self.imgeOfUser.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        WAShareHelper.setViewCornerRadius(imgeOfUser , radius: CGFloat(someFloat))
        let imageOfUser = localUserData.avatar_url?.replacingOccurrences(of: " ", with: "%20")
        WAShareHelper.loadImage(urlstring:imageOfUser! , imageView: imgeOfUser!, placeHolder: "image_placeholder")
        
        
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(MPNotaryProfileVC.imageTappedForDp(img:)))
        imgeOfUser.isUserInteractionEnabled = true
        imgeOfUser.addGestureRecognizer(tapGestureRecognizerforDp)
        getALLReview()
//        getAllCertificate()
        // Do any additional setup after loading the view.
    }

    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            
            self.imgeOfUser.image = orignal
            let cgFloat: CGFloat = self.imgeOfUser.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self.imgeOfUser, radius: CGFloat(someFloat))
            self.cover_image = orignal
            
            let params =      ["api_token"                    :  localUserData.apiToken!  ,
                               ] as [String : Any]
            
            WebServiceManager.multiPartImage(params: params  as Dictionary<String, AnyObject> , serviceName: UPDATE_PROFILE_PIC, imageParam:"profile_image", serviceType: "Update Avatar", profileImage: self.imgeOfUser.image, cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
               
                if let responseObj = response as? UserResponse {
                    if responseObj.success == true {
                        //                    self.userInfo = (response as? UserResponse)!
                        
                        
                        self.showCustomPop(popMessage: (responseObj.message!))
                    }
                    else
                    {
                        JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)
                    }
                    
                } else {
                    JSSAlertView().danger(self, title: KMessageTitle , text: "Some Error in Api")
                    
                }
//                let responseObj = response as! UserResponse
//
//                if responseObj.success == true {
//                    //                    self.userInfo = (response as? UserResponse)!
//                    self.showCustomPop(popMessage: (responseObj.message!))
//                }
//                else
//                {
//                    JSSAlertView().danger(self, title: KMessageTitle , text: responseObj.message!)
//
//                }
                
            }) { (error) in
                JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
                
                
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func getAllCertificate() {
        
        let serviceURL =  GETALLCertificate + "?api_token=\(localUserData.apiToken!)&notary_id=\(localUserData.id!)"
            WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Review List", modelType: UserResponse.self, success: { (response) in
                self.certifcateResponse = (response as! UserResponse)
                
                
                if  self.certifcateResponse?.success == true {
                    self.tblView.delegate = self
                    self.tblView.dataSource = self
                    self.tblView.reloadData()
                }
                else {
                    
                    self.showCustomPop(popMessage: (self.certifcateResponse?.message!)!)
                    
                    //            self.showAlert(title: "blink", message: (self.categoriesList?.message)!, controller: self)
                }
            }) { (error) in
                
                JSSAlertView().danger(self, title: KMessageTitle , text: error.description)
                
            }
        }
        
    func getALLReview() {
        
        let serviceURL =  GETALLREVIEWLIST + "?api_token=\(localUserData.apiToken!)&notary_id=\(localUserData.id!)"
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Review List", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            if  self.responseObj?.success == true {
                self.getAllCertificate()
            }
            else {
                
                self.showCustomPop(popMessage: (self.responseObj?.message!)!)
                
                //            self.showAlert(title: "blink", message: (self.categoriesList?.message)!, controller: self)
            }
        }) { (error) in
            
            JSSAlertView().danger(self, title: KMessageTitle , text: error.description)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
    }

    @IBAction func btnSetting_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MPNotarySettingVC") as? MPNotarySettingVC
        self.navigationController?.pushViewController(vc!, animated: true)
    
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
        
        certifcateResponse?.certificateList?.append((addNewCertificate?.uploadCertificate)!)
        
        tblView.reloadData()
        print("Close callback called")
    }
}

extension MPNotaryProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            var cell: NotaryReviewCell? = tableView.dequeueReusableCell(withIdentifier: "Certificate") as! NotaryReviewCell?
            if cell == nil {
                cell = NotaryReviewCell(style: .default, reuseIdentifier: "Certificate")
            }
            cell?.delegate = self
            cell?.index = indexPath
            cell?.collectionViewCell.reloadData()
            cell?.responseObj = self.certifcateResponse
            return cell!

        } else  {
            var cell: NotaryReviewCell? = tableView.dequeueReusableCell(withIdentifier: "Reviews") as! NotaryReviewCell?
            if cell == nil {
                cell = NotaryReviewCell(style: .default, reuseIdentifier: "Reviews")
            }
            
            
            cell?.lblServiceTitle.text = self.responseObj?.reviewList![indexPath.row].comment
            cell?.lblName.text = self.responseObj?.reviewList![indexPath.row].notaryReview?.name
            cell?.lblDate.text = self.responseObj?.reviewList![indexPath.row].created_at
            cell?.viewOfReview.rating = Double((self.responseObj?.reviewList![indexPath.row].rating)!)
            cell?.responseObj = self.certifcateResponse


            return cell!
        }
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else  {
            return (self.responseObj?.reviewList?.count)!
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if indexPath.section ==  0 {
            return 142.0
        } else {
            return 90.0
        }
    }
    
    

}

extension  MPNotaryProfileVC : UploadCertificate {
    
    func selectCertificateToUploa(checkCell : NotaryReviewCell , indexPath : IndexPath)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            
//            self.imgeOfUser.image = orignal
//            let cgFloat: CGFloat = self.imgeOfUser.frame.size.width/2.0
//            let someFloat = Float(cgFloat)
//            WAShareHelper.setViewCornerRadius(self.imgeOfUser, radius: CGFloat(someFloat))
            self.cover_image = orignal
            
            let params =      ["api_token"                    :  localUserData.apiToken!  ,
                               "file_name"                    : "Test certificate"
                               ] as [String : Any]
            
            WebServiceManager.multiPartImage(params: params  as Dictionary<String, AnyObject> , serviceName: UPDATE_CERTIFICATE, imageParam:"certificate_image", serviceType: "Update Avatar", profileImage: self.cover_image, cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
                self.addNewCertificate = response as? UserResponse
                
                if  self.addNewCertificate?.success == true {

                    self.showCustomPop(popMessage: (self.addNewCertificate?.message!)!)
                    
                    
                }
                else
                {
                    JSSAlertView().danger(self, title: KMessageTitle , text: self.addNewCertificate?.message!)
                    
                }
                
            }) { (error) in
                JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
                
                
            }
            
        }
    }
}

//MPNotaryProfileVC


