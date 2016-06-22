//
//  GNKCircleView.swift
//  FootFight
//
//  Created by Artem on 6/21/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import UIKit

class GNKCircleView: UIView {

    var path: UIBezierPath?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.path = UIBezierPath(ovalInRect: self.bounds)
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return !self.path!.containsPoint(point)
    }
}
