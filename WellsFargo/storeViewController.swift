//
//  storeViewController.swift
//  WellsFargo
//
//  Created by Brandon Aubrey on 10/15/16.
//  Copyright © 2016 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit
import IoniconsSwift
import MIBadgeButton_Swift

class storeViewController: UIViewController {
//array of items
    let itemArray = [
        storeItem(itemImage: UIImage(named: "redShoes.png")!,           itemCost: 49.95, itemDesc: "Sneakers A"),
        storeItem(itemImage: UIImage(named: "blackShoes.png")!,         itemCost: 79.95, itemDesc: "Sneakers B"),
        storeItem(itemImage: UIImage(named: "blackPolkaDress.png")!,    itemCost: 99.00, itemDesc: "Dress A"),
        storeItem(itemImage: UIImage(named: "redDress.png")!,           itemCost: 89.00, itemDesc: "Dress B")]
    
    @IBOutlet weak var collectionView:  UICollectionView!
    @IBOutlet weak var mainImage:       UIImageView!
    @IBOutlet weak var saleImage:       UIImageView!
    
    var cartButton: MIBadgeButton!
    var itemCount: Int = 0 {
        didSet {
            cartButton.badgeString = String(itemCount)
        }
    }

    override func viewDidLoad() {
        
        self.cartButton = MIBadgeButton(frame: CGRect(x: 40, y: 5, width: CGFloat(40.0), height: CGFloat(44)))
        self.cartButton?.setImage(Ionicons.iosCart.image(30, color: UIColor.blue) , for: .normal)
        
        let barButton : UIBarButtonItem = UIBarButtonItem(customView: cartButton)
        self.navigationItem.setRightBarButton(barButton, animated: false)
        
        mainImage.image = UIImage(named: "hat.png")
        saleImage.image = UIImage(named: "bigSale.png")
    }
    
    
    @IBAction func addToCart(_ sender: AnyObject) {
        //add number in red badge of shopping cart
        itemCount += 1
    }
}


extension storeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storeCell", for: indexPath) as? storeCell
        
        //set images and labels for each item in my container view
        cell?.imageView.image = itemArray[indexPath.item].itemImage
        cell?.costLabel.text = "$" + String(itemArray[indexPath.item].itemCost.roundTo(places: 2))
        cell?.descriptionLabel.text = itemArray[indexPath.item].itemDesc
        
        return cell!
    }
    
    //number of containers
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
