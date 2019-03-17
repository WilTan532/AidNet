//
//  DatabaseController.swift
//  AidNet
//
//  Created by shuyu liu on 2019-03-17.
//

import Firebase

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
            "latitude": event.latitude,
            "longitude": event.longitude,
            "type": type
        ]
        
        ref = Database.database().reference()
        ref.child("events").childByAutoId().setValue(eventJSON)
    }
}
