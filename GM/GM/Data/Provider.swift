//
//  Provider.swift
//  GM
//
//  Created by Fumin Vladimir on 18.06.2018.
//  Copyright © 2018 BeApps. All rights reserved.
//

import Foundation
import EVReflection

class Provider: EVObject{
    var id = 0
    var title = ""
    var image_url = ""
    var gift_cards = [GiftCard]()
}
//"id": 1,
//"title": "Amazon.com",
//"image_url": "http://g-ec2.images-amazon.com/images/G/01/social/api-share/amazon_logo_500500.png",
//"gift_cards": [
//{
//"id": 1,
//"featured": false,
//"title": "$10 Amazon.com",
//"credits": 8500,
//"image_url": "http://g-ec2.images-amazon.com/images/G/01/social/api-share/amazon_logo_500500.png",
//"codes_count": 101,
//"currency": "USD",
//"description": "Buy everything from Amazon. It's great.",
//"redeem_url": "http://www.amazon.com"
//},
//{
//"id": 2,
//"featured": false,
//"title": "$20 Amazon.com",
//"credits": 15000,
//"image_url": "http://g-ec2.images-amazon.com/images/G/01/social/api-share/amazon_logo_500500.png",
//"codes_count": 4,
//"currency": "USD",
//"description": "Buy everything from Amazon. It's great.",
//"redeem_url": "http://www.amazon.com"
//}
