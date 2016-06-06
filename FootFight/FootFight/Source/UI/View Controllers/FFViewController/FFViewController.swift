//
//  FFViewController.swift
//  FootFight
//
//  Created by Genek on 2/3/16.
//  Copyright © 2016 IDAP. All rights reserved.
//

import UIKit

class FFViewController : UIViewController {
    
    // MARK: - Accessors
    
    var context: FFContext? {
        willSet(newValue) {
            newValue!.removeObserver(self)
        }
        didSet(oldValue) {
            context!.addObserver(self)
            
            context!.addHandler(self.contextWillLoadHandler!, state: FFContextState.FFContextWillLoad.rawValue)
            context!.addHandler(self.contextDidLoadHandler!, state: FFContextState.FFContextDidLoad.rawValue)
            context!.addHandler(self.contextDidFailHandler!, state: FFContextState.FFContextDidFail.rawValue)
            
            context!.execute()
        }
    }
    
    var contextWillLoadHandler: FFNotificationHandler! {
        get {
            return {}
        }
        set(newValue) {}
    }
        
    var contextDidLoadHandler: FFNotificationHandler! {
        get {
            return {}
        }
        set(newValue) {}
    }
        
    var contextDidFailHandler: FFNotificationHandler! {
        get {
            return {}
        }
        set(newValue) {}
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBarHidden = true
    }
    
}
