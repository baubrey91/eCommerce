//
//  HamburgerViewController.swift
//  WellsFargo
//
//  Created by Brandon Aubrey on 10/1/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    //----------------------------//
    //MARK:- Variables
    //----------------------------//
    
    static let sharedInstance = UIStoryboard(name: bundle.main, bundle: nil).instantiateViewController(withIdentifier: identifiers.hamburger) as! HamburgerViewController
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leftMargainConstraint: NSLayoutConstraint!
    
    fileprivate var originalLeftMargin: CGFloat!
    
    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            menuView.addSubview(menuViewController.view)
        }
    }
    
    var contentViewController: UIViewController! {
        didSet(oldContentViewController){
            view.layoutIfNeeded()
            
            if oldContentViewController != nil {
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            
            contentViewController.willMove(toParentViewController: self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.leftMargainConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    //var originalLeftMargin: CGFloat!
    fileprivate var openPositionLeftMarginConstant: CGFloat!
    fileprivate var closedPositionLeftMarginConstant: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openPositionLeftMarginConstant = self.view.frame.size.width - 150
        closedPositionLeftMarginConstant = 0
    }
    
    func moveMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [],
                       animations: {
                        if self.leftMargainConstraint.constant == 0 {
                            self.leftMargainConstraint.constant = self.openPositionLeftMarginConstant
                            self.updateRotation(200)
                            
                        } else {
                            self.leftMargainConstraint.constant = self.closedPositionLeftMarginConstant
                            self.contentView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        }
                        self.view.layoutIfNeeded()
        })
    }
    
    fileprivate func updateRotation(_ offset: CGFloat) {
        var transform = CATransform3DIdentity
        let perspective = 250
        transform.m34 = 1.0 / CGFloat(perspective)
        
        let rotation = offset * 20.0 / 320.0
        
        transform = CATransform3DRotate(transform, rotation * CGFloat(M_PI / 180), 0, 1, 0)
        //contentView.layer.transform = transform
        let shrink = CATransform3DScale(transform, 0.80, 0.80, 1)
        CATransform3DConcat(transform, shrink)
        contentView.layer.transform = shrink
        contentView.layer.zPosition = 100
    }
}
