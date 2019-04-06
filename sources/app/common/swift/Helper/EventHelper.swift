//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import Foundation

class Event<T> {

    typealias EventHandler = (T) -> ()
    
    private var eventHandlers = [EventHandler]()
    private var eventHandlersWithKey = [String:EventHandler]()
    
    func addHandler(handler: @escaping EventHandler) {
        eventHandlers.append(handler)
    }
    
    func addHandler(for key: String,handler:@escaping EventHandler){
        eventHandlersWithKey[key] = handler
    }
    
    func raise(data: T) {
        for handler in eventHandlers {
            handler(data)
        }
    }
    
    func raise(for key: String, data: T){
        if let handler = eventHandlersWithKey[key]{
            handler(data)
        }
    }
}

var EventsGlobal = Event<Void>()
