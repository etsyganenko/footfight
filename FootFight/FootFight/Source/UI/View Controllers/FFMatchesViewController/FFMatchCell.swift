//
//  FFMatchCell.swift
//  FootFight
//
//  Created by Genek on 6/6/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import UIKit
import CoreData

class FFMatchCell: UITableViewCell {
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Accessors
    
    var matchID: String?
    
    @IBOutlet var matchScoreLabel: UILabel?
    
    @IBOutlet var homeTeamNameLabel: UILabel?
    @IBOutlet var awayTeamNameLabel: UILabel?
    
    @IBOutlet var matchDateLabel: UILabel?
    @IBOutlet var userScoreLabel: UILabel?
    
    @IBOutlet var homeTeamGoalsPredictionButton: UIButton?
    @IBOutlet var awayTeamGoalsPredictionButton: UIButton?
    
    var predictionButtonHandler: (() -> Void)?
    
    // MARK: - Interface Handling
    
    @IBAction func onHomeTeamGoalsPrediction(sender: UIButton) {
        self.showPredictionAlertController()
    }
    
    @IBAction func onAwayTeamGoalsPrediction(sender: UIButton) {
        self.showPredictionAlertController()
    }
    
    // MARK: - Public
    
    func fillWithModel(model: FFMatch) {
        let matchDate = model.matchDate! as NSDate
        
        self.matchID = model.matchID
        
        self.homeTeamNameLabel?.text = model.homeTeamName
        self.awayTeamNameLabel?.text = model.awayTeamName
        
        if -1 != model.homeTeamGoalsPrediction {
            self.homeTeamGoalsPredictionButton?.setTitle(model.homeTeamGoalsPrediction?.stringValue, forState: UIControlState.Normal)
        }
        
        if -1 != model.awayTeamGoalsPrediction {
            self.awayTeamGoalsPredictionButton?.setTitle(model.awayTeamGoalsPrediction?.stringValue, forState: UIControlState.Normal)
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
    
    // MARK: - Private
    
    private func showPredictionAlertController() -> () {
        self.predictionButtonHandler!()
    }
}
