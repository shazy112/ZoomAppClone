//
//  BorderedButton.swift
//
//  Created by Invision on 13/10/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet {
            layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
