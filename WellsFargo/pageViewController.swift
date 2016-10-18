//
//  pageViewController.swift
//  WellsFargo
//
//  Created by Brandon on 10/15/16.
//  Copyright © 2016 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit

class pageViewController: UIPageViewController{
    
    var imgArray = ["redShoes.png","blackShoes.png","girls.png","chica.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }
}

extension pageViewController : UIPageViewControllerDataSource {
    
    // here is funcionality for continious scroll these all set the next and previous image
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        
        let pageContent: pageContentViewController = viewController as! pageContentViewController
        var index = pageContent.pageIndex
        if (index == NSNotFound){
            return nil;
        }
        index += 1;
        if (index == imgArray.count){
            return getViewControllerAtIndex(index: 0)
        }
        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        
        let pageContent: pageContentViewController = viewController as! pageContentViewController
        var index = pageContent.pageIndex
        if (index == NSNotFound){
            return nil
        }
        //continious
        if (index == 0){
            return getViewControllerAtIndex(index: imgArray.count - 1)
        }
        index -= 1;
        return getViewControllerAtIndex(index: index)
  
    }
    
    // MARK:- Other Methods
    func getViewControllerAtIndex(index: NSInteger) -> pageContentViewController
    {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! pageContentViewController
        
        pageContentViewController.strPhotoName = "\(imgArray[index])"
        pageContentViewController.pageIndex = index
        
        return pageContentViewController
    }
}
