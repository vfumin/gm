//
//  ProvidersTableViewCell.swift
//  GM
//
//  Created by Fumin Vladimir on 19.06.2018.
//  Copyright © 2018 BeApps. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ProvidersTableViewCell: UITableViewCell{
    private let title = UILabel()
    private let disposeBag = DisposeBag()
    private var bindingDispose: Disposable? = nil
    private let collectionView: UICollectionView!
    private let leftMargin:CGFloat = 14
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(GiftCardViewCell.self, forCellWithReuseIdentifier: "cell")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        addSubview(collectionView)
        addSubview(title)
        
        title.initLabel(fontSize: 24, color: .darkGray, bold: true)
        
        collectionView.contentInset = UIEdgeInsetsMake(leftMargin, leftMargin, leftMargin, leftMargin)
        
        layout.itemSize = CGSize(width: 200, height: 150)
        
        layout.minimumLineSpacing = leftMargin
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = frame.width
        title.setXY(x: leftMargin, y: leftMargin * 2)
        title.resize(width: w, height: 20)
        collectionView.resize(width: w, height: 180)
        collectionView.setXY(x: 0, y: title.frame.maxY)
        collectionView.reloadData()
    }
    
    public func load(provider: Provider){
        title.text = provider.title
        
        bindingDispose?.dispose()
        
        let items = Observable.just(provider.gift_cards)
        bindingDispose = items.bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: GiftCardViewCell.self))({(row, card, cell) in
            cell.cardView.innerCardView.load(card: card, provider: provider)
        })
        bindingDispose?.disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


