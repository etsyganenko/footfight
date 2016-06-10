//
//  FFMatch+CoreDataProperties.swift
//  FootFight
//
//  Created by Artem on 6/10/16.
//  Copyright © 2016 Genek. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FFMatch {

    @NSManaged var awayTeamGoals: NSNumber?
    @NSManaged var awayTeamName: String?
    @NSManaged var matchDate: NSDate?
    @NSManaged var homeTeamGoals: NSNumber?
    @NSManaged var homeTeamName: String?
    @NSManaged var matchday: NSNumber?
    @NSManaged var matchID: String?
    @NSManaged var homeTeamGoalsPrediction: NSNumber?
    @NSManaged var awayTeamGoalsPrediction: NSNumber?

}
