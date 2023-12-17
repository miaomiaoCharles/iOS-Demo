//
//  viewModel.swift
//  demolqc
//
//  Created by ByteDance on 2023/12/14.
//

import Foundation
import ObjectMapper

class ViewModel {
    
    init() { }
    
    var currentPageIndex = 0 {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("currentPage"), object: nil, userInfo: [currentPageIndex: oldValue])
        }
                                            
    }

                                            
}
