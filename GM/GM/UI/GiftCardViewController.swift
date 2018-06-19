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
    
    let contentCard = UIView()
    let cardView = RoundedCardWrapperView()
    let contentView = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gmMainBackground
        
        view.addSubview(visualEffectView)
        
        contentView.numberOfLines = 0
        
        contentCard.backgroundColor = .white
        contentCard.clipsToBounds = true
        
        contentCard.addSubview(contentView)
        contentCard.addSubview(cardView)
        view.addSubview(contentCard)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let bounds = view.bounds
        visualEffectView.frame  = bounds
        contentCard.frame  = bounds
        let m: CGFloat = 20
        let w = bounds.width - m * 2
        cardView.frame = CGRect(x: m, y: 80, width: w, height: w / 1.3)
        contentView.setXY(x: m, y: cardView.frame.maxY + m)
        
    }
}
