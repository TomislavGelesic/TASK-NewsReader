//
//  Extensions+UITableViewCell.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 26/10/2020.
//

import UIKit

extension UITableViewCell: ReusableView {
    static var reusableView: String {
        
        return String(describing: self)
    }
}
