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
extension UIView {
    func fadeoutVerticaly(label: UILabel) {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.init(white: 0, alpha: 0).cgColor, UIColor.init(white: 1, alpha: 0.8).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.addSublayer(gradient)
        self.addSubview(label)
    }
}
