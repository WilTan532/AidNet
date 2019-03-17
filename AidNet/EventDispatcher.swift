//
//  EventDispatcher.swift
//  AidNet
//
//  Created by shuyu liu on 2019-03-17.
//

import CoreLocation
import Firebase

class EventDispatcher {
    func dispatch() {
        let eventBuilder = EventBuilder()
        let event = eventBuilder.set(latitude: 43.64).set(longitude: -79.39).set(type: "medical").build()
        let dbController = DatabaseController()
        dbController.writeEvent(event: event)
    }
}
