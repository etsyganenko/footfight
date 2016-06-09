//
//  FFUser.swift
//  FootFight
//
//  Created by Artem on 6/9/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import Foundation
import CoreData

@objc(FFUser)
class FFUser: NSManagedObject {
    
    func totalScore() -> UInt {
        var result: UInt = 0;
        let matches = FFMatch.MR_findAll()
        
        for match in matches! {
            let matchModel = match as! FFMatch
            result += matchModel.userScore
        }
        
        return result
    }
}
