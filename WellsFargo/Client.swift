//
//  API.swift
//  WellsFargo
//
//  Created by Brandon Aubrey on 9/17/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import Foundation

fileprivate var base = "http://"
fileprivate var domain = ""

enum endpoint {
    
}

class Client {
    static let sharedInstance = Client()
    
    func getUser(){
        let myUrl = URL(string: "http://54.191.35.66:8181/pfchang/api/buy?username=Michael&grandTotal=0")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose query string
        
        //url session puts service call on different thread to not lock up ui
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            // You can print out response object
            print("response = \(response)")
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                DispatchQueue.main.async {
                    
                    if let parseJSON = json {
                        //self.LoyaltyPoints.text = String(describing: parseJSON["rewardPoints"]!) + " pts."
                        //get back on main thread
                        DispatchQueue.main.async {
                            //stop rotating spinner
                            //self.activityMonitor.stopAnimating()
                            //self.activityMonitor.isHidden = true
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
