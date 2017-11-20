//
//  MenuViewController.swift
//  HamburgerMenu
//
//  Created by Brandon on 4/17/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var homeNavController: UIViewController!
    private var blueNavigationController: UIViewController!
    private var pinkNavigationController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    var hamburgerViewController: HamburgerViewController!
    
    let titles = ["Store", "Log Out", "About"]

    override func viewDidLoad() {
        super.viewDidLoad()

        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        greenNavigationController = storyboard.instantiateViewController(withIdentifier: "ShoppingNavigationController")
        blueNavigationController = storyboard.instantiateViewController(withIdentifier: "BlueNavigationController")
        pinkNavigationController = storyboard.instantiateViewController(withIdentifier: "PinkNavigationController")
        
        viewControllers.append(greenNavigationController)
        viewControllers.append(blueNavigationController)
        viewControllers.append(pinkNavigationController)
        
        hamburgerViewController.contentViewController = greenNavigationController*/
        
        let homeStoryboard = UIStoryboard(name: "Main", bundle: nil)
        homeNavController = homeStoryboard.instantiateViewController(withIdentifier: "ShoppingNavigationController") as! UINavigationController
        viewControllers.append(homeNavController)
        hamburgerViewController.contentViewController = homeNavController
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
        UIView.animate(withDuration: 0.5, delay: 0, options: [],
                       animations: {
                        self.hamburgerViewController.contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / CGFloat(titles.count)
    }
}

