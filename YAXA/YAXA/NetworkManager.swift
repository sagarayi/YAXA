//
//  NetworkManager.swift
//  YAXA
//
//  Created by Sagar on 15/07/19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation

public enum HTTPRequestMethod:String
{
    case get = "GET"
    case put = "PUT"
    case post = "POST"
}

let comicFetchingURL = "http://xkcd.com/"
let additionalParam = "info.0.json"

class NetworkManager: NSObject {
    func fetchImageForId(imageID:String,requestMethod: HTTPRequestMethod, completionHandler: @escaping (_ comicData:XKCDComic?, _ response: URLResponse?, _ error:Error? ) -> () ) {
        
        let finalURL = URL(string: comicFetchingURL+imageID+additionalParam)
        var request = URLRequest(url: finalURL!)
        request.httpMethod = requestMethod.rawValue
        
        let requestTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do
            {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(XKCDComic.self, from: data!)
                print(decoded)
                completionHandler(decoded,response, error)
            }
            catch
            {
                print("Error decoding JSON")
                completionHandler(nil,response, error)
            }
        }
        requestTask.resume()
    }
}

