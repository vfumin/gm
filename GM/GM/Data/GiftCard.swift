//
//  GiftCard.swift
//  GM
//
//  Created by Fumin Vladimir on 18.06.2018.
//  Copyright © 2018 BeApps. All rights reserved.
//

import Foundation
import EVReflection
class GiftCard: EVObject{
    var id = 0
    var featured = false
    var title = ""
    var credits = 0
    var image_url = ""
    var codes_count = 0
    var currency = ""
    var description_ = ""
    var redeem_url = ""
    
    override func setValue(_ value: Any!, forUndefinedKey key: String) {
        if key == "description", let str = value as? String{
            description_ = str
        }
    }    
}
//"id": 1,
//"featured": false,
//"title": "$10 Amazon.com",
//"credits": 8500,
//"image_url": "http://g-ec2.images-amazon.com/images/G/01/social/api-share/amazon_logo_500500.png",
//"codes_count": 101,
//"currency": "USD",
//"description": "Buy everything from Amazon. It's great.",
//"redeem_url": "http://www.amazon.com"
