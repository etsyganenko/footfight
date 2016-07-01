//
//  FFContext.swift
//  FootFight
//
//  Created by Genek on 2/23/16.
//  Copyright © 2016 IDAP. All rights reserved.
//

import UIKit
import Alamofire

enum FFContextState: UInt {
    case FFContextStateNone = 0
    case FFContextWillLoad
    case FFContextDidLoad
    case FFContextDidFail
}

class FFContext: FRVObservableObject {
    
    // MARK: - Initialization
    
    init(model: AnyObject?) {
        self.model = model
        
        super.init()
    }
    
    // MARK: - Accessors

    var model: AnyObject?
    
    var url: String?
    var path: String?
    
    // MARK: - Public
    
    func execute() {
        let headers = ["X-Auth-Token": kFFAPIToken]
        
        Alamofire.request(.GET, self.url!, headers: headers).responseJSON { response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                self.fillModelWithResponse(JSON)
                self.state = FFContextState.FFContextDidLoad.rawValue
            }
        }
    }

    func fillModelWithResponse(response: AnyObject) {
        
    }
}
