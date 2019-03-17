//
//  EventBuilder.swift
//  AidNet
//
//  Created by shuyu liu on 2019-03-17.
//

import Foundation

class EventBuilder {
    private var event: Event
    
    init() {
        self.event = Event()
    }
    
    func set(latitude: Float) -> EventBuilder {
        self.event.latitude = latitude
        return self
    }
    
    func set(longitude: Float) -> EventBuilder {
        self.event.longitude = longitude
        return self
    }
    
    func set(type: String) -> EventBuilder {
        switch type {
        case "medical":
            self.event.type = .medical
        case "police":
            self.event.type = .police
        case "climate":
            self.event.type = .nature
        default:
            self.event.type = .other
        }
        
        return self
    }
    
    func build() -> Event {
        return self.event
    }
}
