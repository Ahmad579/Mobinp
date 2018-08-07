//
//  AppDelegate.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 22/02/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import CoreLocation
import JSSAlertView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var geoCoder : CLGeocoder!
    var placemark : CLPlacemark!

    var token = UserDefaults.standard
//    var applicationStateString: String {
//
//        if UIApplication.shared.applicationState == .active {
//            return "active"
//        } else if UIApplication.shared.applicationState == .background {
//            return "background"
//        }else {
//            return "inactive"
//        }
//    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "abc", PayPalEnvironmentSandbox: "xyz"])
        IQKeyboardManager.sharedManager().enable = true
       application.applicationIconBadgeNumber = 0
        _ =  Location.getLocation(withAccuracy:.block, frequency: .oneShot, onSuccess: { location in
            print("loc \(location.coordinate.longitude)\(location.coordinate.latitude)")
            DEVICE_LAT = location.coordinate.latitude
            DEVICE_LONG = location.coordinate.longitude
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: DEVICE_LAT, longitude: DEVICE_LONG)
            
            geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
                guard let addressDict = placemarks?[0].addressDictionary else {
                    return
                }
                
                // Print each key-value pair in a new row
                addressDict.forEach { print($0) }
                
                // Print fully formatted address
                if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                    print(formattedAddress.joined(separator: ", "))
                    DEVICE_ADDRESS = formattedAddress.joined(separator: ", ")
                }
                
                // Access each element manually
                if let locationName = addressDict["Name"] as? String {
                    print(locationName)
                }
                if let street = addressDict["Thoroughfare"] as? String {
                    print(street)
                }
                if let city = addressDict["City"] as? String {
                    print(city)
                }
                if let zip = addressDict["ZIP"] as? String {
                    print(zip)
                }
                if let country = addressDict["Country"] as? String {
                    print(country)
                }
            })
            
        }, onError: { (last, error) in
            print("Something bad has occurred \(error)")
        })
            
        
        
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        registerForPushNotifications(application: application)

        application.registerForRemoteNotifications()

        
        // Override point for customization after application launch.
        return true
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("GOT A NOTIFICATION")
        completionHandler([.alert, .badge, .sound])
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        
      
        
       
        
        let isNotifyVerifiedDocument = data[AnyHashable("is_verified")] as? Int
        
        if isNotifyVerifiedDocument == 1 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "uploadVerifyDocument"), object: nil, userInfo: data)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ClientReceiveRequest"), object: nil, userInfo: data)
            
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotaryRequest"), object: nil, userInfo: data)

//        is_verified
      
        
//        let aps = data[AnyHashable("aps")]!
//        let requestID = data[AnyHashable("request_id")]!


    
    }
    
//    func application(_  application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        print(userInfo)
//    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        application.applicationIconBadgeNumber += 1
        
        let isNotifyVerifiedDocument = userInfo[AnyHashable("is_verified")] as? Int
        
        if isNotifyVerifiedDocument == 1 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "uploadVerifyDocument"), object: nil, userInfo: userInfo)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ClientReceiveRequest"), object: nil, userInfo: userInfo)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotaryRequest"), object: nil, userInfo: userInfo)



//        var alertController = UIAlertController(title: "Title", message: "Touch On Notify In BAckgroun", preferredStyle: .actionSheet)
//        var okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
//            UIAlertAction in
//            NSLog("OK Pressed")
//        }
//        var cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) {
//            UIAlertAction in
//            NSLog("Cancel Pressed")
//        }
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)

        
        print(userInfo)
  
    
    }
    
    
   
    
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//
//
//
//    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
       
 
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //        let device_token = String(format: "%@", deviceToken as CVarArg) as String
        print(tokenString(deviceToken))
        DEVICE_TOKEN = tokenString(deviceToken)
        print ("device token is",UserDefaults.standard.string(forKey: "deviceToken")!)
         UserDefaults.standard.set(DEVICE_TOKEN, forKey: "device_token")
    }
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        //        let device_token = String(format: "%@", deviceToken as CVarArg) as String
//
//        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
//
////        let device_token = String(format: "%@", deviceToken as CVarArg) as String
//        UserDefaults.standard.set(deviceTokenString, forKey: "device_token")
//        DEVICE_TOKEN = deviceTokenString
//
//
////        DEVICE_TOKEN = deviceTokenString
//        // Print it to console
//        print("APNs device token: \(deviceTokenString)")
//
////        print(tokenString(deviceToken))
////        print ("device token is",UserDefaults.standard.string(forKey: "deviceToken")!)
//    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //        SharedHelper.showAlertView(title: "Error", message: error.localizedDescription)
        print("Failed to register:", error)
        DEVICE_TOKEN = "e34ac7eb71a895f24ce2139ffb1c70d9364702cc6afc7bfa9a4a31b45b474e3e"
        UserDefaults.standard.set(DEVICE_TOKEN, forKey: "device_token")
    }

    
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        //        SharedHelper.showAlertView(title: "Error", message: error.localizedDescription)
//        print("failed to register for remote notifications")
////        UserDefaults.set("-1", forKey: "deviceToken")
//
//        //        DEVICE_TOKEN = "<a11bde2c 0dcf61d5 cb55066a 45aaede9 8222c25b ec85d500 bad60154 c4c87b77>"
//        //        UserDefaults.standard.set(DEVICE_TOKEN, forKey: "device_token")
//    }

    func tokenString(_ deviceToken:Data) -> String{
        //code to make a token string
        let bytes = [UInt8](deviceToken)
        var token = ""
        for byte in bytes{
            token += String(format: "%02x",byte)
        }
        self.token.set(token, forKey: "deviceToken")
//        UserDefaults.set(token, forKey: "deviceToken")
        return token
    }
    
    //for remote notifcations
    func registerForPushNotifications(application: UIApplication) {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .alert , .sound]) { (greanted, error) in
                if greanted {
                    
                    DispatchQueue.main.async {
                        application.registerForRemoteNotifications()
//                        Defaults.set("-1", forKey: "avail")
                    }
                    
                    UIApplication.shared.registerForRemoteNotifications();
                }
            }
        } else {
            let type: UIUserNotificationType = [UIUserNotificationType.badge, UIUserNotificationType.alert, UIUserNotificationType.sound];
            let setting = UIUserNotificationSettings(types: type, categories: nil);
            UIApplication.shared.registerUserNotificationSettings(setting);
//            Defaults.set("-1", forKey: "deviceToken")
            UIApplication.shared.registerForRemoteNotifications();
        }
    }
    
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
//        print("GOT A NOTIFICATION")
//        completionHandler([.alert, .badge, .sound])
//    }
    
    //
    //    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    //
    //    }
    //
    
    
    
    
  
    
}



