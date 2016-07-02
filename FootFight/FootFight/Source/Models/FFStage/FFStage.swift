//
//  FFStage.swift
//  FootFight
//
//  Created by Artem on 6/24/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import Foundation
import CoreData


class FFStage: NSManagedObject {

    // MARK: - Accessors
    
    var matches: NSArray? {
        return self.matchesSet?.sortedArrayUsingDescriptors([NSSortDescriptor(key: kFFMatchDateKey, ascending: true)])
    }

}
