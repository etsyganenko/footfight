//
//  FFPredictionAlertViewController.swift
//  FootFight
//
//  Created by Gene on 6/13/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import UIKit
import CoreData

enum FFScorePredictionComponents: Int {
    case homeTeamGoals = 0
    case awayTeamGoals
    case count
}

class FFPredictionAlertViewController: GNKAlertViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: - Accessors
    
    override var mainView: FFPredictionAlertView? {
        guard let view = self.view else {
            return nil
        }
        
        return view as? FFPredictionAlertView
    }
    
    var matchID: String?
    
    let predictionOptions = Array(0...9)
    
    // MARK: - Class Methods
    
    class func showPredictionAlertOnController(controller: UIViewController,
                                               with model: FFMatch,
                                submitButtonActionHandler: (() -> Void)?)
    {
        let alertController = FFPredictionAlertViewController()
        
        alertController.fillWithModel(model)
        
        alertController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        alertController.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Interface Handling
    
    @IBAction func onSubmit(sender: UIButton) {
        NSManagedObjectContext.MR_defaultContext().MR_saveWithBlock({ (localContext : NSManagedObjectContext!) in
                let match = FFMatch.MR_findFirstByAttribute(kFFMatchIDKey, withValue: self.matchID!, inContext: localContext)! as FFMatch
    
                match.homeTeamGoalsPrediction = self.mainView?.pickerView.selectedRowInComponent(FFScorePredictionComponents.homeTeamGoals.rawValue)
                match.awayTeamGoalsPrediction = self.mainView?.pickerView.selectedRowInComponent(FFScorePredictionComponents.awayTeamGoals.rawValue)
            })
        
        self.hide()
    }
    
    // MARK: - Public
    
    func fillWithModel(model: FFMatch) -> () {
        self.matchID = model.matchID
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return FFScorePredictionComponents.count.rawValue
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.predictionOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = String(self.predictionOptions[row])
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = NSTextAlignment.Center
        paragraphStyle.baseWritingDirection = NSWritingDirection.Natural
        
        return NSAttributedString(string: title, attributes: [NSParagraphStyleAttributeName : paragraphStyle])
    }

}
