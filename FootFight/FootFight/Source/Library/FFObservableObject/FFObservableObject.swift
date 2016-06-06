//
//  FFObservableObject.swift
//  FootFight
//
//  Created by Genek on 2/23/16.
//  Copyright © 2016 IDAP. All rights reserved.
//

import UIKit

typealias FFNotificationHandler = () -> ()

class FRVObservableObject: NSObject {
    
    // MARK: - Accessors
    
    var state: UInt {
        willSet(newValue) {
            self.notifyOfStateChange(newValue)
        }
    }
    
    var handlersDictionary: Dictionary<UInt, FFNotificationHandler>!
    
    var observersHashTable: NSHashTable?
    
    // MARK: - Initialization
    
    override init() {
        self.state = 0
        self.observersHashTable = NSHashTable.weakObjectsHashTable()
        self.handlersDictionary = Dictionary()
        
        super.init()
    }
    
    // MARK: - Public
    
    func addObserver(observer: AnyObject) {
        self.observersHashTable!.addObject(observer)
    }
    
    func removeObserver(observer: AnyObject) {
        self.observersHashTable!.removeObject(observer)
    }
    
    func notifyOfStateChange(state: UInt) {
        self.notifyOfStateChangeWithHandler(self.handlerForState(state)!)
    }
    
    func addHandler(handler: FFNotificationHandler, state: UInt) {
        self.handlersDictionary![state] = handler
    }
    
    func removeHandler(handler: FFNotificationHandler, state: UInt) {
        self.handlersDictionary!.removeValueForKey(state)
    }
    
    // MARK: - Private
    
    private func handlerForState(state: UInt) -> FFNotificationHandler? {
        return self.handlersDictionary![state]
    }
    
    private func notifyOfStateChangeWithHandler(handler: FFNotificationHandler) {
        handler()
    }
}

