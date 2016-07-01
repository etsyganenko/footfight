//
//  FFMatch+CoreDataProperties.swift
//  FootFight
//
//  Created by Artem on 6/24/16.
//  Copyright © 2016 Genek. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FFMatch {

    @NSManaged var awayTeamGoals: NSNumber?
    @NSManaged var awayTeamGoalsPrediction: NSNumber?
    @NSManaged var awayTeamName: String?
    @NSManaged var homeTeamGoals: NSNumber?
    @NSManaged var homeTeamGoalsPrediction: NSNumber?
    @NSManaged var homeTeamName: String?
    @NSManaged var matchDate: NSDate?
    @NSManaged var matchday: NSNumber?
    @NSManaged var matchID: String?
    @NSManaged var stage: FFStage?

}
