//
//  FFMatchCell.swift
//  FootFight
//
//  Created by Genek on 6/6/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import UIKit
import CoreData

enum FFScorePredictionComponents: Int {
    case homeTeamGoals = 0
    case awayTeamGoals
    case count
}

class FFMatchCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        self.homeTeamGoalsPredictionView?.layer.borderColor = UIColor.blackColor().CGColor
        self.awayTeamGoalsPredictionView?.layer.borderColor = UIColor.blackColor().CGColor
        
        self.homeTeamGoalsPredictionView?.layer.borderWidth = 0.8
        self.awayTeamGoalsPredictionView?.layer.borderWidth = 0.8
    }
    
    // MARK: - Accessors
    
    var matchID: String?
    
    @IBOutlet var matchScoreLabel: UILabel?
    
    @IBOutlet var homeTeamNameLabel: UILabel?
    @IBOutlet var awayTeamNameLabel: UILabel?
    
    @IBOutlet var matchDateLabel: UILabel?
    @IBOutlet var userScoreLabel: UILabel?
    
    @IBOutlet var homeTeamGoalsPredictionView: UIView?
    @IBOutlet var awayTeamGoalsPredictionView: UIView?
    
    @IBOutlet var homeTeamGoalsPredictionButton: UIButton?
    @IBOutlet var awayTeamGoalsPredictionButton: UIButton?
    
    @IBOutlet var homeTeamGoalsPredictionPickerView: UIPickerView!
    
    let predictionOptions = Array(0...9)
    
    // MARK: - Interface Handling
    
    @IBAction func onHomeTeamGoalsPrediction(sender: UIButton) {
        let match = FFMatch.MR_findFirstByAttribute(kFFMatchIDKey, withValue: self.matchID!)! as FFMatch
        
        let homeTeamGoalsPredictionView = self.homeTeamGoalsPredictionView! as UIView
        
        var currentFrame = (homeTeamGoalsPredictionView.frame) as CGRect
        
//        let newY = currentFrame.origin.y as CGFloat
        let newHeight = self.frame.size.height as CGFloat
        
        let newX = currentFrame.origin.x - (newHeight - currentFrame.size.height) as CGFloat
        
        currentFrame.size.width = newHeight
        currentFrame.size.height = newHeight
        currentFrame.origin.x = newX
        
        if match.matchStatus != FFMatchStatus.FFMatchStarted {
            UIView.animateWithDuration(0.1,
                                       delay: 0.0,
                                       options: UIViewAnimationOptions.TransitionNone,
                                       animations: { () -> Void in
                                            self.homeTeamGoalsPredictionView!.frame = currentFrame
                                        },
                                       completion: { (finished: Bool) -> Void in
                                        
            })
        }
    }
    
    @IBAction func onAwayTeamGoalsPrediction(sender: UIButton) {
        
    }
    
    // MARK: - Public
    
    func fillWithModel(model: FFMatch) {
        let matchDate = model.matchDate! as NSDate
        
        self.matchID = model.matchID
        
//        self.scorePredictionPickerView.userInteractionEnabled = matchDate == NSDate().laterDate(matchDate)
//        self.scorePredictionPickerView.userInteractionEnabled = model.matchStatus == FFMatchStatus.FFMatchNotStarted
        
        self.homeTeamNameLabel?.text = model.homeTeamName
        self.awayTeamNameLabel?.text = model.awayTeamName
        
        if -1 != model.homeTeamGoalsPrediction {
            self.homeTeamGoalsPredictionButton?.setTitle(String(model.homeTeamGoalsPrediction?.unsignedIntegerValue), forState: UIControlState.Normal)
        }
        
        if -1 != model.awayTeamGoalsPrediction {
            self.awayTeamGoalsPredictionButton?.setTitle(String(model.awayTeamGoalsPrediction?.unsignedIntegerValue), forState: UIControlState.Normal)
        }
        
//        self.scorePredictionPickerView.selectRow((model.homeTeamGoalsPrediction?.integerValue)!, inComponent: FFScorePredictionComponents.homeTeamGoals.rawValue, animated: false)
//        self.scorePredictionPickerView.selectRow((model.awayTeamGoalsPrediction?.integerValue)!, inComponent: FFScorePredictionComponents.awayTeamGoals.rawValue, animated: false)
        
        self.matchScoreLabel?.text = model.matchScore as String
        self.userScoreLabel?.text = model.userScoreString as String
        
        let dateFormat = "dd.MM  HH:mm"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        self.matchDateLabel?.text = dateFormatter.stringFromDate(matchDate)
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.predictionOptions.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = self.predictionOptions[row]
        
        NSManagedObjectContext.MR_defaultContext().MR_saveWithBlock({ (localContext : NSManagedObjectContext!) in
            let match = FFMatch.MR_findFirstByAttribute(kFFMatchIDKey, withValue: self.matchID!, inContext: localContext)! as FFMatch
            
            switch component {
            case FFScorePredictionComponents.homeTeamGoals.rawValue:
                match.homeTeamGoalsPrediction = selectedValue
            case FFScorePredictionComponents.awayTeamGoals.rawValue:
                match.awayTeamGoalsPrediction = selectedValue
            default:
                break
            }
        })
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = String(self.predictionOptions[row])
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = NSTextAlignment.Center
        paragraphStyle.baseWritingDirection = NSWritingDirection.Natural
        
        return NSAttributedString(string: title, attributes: [NSParagraphStyleAttributeName : paragraphStyle])
    }
    
//    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 20.0;
//    }
//    
//    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return 30.0;
//    }
}
