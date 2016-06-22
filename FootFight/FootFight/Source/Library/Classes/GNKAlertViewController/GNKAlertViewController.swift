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
    var contentViewTapGestureRecognizer: UITapGestureRecognizer?
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translucentBackgroundViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GNKAlertViewController.onTranslucentBackgroundView(_:)))
        let contentViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GNKAlertViewController.onContentView(_:)))
        
        translucentBackgroundViewTapGestureRecognizer.delegate = self
        contentViewTapGestureRecognizer.delegate = self
        
        self.translucentBackgroundViewTapGestureRecognizer = translucentBackgroundViewTapGestureRecognizer
        self.contentViewTapGestureRecognizer = contentViewTapGestureRecognizer
        
        self.mainView?.translucentBackgroundView?.addGestureRecognizer(translucentBackgroundViewTapGestureRecognizer)
        self.mainView?.contentView?.addGestureRecognizer(contentViewTapGestureRecognizer)
    }
    
    // MARK: - Interface Handling
    
    @IBAction func onTranslucentBackgroundView(sender: UITapGestureRecognizer) {
        self.hide()
    }
    
    @IBAction func onContentView(sender: UITapGestureRecognizer) {
        self.hide()
    }
    
    // MARK: - Public
    
    func hide() -> () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
