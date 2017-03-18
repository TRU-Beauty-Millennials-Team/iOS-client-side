//
//  Server.swift
//  TruNarutoClient
//
//  Created by Nurlan on 18/03/2017.
//  Copyright © 2017 Nurlan. All rights reserved.
//

import Foundation

/**
    Main class that sends requests to the remote server.
 **/
class Server {

    private init() {
    }

    private static var rootURL = URL(string: "http://212.19.138.142:3000")!
    private static var request : NSMutableURLRequest = NSMutableURLRequest()

    public static func sendRequest(pathURL: String, parameters: [String: AnyObject], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let parameterString = parameters.stringFromHttpParameters()
        let requestURL = URL(string:"\(Server.rootURL)/\(pathURL)?\(parameterString)")!
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }

    public static func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }

}
