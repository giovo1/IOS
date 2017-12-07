//
//  News.swift
//  NYTimesApp
//
//  Created by Giovanny Rocha on 11/22/17.
//  Copyright © 2017 Giovanny Rocha. All rights reserved.
//

import Foundation

class News {
    var id:String?
    var headLine:String
    var snippet:String
    var pubDate:String
    var source:String
    var urlImageXLarge:String
    var urlImageThumbnail:String

    init?(id:String, headLine:String, snippet:String, pubDate:String, source:String, urlImageXLarge:String, urlImageThumbnail:String){
        self.id = id
        self.headLine = headLine
        self.snippet = snippet
        self.pubDate = pubDate
        self.source = source
        self.urlImageXLarge = urlImageXLarge
        self.urlImageThumbnail = urlImageThumbnail
        
        // contructor Validatio
        if(headLine.isEmpty){
            // nil = null
            return nil
        }
    }
}
