//
//  GiftCardViewCell.swift
//  GM
//
//  Created by Fumin Vladimir on 19.06.2018.
//  Copyright © 2018 BeApps. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxGesture
class GiftCardViewCell: UICollectionViewCell{
    let cardView = CardWrapperView()
    private let disposeBag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView)
        cardView.rx.tapGesture().when(.recognized).subscribe(onNext: {_ in
            NotificationCenter.default.post(name: .showGiftCard, object: self.cardView.innerCardView)
        }).disposed(by: disposeBag)
        cardView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
