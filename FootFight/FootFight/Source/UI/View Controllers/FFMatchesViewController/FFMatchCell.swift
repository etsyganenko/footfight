//
//  FFMatchCell.swift
//  FootFight
//
//  Created by Artem on 6/6/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import UIKit

class FFMatchCell: UITableViewCell {
    
    // MARK: - Accessors
    
    var match: FFMatch!
    
    @IBOutlet var homeTeamNameLabel: UILabel?
    @IBOutlet var awayTeamNameLabel: UILabel?
    
    @IBOutlet var homeTeamGoalsLabel: UILabel?
    @IBOutlet var awayTeamGoalsLabel: UILabel?
    
    @IBOutlet var homeTeamGoalsPredictionLabel: UILabel?
    @IBOutlet var awayTeamGoalsPredictionLabel: UILabel?
    
    @IBOutlet var scoreLabel: UILabel?
    
    func fillWithModel(model: FFMatch) {
        self.homeTeamNameLabel?.text = model.homeTeamName
        self.awayTeamNameLabel?.text = model.awayTeamName
    }
    
}
