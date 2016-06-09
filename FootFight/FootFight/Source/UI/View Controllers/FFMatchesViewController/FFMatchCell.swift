//
//  FFMatchCell.swift
//  FootFight
//
//  Created by Genek on 6/6/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import UIKit

enum FFScorePredictionComponents: Int {
    case homeTeamGoals = 0
    case awayTeamGoals
    case count
}

class FFMatchCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Accessors
    
    var model: FFMatch!
    
    @IBOutlet var matchScoreLabel: UILabel?
    
    @IBOutlet var homeTeamNameLabel: UILabel?
    @IBOutlet var awayTeamNameLabel: UILabel?
    
    @IBOutlet var matchDateLabel: UILabel?
    @IBOutlet var userScoreLabel: UILabel?
    
    @IBOutlet var scorePredictionPickerView: UIPickerView!
    
    let predictionOptions = Array(0...9)
    
    // MARK: - Public
    
    func fillWithModel(model: FFMatch) {
        self.model = model
        
        self.homeTeamNameLabel?.text = model.homeTeamName
        self.awayTeamNameLabel?.text = model.awayTeamName
        
        self.scorePredictionPickerView.selectRow((model.homeTeamGoalsPrediction?.integerValue)!, inComponent: FFScorePredictionComponents.homeTeamGoals.rawValue, animated: false)
        self.scorePredictionPickerView.selectRow((model.awayTeamGoalsPrediction?.integerValue)!, inComponent: FFScorePredictionComponents.awayTeamGoals.rawValue, animated: false)
        
        self.matchScoreLabel?.text = model.matchScore
        self.userScoreLabel?.text = model.userScoreString
        
        let dateFormat = "dd.MM  HH:mm"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        self.matchDateLabel?.text = dateFormatter.stringFromDate(model.matchDate!)
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return FFScorePredictionComponents.count.rawValue
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.predictionOptions.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let model = self.model as FFMatch
        let selectedValue = self.predictionOptions[row]
        
        switch component {
            case FFScorePredictionComponents.homeTeamGoals.rawValue:
                model.homeTeamGoalsPrediction = selectedValue
            case FFScorePredictionComponents.awayTeamGoals.rawValue:
                model.awayTeamGoalsPrediction = selectedValue
            default:
                break
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = String(self.predictionOptions[row])
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = /*FFScorePredictionComponents.homeTeamGoals.rawValue == component ? NSTextAlignment.Right : NSTextAlignment.Left*/NSTextAlignment.Center
        paragraphStyle.baseWritingDirection = NSWritingDirection.Natural
        
        return NSAttributedString(string: title, attributes: [NSParagraphStyleAttributeName : paragraphStyle])
    }
}
