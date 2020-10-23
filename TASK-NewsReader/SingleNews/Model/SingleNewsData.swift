//
//  SingleNewsData.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 23/10/2020.
//

import UIKit

class SingleNewsData {
    
    //MARK: Properties
    enum rowType {
        case image
        case title
        case content
    }
    
    struct rowData {
        var type: rowType
        var value: String
    }

    var item: rowData
    
    //MARK: init
    init(type: rowType, string: String) {
        item = rowData.init(type: type, value: string)
    }
    
    required init?(coder: NSCoder) {
        fatalError("SingleNewsData required init?(coder: NSCoder) has not been implemented")
    }
}
