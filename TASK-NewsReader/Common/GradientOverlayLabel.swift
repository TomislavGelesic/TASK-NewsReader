//
//  GradientOverlayLabell.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 02/11/2020.
//

import UIKit

class GradientOverlayLabel: UILabel {
    
    var gradient = CAGradientLayer()
    
    func addGradientLayer(frame: CGRect, colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint, locations: [NSNumber] ) {
        
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.locations = locations
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
}
