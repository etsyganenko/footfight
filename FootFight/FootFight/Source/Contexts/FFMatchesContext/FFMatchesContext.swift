//
//  FFMatchesContext.swift
//  FootFight
//
//  Created by Genek on 2/25/16.
//  Copyright © 2016 IDAP. All rights reserved.
//

import UIKit
import Alamofire

class FFMatchesContext: FFContext {
    
    // MARK: - Accessors

    // MARK: - Initialization
    
    override init() {
        super.init()
        
        self.path = kFFMatchesPath
        self.url = kFFHost.stringByAppendingString(self.path!)
    }
    
    // MARK: - Public
    
    override func fillModelWithResponse(response: AnyObject) {
        guard let dictionary = response as? NSDictionary else {
            return
        }
        
        guard let matches = dictionary["fixtures"] as? NSArray else {
            return
        }
        
        for match in matches {
            guard let homeTeamName = match["homeTeamName"] else {
                return
            }
            
            guard let awayTeamName = match["awayTeamName"] else {
                return
            }
            
            
        }
    }
    
}
