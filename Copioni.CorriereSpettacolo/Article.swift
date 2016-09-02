//
//  Article.swift
//  Copioni.CorriereSpettacolo
//
//  Created by Fabio Cipriani on 31/08/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import Foundation
import Alamofire

class Article {
    fileprivate var _id: Int!
    fileprivate var _date: String!
    fileprivate var _title: String!
    fileprivate var _content: String!
    fileprivate var _url: String!
    fileprivate var _author: String!
    fileprivate var _customTags: Dictionary<String, AnyObject>!
    fileprivate var _category: String!
    fileprivate var _copioneURL: String!
    
    var id: Int {
        get {
            return _id
        } set {
            _id = newValue
        }
    }
    
    var date : String {
        get {
            return _date
        } set {
            _date = newValue
        }
    }
    
    var title: String {
        get {
            return _title
        } set {
            _title = newValue
        }
    }
    
    var content: String {
        get {
            return _content
        } set {
            _content = newValue
        }
    }
    
    var url: String {
        get {
            return _url
        } set {
            _url = newValue
        }
    }
    
    var author: String {
        get {
            return _author
        } set {
            _author = newValue
        }
    }
    
    var customTags: Dictionary<String, AnyObject> {
        get {
            return _customTags
        } set {
            _customTags = newValue
        }
    }
    
    var category: String {
        get {
            return _category
        } set {
            _category = newValue
        }
    }
    
    var copioneURL: String {
        get {
            return _copioneURL
        } set {
            _copioneURL = newValue
        }
    }
    
    init() {
        _id = 0
        _date = ""
        _title = ""
        _content = ""
        _url = ""
        _author = ""
        _customTags = Dictionary<String, AnyObject>()
        _category = ""
        _copioneURL = ""
    }
    
    init(id: Int, date: String, title: String, content: String, url: String, author: String, customTags: Dictionary<String, AnyObject>, category: String, copioneURL: String) {
        _id = id
        _date = date
        _title = title
        _content = content
        _url = url
        _author = author
        _customTags = customTags
        _category = category
        _copioneURL = copioneURL
    }
    
    init(postsDict: Dictionary<String, AnyObject>) {
        if let postID = postsDict["id"] as? Int {
            self.id = postID
        }
        if let titolo = postsDict["title"] as? String {
            self.title = titolo
            let range: Range<String.Index> = self.title.range(of: " &#8211; ")!
            self.title = self.title.replacingCharacters(in: Range(uncheckedBounds:(lower: self.title.startIndex, upper: range.upperBound)) , with: "")
        }
        if let postURL = postsDict["url"] as? String {
            self.url = postURL
        }
        if let contenuto = postsDict["content"] as? String {
            self.content = contenuto
        }
        if let data = postsDict["date"] as? String {
            self.date = data
        }
        if let categorie = postsDict["categories"] as? [Dictionary<String, AnyObject>] {
            if let categoria = categorie[0]["title"] as? String {
                self.category = categoria
            }
        }
        if let campiPersonalizzati = postsDict["custom_fields"] as? Dictionary<String, AnyObject> {
            if let autore = campiPersonalizzati["Autore"] as? [String] {
                self.author = autore[0]
            }
        }
        if let customFields = postsDict["custom_fields"] as? Dictionary<String, AnyObject> {
            self.customTags = customFields
        }
        if let attachments = postsDict["attachments"] as? [Dictionary<String, AnyObject>] {
            if let url = attachments[0]["url"] as? String {
                let url2 = url.replacingOccurrences(of: "\\/", with: "/")
                
                _copioneURL = "\(url2)"
                
            }
        }
    }
    
    func DownloadRecentArticlesDetails (completed: DownloadComplete) {
        let articleURL = URL(string: BASE_URL)!
        var recentArticles = [Article]()
        
        Alamofire.request(articleURL, withMethod: .get).responseJSON {
            Response in let result = Response.result
            print(result)
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let posts = dict["posts"] as? [Dictionary<String,AnyObject>] {
                    for post in posts {
                        let article = Article(postsDict: post)
                        recentArticles.append(article)
                    }
                }
            }
            completed(recentArticles)
        }
    }
}

extension Date {
    func DayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
