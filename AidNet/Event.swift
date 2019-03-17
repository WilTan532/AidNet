//
//  Event.swift
//  AidNet
//
//  Created by shuyu liu on 2019-03-17.
//

import Foundation

extension Date {
    func getTimestamp() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

enum EventType {
    case medical
    case police
    case nature
    case other
}

class Event {
    var timestamp: Int64
    var latitude: Float
    var longitude: Float
    var type: EventType
    
    init() {
        self.timestamp = Date().getTimestamp()
        self.latitude = 0
        self.longitude = 0
        self.type = .other
    }
}
