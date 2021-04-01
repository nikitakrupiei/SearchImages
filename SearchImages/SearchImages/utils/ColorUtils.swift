//
//  ColorUtils.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation
import UIKit

enum AppColor: String {
    
    case mainAppColor
    case separatorColor
    
    func color() -> UIColor {
        guard let color = UIColor(named: self.rawValue) else {
            return defaultColor
        }
        return color
    }
    
    func cgColor() -> CGColor {
        return self.color().cgColor
    }
    
    private var defaultColor: UIColor {
        switch self {
        case .mainAppColor:
            return #colorLiteral(red: 0, green: 0.6156862745, blue: 1, alpha: 1)
        case .separatorColor:
            return #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        }
    }
}
