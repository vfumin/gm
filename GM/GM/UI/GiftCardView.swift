//
//  GiftCardView.swift
//  GM
//
//  Created by Fumin Vladimir on 19.06.2018.
//  Copyright © 2018 BeApps. All rights reserved.
//

import Foundation
import UIKit
import Hero
import AlamofireImage

class GiftCardView: UIView {
    var card = GiftCard()
    var provider = Provider()
    
    let costLabel = UILabel()
    let creditsLabel = UILabel()
    let coinsLabel = UILabel()
    let imageView = UIImageView()
    let bottom = UIView()
    let preloader = UIActivityIndicatorView()
    let format = NumberFormatter()
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white //UIColor.getColor(245, 244, 242)
        clipsToBounds = true
        
        costLabel.initLabel(fontSize: 20, color: .darkGray, bold: true)
        creditsLabel.initLabel(fontSize: 20, color: .white, bold: true)
        coinsLabel.initLabel(fontSize: 15, color: UIColor.white.withAlphaComponent(0.8), bold: true)
        coinsLabel.setText("coins")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.clear
        
        preloader.hidesWhenStopped = true
        
        addViews(bottom, imageView, costLabel, creditsLabel, coinsLabel, preloader)
    }
    
    public func load(card: GiftCard, provider: Provider){
        self.card = card
        self.provider = provider
        
        bottom.backgroundColor = provider.id == 1 ?  UIColor.getColor(253, 174, 68) : UIColor.getColor(44, 53, 58)
        
        let strs = card.title.split(separator: " ")
        if let f = strs.first{
            costLabel.setText(String(f))
        }
        format.currencyCode  = card.currency
        
        creditsLabel.setText(format.string(from: NSNumber(value: card.credits)) ?? "")
        
        if let url = URL(string: card.image_url){
            imageView.af_cancelImageRequest()
            preloader.startAnimating()
            imageView.af_setImage(withURL: url, imageTransition: .crossDissolve(0.1), completion: { _ in
                self.preloader.stopAnimating()
            })
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = bounds.width
        let h = bounds.height
        let th = h - bottom.frame.height
        imageView.resize(width: w/2, height: h/3)
        
        bottom.resize(width: w, height: h*0.3)
        bottom.alignToBottom()
        
        imageView.setXY(x: 20, y: (th - imageView.frame.height) / 2)
        
        costLabel.setXY(x: w/1.5, y: (th - costLabel.frame.height) / 2)
        creditsLabel.setXY(x: 20, y: bottom.frame.minY + 10)
        coinsLabel.setXY(x: creditsLabel.frame.maxX + 4, y: creditsLabel.frame.maxY - coinsLabel.frame.height)
    }
}

class RoundedCardWrapperView: UIView {
    let cardView = GiftCardView()
    
    var isTouched: Bool = false {
        didSet {
            var transform = CGAffineTransform.identity
            if isTouched { transform = transform.scaledBy(x: 0.96, y: 0.96) }
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                self.transform = transform
            }, completion: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    override init(frame: CGRect) {
        super.init(frame: frame)
        cardView.layer.cornerRadius = 14
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
        addSubview(cardView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if cardView.superview == self {
            // this is necessary because we used `.useNoSnapshot` modifier on cardView.
            // we don't want cardView to be resized when Hero is using it for transition
            cardView.frame = bounds
        }
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isTouched = true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isTouched = false
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isTouched = false
    }
}
