//
//  EventDispatcher.swift
//  AidNet
//
//  Created by shuyu liu on 2019-03-17.
//

import Foundation
import Firebase

class EventDispatcher {
    func dispatchTest() {
        let eventBuilder = EventBuilder()
        let event = eventBuilder.set(latitude: 15.67).set(longitude: -9.52).set(type: "nature").build()
        let dbController = DatabaseController()
        dbController.writeEvent(event: event)
    }
}
