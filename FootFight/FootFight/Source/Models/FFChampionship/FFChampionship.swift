//
//  FFChampionship.swift
//  FootFight
//
//  Created by Yevgen on 7/1/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import Foundation
import CoreData


class FFChampionship: NSManagedObject {

    // MARK: - Accessors
    
    var stages: NSArray? {
        return self.stagesSet?.sortedArrayUsingDescriptors([NSSortDescriptor(key: kFFMatchDateKey, ascending: true),
            NSSortDescriptor(key: kFFMatchIDKey, ascending: true)])
    }

}
