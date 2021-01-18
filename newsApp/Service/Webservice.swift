//
//  Webservice.swift
//  GoodNews
//
//  Created by Cassu on 13/01/21.
//  Copyright © 2021 Cassu. All rights reserved.
//

import Foundation

class Webservice {
    func getHeadlinesNews(_ country: String, completion: @escaping ([New]?) -> ()) {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country.lowercased())&apiKey=\(Key().keyApi())")!
        Alert.loading(isLoading: true)
        URLSession.shared.dataTask(with: url) { data, response, error in
            Alert.loading(isLoading: false)
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                if let newsList: NewsList = data.toModel() {
                    completion(newsList.articles)
                }
            }
        }.resume()
    }
  
}
