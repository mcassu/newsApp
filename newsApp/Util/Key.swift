//
//  Key.swift
//  newsApp
//
//  Created by Cassu on 13/01/21.
//  Copyright © 2021 Cassu. All rights reserved.
//

import Foundation
import UIKit

class Key {
    
    private let apiKey: String = "" //PUT-YOUR-KEY-HERE
    
    static let shared: Key = Key()

    func keyApi() -> String {
        return apiKey
    }
    
    func canApiKey(){
        if apiKey.isEmpty {
            fatalError("Please go to https://newsapi.org/ and get your key \n*It's very easy*")
        }
    }
}
