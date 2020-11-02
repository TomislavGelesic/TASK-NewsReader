//
//  VerticalFadeTextUILabel.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 22/10/2020.
//

import UIKit


class VerticalFadeTextLabel: UILabel {
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.withAlphaComponent(0.6).cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.4)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        layer.insertSublayer(gradient, at: 0)
    }
    
}
