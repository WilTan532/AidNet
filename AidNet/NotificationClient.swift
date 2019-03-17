//
//  NotificationClient.swift
//  AidNet
//
//  Created by shuyu liu on 2019-03-17.
//

import UserNotifications

class NotificationClient {
    func push(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
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
}
