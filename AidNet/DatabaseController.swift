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
    
    func listenForEventAndNotify() {
        ref = Database.database().reference()
        let eventsNode = ref.child("events")
        
        eventsNode.queryOrdered(byChild: "timestamp").queryStarting(atValue: Date().getTimestamp()).queryLimited(toLast: 1).observeSingleEvent(of: .childAdded, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let latitude = value?["latitude"] as? Float
            let longitude = value?["longtitude"] as? Float
            let eventType = value?["type"] as! String
            NotificationClient().push(title: "Alert", body: "Someone needs \(eventType) help")
        })
    }
}
