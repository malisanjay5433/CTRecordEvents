//
//  AppDelegate.swift
//  ClearTap
//
//  Created by Sanjay Mali on 06/04/21.
//

import UIKit
import CleverTapSDK
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        CleverTap.autoIntegrate()
        recordEvent()
        recordEventWithProperties()
        recordEventCharged()
        recordEventAppInbox()
        recordEventPushProfile()
        return true
        
    }
    private func recordEvent(){
        //      #1 Event without properties
        CleverTap.sharedInstance()?.recordEvent("Product viewed")
        print("Record Event")

    }
    private func recordEventWithProperties(){
        //             #2 Event with properties
        let props:[String:Any] = [
            "Product name": "CleverTapSDK",
            "Category": "App analytics, Omnichannel engagement,AI",
            "Price": 99.99,
            "Date": NSDate()
        ]
        CleverTap.sharedInstance()?.recordEvent("Product viewed", withProps: props)
        print("Record Event with Properties")

    }
    private func recordEventCharged(){
        //      #3 Record Charged Event
        let chargeDetails:[String:Any] = [
            "Amount": 299,
            "Payment mode": "Credit Card",
            "Charged ID": 24052013
        ]
        let item1:[String:Any] = [
            "Amount": 299,
            "Payment mode": "Credit Card",
            "Charged ID": 24052013
        ]
        
        let item2:[String:Any] = [
            "Category": "App analytics",
            "Book name": "Analytics",
            "Quantity": 1
        ]
        
        let item3:[String:Any] = [
            "Category": "AI",
            "Book name": "Artificial intelligence is intelligence demonstrated by machines",
            "Quantity": 1
        ]
        CleverTap.sharedInstance()?.recordChargedEvent(withDetails: chargeDetails, andItems: [item1, item2,item3])
        print("Record Event with Charged")
    }
    private func recordEventAppInbox(){
        
        //      #4
        //Initialize the CleverTap App Inbox
        CleverTap.sharedInstance()?.initializeInbox(callback: ({ (success) in
            let messageCount = CleverTap.sharedInstance()?.getInboxMessageCount()
            let unreadCount = CleverTap.sharedInstance()?.getInboxMessageUnreadCount()
            print("Inbox Message:\(String(describing: messageCount))/\(String(describing: unreadCount)) unread")
            
        }))
        let style = CleverTapInboxStyleConfig.init()
        style.title = "App Inbox"
        style.backgroundColor = UIColor.blue
        style.messageTags = ["tag1", "tag2"]
        style.navigationBarTintColor = UIColor.blue
        style.navigationTintColor = UIColor.blue
        style.tabUnSelectedTextColor = UIColor.blue
        style.tabSelectedTextColor = UIColor.blue
        style.tabSelectedBgColor = UIColor.blue
        //        if let inboxController = CleverTap.sharedInstance()?.newInboxViewController(with: style, andDelegate: self) {
        //            let navigationController = UINavigationController.init(rootViewController: inboxController)
        //            self.present(navigationController, animated: true, completion: nil)
        //        }
        
        print("Record Event with AppInbox")
    }
    private  func messageDidSelect(_ message: CleverTapInboxMessage, at index: Int32, withButtonIndex buttonIndex: Int32) {
        // This is called when an inbox message is clicked(tapped or call to action)
        print("This is called when an inbox message is clicked(tapped or call to action")
    }
    private func messageButtonTapped(withCustomExtras customExtras: [AnyHashable : Any]?) {
        print("App Inbox Button Tapped with custom extras: ", customExtras ?? "")
        
    }
    private func recordEventPushProfile(){
        
        //        #5.    Push Profile Event
        let profile:[String:Any] = [
            "Name": "Sanjay",       // String
            "Identity": 61026032,         // String or number
            "Email": "sanjay@gmail.com",    // Email address of the user
            "Phone": "+9192939494",      // Phone (with the country code, starting with +)
            "Gender": "M",                // Can be either M or F
            
            // optional fields. controls whether the user will be sent email, push etc.
            "MSG-email": true,           // Enable email notifications
            "MSG-push": true,             // Enable push notifications
            "MSG-sms": true,              // Enable SMS notifications
            "MSG-whatsapp": true,         // Enable WhatsApp notifications
        ]
        CleverTap.sharedInstance()?.onUserLogin(profile)
        print("Record Event Push Profile")
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

