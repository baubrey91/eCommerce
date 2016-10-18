//
//  ViewController.swift
//  WellsFargo
//
//  Created by Brandon Aubrey on 10/14/16.
//  Copyright © 2016 Brandon Aubrey. All rights reserved.
//

import UIKit
import LocalAuthentication

class loginViewController: UIViewController {
    var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.var 
    }
    
    func loginButton(_ sender: AnyObject) {
        
        // if using simulator just log in otherwise use fingerprint
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            self.performSegue(withIdentifier: "loginSegue", sender: self)
            
        #else
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Place finger to authenticate"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    [unowned self] (success, authenticationError) in
                    
                    DispatchQueue.main.async {
                        if success {
                            self.performSegue(withIdentifier: "loginSegue", sender: self)
                        } else {
                            let ac = UIAlertController(title: "Authentication failed", message: "Your fingerprint could not be verified; please try again.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(ac, animated: true)
                        }
                    }
                }
            } else {
                let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            }
        #endif
    }
}


