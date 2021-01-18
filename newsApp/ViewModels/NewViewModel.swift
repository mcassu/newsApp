//
//  ArticleViewModel.swift
//  GoodNews
//
//  Created by Cassu on 13/01/21.
//  Copyright © 2021 Cassu. All rights reserved.
//

import Foundation
import UIKit

struct NewListViewModel {
    let news: [New]
}

extension NewListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.news.count
    }
    
    func newAtIndex(_ index: Int) -> NewViewModel {
        let new = self.news[index]
        return NewViewModel(new)
    }
    
}

struct NewViewModel {
    private let new: New
}

extension NewViewModel {
    init(_ new: New) {
        self.new = new
    }
}

extension NewViewModel {
    
    var title: String {
        return self.new.title
    }
    
    var description: String {
        return self.new.description ?? ""
    }
    
    var date: String{
        var resultDateFormat = ""
        
        let dateFormatterStart = DateFormatter()
        dateFormatterStart.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.dateFormat = "dd MMM yyyy, HH:mm"
        
        if let date = dateFormatterStart.date(from: self.new.publishedAt ?? "") {
            resultDateFormat = "\(dateFormatterResult.string(from: date))"
        } else {
            resultDateFormat = "Data inválida"
        }
        return resultDateFormat
    }
    
    var urlToImage: URL? {
        guard let urlString = self.new.urlToImage else {
            return nil
        }
        return URL(string: urlString)
    }
    
    var urlNews: URL? {
        guard let urlString = self.new.url else {
            return nil
        }
        return URL(string: urlString)
    }
}

