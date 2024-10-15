//
//  TimerQuery.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation

class TimerQuery {
    
    static var shared = TimerQuery()
    private var timers = [String: Timer]()
    private var handlers = [String: ()->Void]()
    private init() {}

    /*
     If timer already exists, it removes it by calling timer.invalidate()
     then creates a new timer associated by id from parameters
     */
    func registerTimer(id: String, interval: TimeInterval, repeats: Bool, block: @escaping ()->Void) {
        if let timer = timers[id] {
            timer.invalidate()
        }
        timers[id] = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(timerEvent(_:)), userInfo: ["id": id], repeats: repeats)
        handlers[id] = block
        
    }
    
    func removeTimer(withId id: String) {
        if let timer = timers[id] {
            timer.invalidate()
            timers.removeValue(forKey: id)
            timers[id] = nil
            handlers[id] = nil
        }
    }
    
    @objc func timerEvent(_ timer: Timer) {
        if let userInfo = timer.userInfo as? [String:String], let id = userInfo["id"] {
            if let handler = handlers[id] {
                handler()
            }
        }
    }
    
    func isTimerRegistered(withId id: String)->Bool {
        if timers[id] != nil {
            return true
        }
        return false
    }
}
