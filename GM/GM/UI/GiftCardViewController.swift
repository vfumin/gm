//
//  GiftCardViewController.swift
//  GM
//
//  Created by Fumin Vladimir on 19.06.2018.
//  Copyright © 2018 BeApps. All rights reserved.
//

import Foundation
import UIKit
import Hero

class GiftCardViewController: UIViewController{
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let scrollContainer = UIScrollView()
    let cardView = GiftCardView(costFontSize: 36, creditsFontSize: 36, coinsFontSize: 26)
    let contentView = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gmMainBackground
        
        view.addSubview(visualEffectView)
        
        contentView.numberOfLines = 0
        contentView.backgroundColor = UIColor.clear
        
        scrollContainer.backgroundColor = UIColor.clear
        scrollContainer.addSubview(contentView)
        scrollContainer.addSubview(cardView)
        view.addSubview(scrollContainer)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let bounds = view.bounds
        visualEffectView.frame  = bounds
        scrollContainer.frame = bounds
        let m: CGFloat = 20
        let w = bounds.width - m * 2
        cardView.frame = CGRect(x: m, y: 80, width: w, height: w / 1.3)
        contentView.setXY(x: m, y: cardView.frame.maxY + m)
        scrollContainer.contentSize = CGSize(width: bounds.width, height: contentView.frame.maxY + m)
    }
}
