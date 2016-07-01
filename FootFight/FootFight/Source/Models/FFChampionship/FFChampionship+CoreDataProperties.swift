//
//  FFChampionship+CoreDataProperties.swift
//  FootFight
//
//  Created by Yevgen on 7/1/16.
//  Copyright © 2016 Genek. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FFChampionship {

    @NSManaged var championshipID: String?
    @NSManaged var name: String?
    @NSManaged var stagesSet: NSSet?

}
