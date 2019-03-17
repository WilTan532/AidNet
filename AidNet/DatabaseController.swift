//
//  DatabaseController.swift
//  AidNet
//
//  Created by shuyu liu on 2019-03-17.
//

import Firebase
import UserNotifications

class DatabaseController {
    var ref: DatabaseReference!
    var handle: DatabaseHandle!
    var data: [String:Any]!
    var event: Event!
    
    func writeEvent(event: Event) {
        var type: String
        switch event.type {
        case .medical:
            type = "medical"
        case .police:
            type = "police"
        case .nature:
            type = "nature"
        default:
            type = "other"
        }
        
        let eventJSON: NSDictionary = [
            "timestamp": event.timestamp,
            "latitude": event.latitude,
            "longitude": event.longitude,
            "type": type
        ]
        
        ref = Database.database().reference()
        ref.child("events").childByAutoId().setValue(eventJSON)
    }
    
    func listenForEvent() {
        ref = Database.database().reference()
        let eventsNode = ref.child("events")
        
        eventsNode.queryOrdered(byChild: "timestamp").queryStarting(atValue: Date().getTimestamp()).observeSingleEvent(of: .childAdded, with: { (snapshot) in
            debugPrint("**************new event added**************")
            self.pushNotification()
        })
    }
    
    // Test area
    func pushNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings(completionHandler: { (settings) in
            guard settings.authorizationStatus == .authorized else {return}
            
            if settings.alertSetting == .enabled {
                self.scheduleNotification()
            }
        })
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Alert"
        content.body = "Someone needs help"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                debugPrint("Something went wrong")
            }
        }
    }
    
    func removeListeners() {
        ref = Database.database().reference()
        ref.removeAllObservers()
    }
}
