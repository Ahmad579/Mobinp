//
//  MPReportVC.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 11/06/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import JSSAlertView

class MPReportVC: UIViewController {

    @IBOutlet weak var lblCurrentMonth: UILabel!
    @IBOutlet weak var lblTotalSale: UILabel!
    @IBOutlet weak var lblWeekOfCurrentMonth: UILabel!
    @IBOutlet weak var lblTotalSaleOfMonth: UILabel!
    @IBOutlet weak var lblSaleOfWeek: UILabel!
    @IBOutlet weak var lblProjectSale: UILabel!
    @IBOutlet weak var lblAppointmentBooked: UILabel!
    @IBOutlet weak var lblNewClient: UILabel!
    @IBOutlet weak var lblReturningClient: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTheNotaryReport()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSideMenu(_ sender: Any) {
        self.revealController.show(self.revealController.leftViewController)

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func getTheNotaryReport() {
        
        let serviceURL =  NotaryReport + "?api_token=\(localUserData.apiToken!)"
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Report", modelType: UserResponse.self
            , success: { (response) in
                let response   = (response as! UserResponse)
                if response.success == true {
                    let totalSale = response.notaryReport?.total_sales
                    let saleInCurrentMont = response.notaryReport?.sales_in_current_month
                    let saleInWeek = response.notaryReport?.sales_in_current_week_of_month

                    let saleInNextMonth = response.notaryReport?.projected_sales_in_next_month
                    let currentAppointment = response.notaryReport?.current_appointments
                    let newClient = response.notaryReport?.new_customers
                    let returnCustomer = response.notaryReport?.returning_customers

                    
                    let currentMonth = response.notaryReport?.current_month!
                    self.lblTotalSale.text = "\(totalSale!)"
                    self.lblSaleOfWeek.text = "\(saleInWeek!)"

                    self.lblTotalSaleOfMonth.text = "\(saleInCurrentMont!)"
                    self.lblCurrentMonth.text = "Month of \(currentMonth!)"
                    self.lblWeekOfCurrentMonth.text = "Week of \(currentMonth!)"
                    self.lblProjectSale.text = "\(saleInNextMonth!)"
                    self.lblAppointmentBooked.text = "\(currentAppointment!)"
                    self.lblNewClient.text = "\(newClient!)"
                    self.lblReturningClient.text = "\(returnCustomer!)"
                } else {
                    JSSAlertView().danger(self, title: KMessageTitle , text: response.message!)
                }
                
                
                
                
        }) { (error) in
            
        }

    }
    
}
