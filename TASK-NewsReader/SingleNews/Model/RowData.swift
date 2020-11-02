//
//  SingleNewsData.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 23/10/2020.
//

import UIKit

struct RowData {
    var type: RowType
    var value: String

    init(type: RowType, string: String) {
        self.type = type
        self.value = string
    }
    
}
