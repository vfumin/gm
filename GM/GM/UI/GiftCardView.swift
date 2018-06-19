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
    
    private let costLabel = UILabel()
    private let creditsLabel = UILabel()
    private let coinsLabel = UILabel()
    private let imageView = UIImageView()
    private let bottom = UIView()
    private let preloader = UIActivityIndicatorView()
    private let format = NumberFormatter()
    
    private let container = UIView()
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    init(costFontSize: Float = 20, creditsFontSize: Float = 20, coinsFontSize: Float = 15) {
        super.init(frame: CGRect.zero)
        backgroundColor = .clear
        
        costLabel.initLabel(fontSize: costFontSize, color: .darkGray, bold: true)
        creditsLabel.initLabel(fontSize: creditsFontSize, color: .white, bold: true)
        coinsLabel.initLabel(fontSize: coinsFontSize, color: UIColor.white.withAlphaComponent(0.8), bold: true)
        coinsLabel.setText("coins")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.clear
        
        preloader.hidesWhenStopped = true
        
        container.frame = bounds
        container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        container.translatesAutoresizingMaskIntoConstraints = true
        container.addViews(bottom, imageView, costLabel, creditsLabel, coinsLabel, preloader)
        add(container)
        
        container.backgroundColor = .white //UIColor.getColor(245, 244, 242)
        container.clipsToBounds = true
        container.layer.cornerRadius = 14
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
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
        imageView.resize(width: w/2, height: h/3)
        
        bottom.resize(width: w, height: h*0.3)
        bottom.alignToBottom()
        
        let th = h - bottom.frame.height
        imageView.setXY(x: 20, y: (th - imageView.frame.height) / 2)
        
        costLabel.setXY(x: w/1.5, y: (th - costLabel.frame.height) / 2)
        creditsLabel.setXY(x: 20, y: bottom.frame.minY + 10)
        coinsLabel.setXY(x: creditsLabel.frame.maxX + 4, y: creditsLabel.frame.maxY - coinsLabel.frame.height)
    }
}

class CardWrapperView: UIView {
    let innerCardView = GiftCardView()
    
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
        
        addSubview(innerCardView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if innerCardView.superview == self {
            // this is necessary because we used `.useNoSnapshot` modifier on cardView.
            // we don't want cardView to be resized when Hero is using it for transition
            innerCardView.frame = bounds
        }
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
