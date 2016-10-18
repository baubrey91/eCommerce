//
//  storeItem.swift
//  WellsFargo
//
//  Created by Brandon on 10/15/16.
//  Copyright © 2016 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit

class storeItem {
    var itemImage : UIImage
    var itemCost : Double
    var itemDesc : String
    init(itemImage: UIImage, itemCost: Double, itemDesc: String){
        self.itemImage = itemImage
        self.itemCost = itemCost
        self.itemDesc = itemDesc
    }
}
