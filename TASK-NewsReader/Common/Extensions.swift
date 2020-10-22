//
//  Extensions.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 22/10/2020.
//

import UIKit

//MARK: Spinner Indicator
var spinnerView : UIView?

extension UIViewController {
    func showSpinner() {
        spinnerView = UIView(frame: self.view.bounds)
        spinnerView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.center = spinnerView!.center
        spinner.startAnimating()
        self.view.addSubview(spinnerView!)
    }
    
    func stopSpinner(){
        spinnerView?.removeFromSuperview()
        spinnerView = nil
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
