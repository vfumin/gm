//
//  MainViewController.swift
//  GM
//
//  Created by Fumin Vladimir on 18.06.2018.
//  Copyright © 2018 BeApps. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Hero

class ProvidersGiftCardsViewController:UIViewController{
    var providers = Providers()
    private let disposeBag = DisposeBag()
    private var bindingTableDispose: Disposable? = nil
    private var notificationDispose: Disposable? = nil
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        hero.isEnabled = true
        title = "Gift Cards"
               // self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = .gmMainBackground
        tableView.rowHeight = 240
        tableView.separatorStyle = .none
        tableView.register(ProvidersTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.clear
        tableView.frame = self.view.bounds
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(tableView)
    }
    
    var isLoaded = false
    override func viewWillAppear(_ animated: Bool) {
        if !isLoaded{
            debugPrint(providers)
            bindingTableDispose?.dispose()
            let items = Observable.just(providers.providers)
            bindingTableDispose = items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: ProvidersTableViewCell.self))({(row, element, cell) in
                cell.load(provider: element)
            })
            bindingTableDispose?.disposed(by:disposeBag)
            isLoaded = true
        }
        notificationDispose = NotificationCenter.default.rx.notification(.showGiftCard).subscribe(onNext: {notification in
            if let cardView = notification.object as? GiftCardView{
                self.showGiftCard(cardView)
            }
        })
        notificationDispose?.disposed(by: disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        notificationDispose?.dispose()
        notificationDispose = nil
    }
    
    private func showGiftCard(_ cardView: GiftCardView){
        let card = cardView.card
        let cardHeroId = "card\(card.id)"
        cardView.hero.modifiers = [.useNormalSnapshot, .spring(stiffness: 250, damping: 25)]
        cardView.hero.id = cardHeroId
        
        let vc = GiftCardViewController()
        vc.title = card.title
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .none
        
        vc.cardView.hero.id = cardHeroId
        vc.cardView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
        vc.cardView.load(card: card, provider: cardView.provider)
        vc.scrollContainer.hero.modifiers = [.source(heroID: cardHeroId), .spring(stiffness: 250, damping: 25)]
        
        vc.contentView.hero.modifiers = [.useNoSnapshot, .forceAnimate, .spring(stiffness: 250, damping: 25)]
        vc.contentView.setText(cardView.card.description_)
        
        vc.visualEffectView.hero.modifiers = [.fade, .useNoSnapshot]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
