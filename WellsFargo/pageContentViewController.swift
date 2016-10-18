//
//  PageContentViewController.swift
//  WellsFargo
//
//  Created by Brandon on 10/15/16.
//  Copyright © 2016 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit
import IoniconsSwift

class pageContentViewController: UIViewController{
    
    var pageIndex: Int = 0
    var strPhotoName: String!

    @IBOutlet weak var pageIndicator: UIPageControl!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        var imageView : UIImageView
        let myWidth = self.view.bounds.width
        let myHeight = self.view.bounds.height
        
        arrowIcon.image = Ionicons.arrowRightA.image(30, color: UIColor.white)
//resize each image of pagecontaier
        switch pageIndex {
            
        case 0:
            imageView  = UIImageView(frame:CGRect(x:myWidth/2 - 141, y: myHeight/4 - 100, width: 250, height: 200))
            imageView.layer.shadowColor = UIColor.black.cgColor
            imageView.layer.shadowOpacity = 1
            imageView.layer.shadowOffset = CGSize.zero
            imageView.layer.shadowRadius = 10
            rightButton.isHidden = true
            leftLabel.isHidden = true
            
        case 1:
            imageView  = UIImageView(frame:CGRect(x:myWidth/2 - 141, y: myHeight/4 - 100, width: 250, height: 200))
            rightButton.isHidden = true
            leftLabel.isHidden = true
            
        case 2 :
            imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: myWidth - 32, height: 270))
            rightButton.isHidden = false
            leftLabel.isHidden = false
            
            rightButton.setTitle("Get Tickets >", for: .normal)
            leftLabel.text = "Fashion Show December 1st 2015"
            
        default :
            imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: myWidth - 32, height: 270))
            rightButton.isHidden = false
            leftLabel.isHidden = false
            
            rightButton.setTitle("Book Now >", for: .normal)
            leftLabel.text = "Personal Shopper"
    }

        imageView.image = UIImage(named:strPhotoName)
        self.view.addSubview(imageView)
        self.view.bringSubview(toFront: leftLabel)
        self.view.bringSubview(toFront: rightButton)
        pageIndicator.currentPage = pageIndex
    }
}
