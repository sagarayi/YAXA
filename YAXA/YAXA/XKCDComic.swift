//
//  XKCDComic.swift
//  YAXA
//
//  Created by Sagar on 15/07/19.
//  Copyright © 2019 Sagar. All rights reserved.
//


//{
//    "month": "1",
//    "num": 10,
//    "link": "",
//    "year": "2006",
//    "news": "",
//    "safe_title": "Pi Equals",
//    "transcript": "Pi = 3.141592653589793helpimtrappedinauniversefactory7108914...",
//    "alt": "My most famous drawing, and one of the first I did for the site",
//    "img": "https://imgs.xkcd.com/comics/pi.jpg",
//    "title": "Pi Equals",
//    "day": "1"
//}


import Foundation

class XKCDComic: Codable {
    var id:Int
    var title:String
    var desc: String
    var altDesc: String
    var imgLink: String
    var day:String
    var month:String
    var year:String
    
      init() {
        id = 0
        title = ""
        desc = ""
        altDesc = ""
        imgLink = ""
        day = ""
        month = ""
        year = ""
    }
    
    private enum CodingKeys : String, CodingKey {
        case id = "num", title = "safe_title", desc =  "transcript", altDesc = "alt", imgLink = "img"
        , day = "day", month = "month", year = "year"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        desc = try container.decode(String.self, forKey: .desc)
        altDesc = try container.decode(String.self, forKey: .altDesc)
        imgLink = try container.decode(String.self, forKey: .imgLink)
        day = try container.decode(String.self, forKey: .day)
        month = try container.decode(String.self, forKey: .month)
        year = try container.decode(String.self, forKey: .year)
    }
}
