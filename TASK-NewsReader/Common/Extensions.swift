//
//  Extensions.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 22/10/2020.
//

import UIKit

//MARK: Spinner Indicator
let spinnerView = SpinnerView()
extension UIViewController {
    
    func showSpinner() {
        view.addSubview(spinnerView)
        spinnerView.center = view.center
        spinnerView.startSpinner()
    }
    
    func hideSpinner() {
        spinnerView.stopSpinner()
        spinnerView.removeFromSuperview()
    }
}

// MARK: UIImage from URL_ToImage
extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        do {
            self.init(data: try Data(contentsOf: url))
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}

//MARK: Text Gradient

class VerticalFadeTextUILabel: UILabel {
    override open func layoutSubviews() {
        super.layoutSubviews()
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.6)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        layer.insertSublayer(gradient, at: 0)
    }
    
}
