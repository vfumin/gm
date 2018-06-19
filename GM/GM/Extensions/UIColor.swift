//
//  UIColor.swift
//  GM
//
//  Created by Fumin Vladimir on 19.06.2018.
//  Copyright © 2018 BeApps. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    public static func getColor(_ r:Int, _ g:Int, _ b:Int, a:Int = 255)->UIColor{
        let c:CGFloat = 255
        return UIColor(red: CGFloat(r)/c, green: CGFloat(g)/c, blue: CGFloat(b)/c, alpha: CGFloat(a)/c)
    }
    
    public static let gmMainBackground = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)
    
}
