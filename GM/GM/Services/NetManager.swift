//
//  NetManager.swift
//  GM
//
//  Created by Fumin Vladimir on 18.06.2018.
//  Copyright © 2018 BeApps. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

class NetManager{
    private let host = "http://mobile-hr.de02.agima.ru/"
    private lazy var apiUrl = "\(self.host)exam/"
    static let shared = NetManager()
    
    private init(){
        
    }
    
    public func getProviders()->Observable<Providers>{
        return string(.get, self.apiUrl + "providers.json").map { strResponse -> Providers in
            return Providers(json: strResponse)
        }
    }
}
