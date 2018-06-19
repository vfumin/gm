
//
//  UIView.swift
//  GM
//
//  Created by Fumin Vladimir on 19.06.2018.
//  Copyright © 2018 BeApps. All rights reserved.
//

import Foundation
import UIKit

extension UILabel
{
    public func initLabel(fontSize:Float, color:UIColor = UIColor.black, bold:Bool = false, multiLine:Bool = false, fontName:String? = nil)
    {
        self.font = UILabel.createFont(fontSize, bold, fontName)
        self.backgroundColor = UIColor.clear
        self.textColor = color
        if (multiLine)
        {
            self.numberOfLines = 0
            self.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
    }
    
    public func calcAutoSize()
    {
        if (self.text == nil)
        {
            self.resize(height:0)
            return
        }
        let ns = NSString(string: self.text!)
        let sizeLine = ns.size(withAttributes: [NSAttributedStringKey.font: self.font])
        if (self.numberOfLines == 1)
        {
            self.resize(width: sizeLine.width, height: sizeLine.height)
        }
        else {
            let size = ns.boundingRect(with: CGSize(width: self.frame.width, height: CGFloat(Int.max)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: self.font], context: nil)
            let linesHeight = Float(sizeLine.height) * Float(self.numberOfLines)
            if(self.numberOfLines != 0 && linesHeight < Float(self.frame.height))
            {
                self.resize(width: self.frame.width, height: CGFloat(linesHeight))
            }
            else
            {
                self.resize(width: nil, height: size.height)
            }
            
        }
    }
    
    public func setText(_ text:String, autoSize:Bool = true){
        self.text = text
        if autoSize {
            self.calcAutoSize()
        }
    }
    
    public static func createFont(_ size:Float,_ bold:Bool = false,_ fontName:String?) -> UIFont
    {
        let fs = CGFloat(size)
        if (fontName == nil){
            return bold ? UIFont.boldSystemFont(ofSize: fs) : UIFont.systemFont(ofSize: fs)
        }
        let font = UIFont(name: fontName!, size: fs)
        return font ?? (bold ? UIFont.boldSystemFont(ofSize: fs) : UIFont.systemFont(ofSize:fs))
    }
    
    public func setShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 6
    }
}
