//
//  UIView.swift
//  GM
//
//  Created by Fumin Vladimir on 19.06.2018.
//  Copyright © 2018 BeApps. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    public func add(_ view:UIView){
        addSubview(view)
    }
    
    public func addViews(_ views:UIView...){
        addViews(views)
    }
    
    public func addViews(_ views:[UIView]){
        views.forEach({
            add($0)
        })
    }
    
    
    public func resize(width:CGFloat? = nil, height:CGFloat? = nil)
    {
        if width != nil{
            self.frame.size.width = (width!);
        }
        if height != nil{
            self.frame.size.height = (height!);
        }
    }
    
    public func resize(_ view:UIView)
    {
        self.frame.size.width = view.frame.width;
        self.frame.size.height = view.frame.height;
    }
    
    public func alignToRight(_ margin:CGFloat = 0){
        if superview != nil{
            self.setXY(x: superview!.frame.width-self.frame.width - margin, y: nil)
        }
    }
    
    public func alignToRight(_ margin:CGFloat = 0, view: UIView){
        if superview != nil{
            self.setXY(x: view.frame.minX - self.frame.width - margin, y: nil)
        }
    }
    
    public func alignToBottom(_ margin:CGFloat = 0){
        if superview != nil{
            self.setXY(x: nil, y: superview!.frame.height-self.frame.height - margin)
        }
    }
    
    public func setXY(x:CGFloat? = nil, y:CGFloat? = nil)
    {
        if x != nil{
            self.frame.origin.x = x!;
        }
        if y != nil{
            self.frame.origin.y = y!;
        }
        
    }
    
}
