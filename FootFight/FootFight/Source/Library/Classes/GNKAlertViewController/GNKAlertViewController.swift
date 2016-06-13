//
//  GNKAlertViewController.swift
//  FootFight
//
//  Created by Gene on 6/13/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import UIKit

class GNKAlertViewController: UIViewController {
    
    // MARK: - Accessors
    
    var mainView: GNKAlertView? {
        guard let alertView = self.view else {
            return nil
        }
        
        return alertView as? GNKAlertView
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GNKAlertViewController.hide))
        
        self.mainView?.translucentBackgroundView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Public
    
    func hide() -> () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
