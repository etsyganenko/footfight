//
//  FFMatchesViewController.swift
//  FootFight
//
//  Created by Artem on 6/6/16.
//  Copyright © 2016 Genek. All rights reserved.
//

class FFMatchesViewController: FFViewController {
    
    // MARK: - Accessors
    
    var mainView: FFMatchesView? {
        guard let matchesView = self.view else {
            return nil
        }
        
        return matchesView as? FFMatchesView
    }
    
    override var contextWillLoadHandler: FFNotificationHandler! {
        get {
            return {
                print("context Will Load")
            }
        }
        set(newValue) {}
    }
    
    override var contextDidLoadHandler: FFNotificationHandler! {
        get {
            return {
                
            }
        }
        set(newValue) {}
    }
    
    override var contextDidFailHandler: FFNotificationHandler! {
        get {
            return {
                print("context Did Fail")
            }
        }
        set(newValue) {}
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.context = FFMatchesContext()
    }
    
    // MARK: - User Interaction
    
    // MARK: - Public
    
}
