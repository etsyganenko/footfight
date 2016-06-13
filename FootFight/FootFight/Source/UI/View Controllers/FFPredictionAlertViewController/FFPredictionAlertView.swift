//
//  FFPredictionAlertView.swift
//  FootFight
//
//  Created by Gene on 6/13/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import UIKit

class FFPredictionAlertView: GNKAlertView {

    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var submitButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView?.layer.cornerRadius = 0.5
    }

}
