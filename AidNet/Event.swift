//
//  Event.swift
//  AidNet
//
//  Created by shuyu liu on 2019-03-17.
//

import Foundation

enum EventType {
    case medical
    case police
    case nature
    case other
}

class Event {
    var latitude: Float
    var longitude: Float
    var type: EventType
    
    init() {
        self.latitude = 0
        self.longitude = 0
        self.type = .other
    }
}
