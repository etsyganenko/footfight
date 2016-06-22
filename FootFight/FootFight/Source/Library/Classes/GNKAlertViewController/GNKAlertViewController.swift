//
//  GNKAlertViewController.swift
//  FootFight
//
//  Created by Gene on 6/13/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import UIKit

class GNKAlertViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Accessors
    
    var mainView: GNKAlertView? {
        guard let alertView = self.view else {
            return nil
        }
        
        return alertView as? GNKAlertView
    }
    
    var translucentBackgroundViewTapGestureRecognizer: UITapGestureRecognizer?
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let translucentBackgroundViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GNKAlertViewController.tapBackgroundView(_:)))
//        translucentBackgroundViewTapGestureRecognizer.delegate = self
//        self.translucentBackgroundViewTapGestureRecognizer = translucentBackgroundViewTapGestureRecognizer
        
//        let contentViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GNKAlertViewController.tapContentView(_:)))
//        contentViewTapGestureRecognizer.delegate = self
//        contentViewTapGestureRecognizer.enabled = true
//        self.contentViewTapGestureRecognizer = contentViewTapGestureRecognizer
        
//        self.mainView?.translucentBackgroundView?.addGestureRecognizer(translucentBackgroundViewTapGestureRecognizer)
//        self.mainView?.contentView?.addGestureRecognizer(contentViewTapGestureRecognizer)
    }
    
    // MARK: - Public
    
    @IBAction func tapBackgroundView(sender: UITapGestureRecognizer) -> () {
        self.hide()
    }
    
    func hide() -> () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
