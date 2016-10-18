//
//  mainViewController.swift
//  WellsFargo
//
//  Created by Brandon Aubrey on 10/14/16.
//  Copyright © 2016 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit
import IoniconsSwift

class mainViewController: UIViewController {
    
    @IBOutlet weak var LoyaltyPoints:       UILabel!
    @IBOutlet weak var activityMonitor:     UIActivityIndicatorView!
    @IBOutlet weak var userButton:          UIBarButtonItem!
    @IBOutlet weak var stackButton:         UIBarButtonItem!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var calendarImage: UIImageView!
    @IBOutlet weak var bagImage: UIImageView!
    @IBOutlet weak var coupongImage: UIImageView!
    @IBOutlet weak var trophyImage: UIImageView!
    
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set all ionicons
        userButton.image = Ionicons.person.image(30)
        stackButton.image = Ionicons.drag.image(30)
        cartImage.image = Ionicons.iosCart.image(30, color: UIColor.white)
        bagImage.image = Ionicons.bag.image(30, color: UIColor.white)
        calendarImage.image = Ionicons.calendar.image(30, color: UIColor.white)
        coupongImage.image = Ionicons.pricetag.image(30, color: UIColor.white)
        trophyImage.image = Ionicons.trophy.image(30, color: UIColor.white)
        //start activity monitor while downloading servicecall
        self.activityMonitor.isHidden = false
        self.activityMonitor.startAnimating()
        
        self.getUser()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getUser(){
        
        let myUrl = URL(string: "http://54.191.35.66:8181/pfchang/api/buy?username=Michael&grandTotal=0")
        
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose query string
        
        //url session puts service call on different thread to not lock up ui
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
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
                        self.LoyaltyPoints.text = String(describing: parseJSON["rewardPoints"]!) + " pts."
                        //get back on main thread
                        DispatchQueue.main.async {
                            //stop rotating spinner
                            self.activityMonitor.stopAnimating()
                            self.activityMonitor.isHidden = true
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

