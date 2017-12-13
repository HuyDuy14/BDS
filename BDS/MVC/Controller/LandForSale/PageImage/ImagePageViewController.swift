//
//  ImagePageViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/13/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class ImagePageViewController: UIPageViewController {

    var listImageURL:[String] = []
    
    weak var imageDelegate: ImagePageViewControllerDelegate?
    var indext:Int = 0
    
    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        var listController:[UIViewController] = []
        for url in self.listImageURL
        {
            if let controler:ImageViewController = self.newViewController("ImageViewController") as? ImageViewController
            {
                controler.urlImage = url
                listController.append(controler)
            }
        }
        return listController
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(initialViewController)
        }
        
        imageDelegate?.imagePageViewController(self,
                                                     didUpdatePageCount: orderedViewControllers.count)
    }
    
    
    func scrollToRightViewController() {
        if let visibleViewController = viewControllers?.first,
            let rightViewController = pageViewController(self,
                                                         viewControllerBefore: visibleViewController) {
            scrollToViewController(rightViewController)
        }
    }
    
    func scrollToLeftViewController() {
        if let visibleViewController = viewControllers?.first,
            let leftViewController = pageViewController(self,
                                                        viewControllerAfter: visibleViewController) {
            scrollToViewController(leftViewController)
        }
    }
    
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
        }
    }
    
    fileprivate func newViewController(_ name: String) -> UIViewController {
        let controller =  UIStoryboard(name: "MenuHome", bundle: nil) .
            instantiateViewController(withIdentifier: "\(name)") as? ImageViewController
        return controller!
    }
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    fileprivate func scrollToViewController(_ viewController: UIViewController,
                                            direction: UIPageViewControllerNavigationDirection = .forward) {
        
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            
                            self.notifyTutorialDelegateOfNewIndex()
        })
    }
    
    /**
     Notifies '_tutorialDelegate' that the current page index was updated.
     */
    fileprivate func notifyTutorialDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            
            imageDelegate?.imagePageViewController(self,
                                                         didUpdatePageIndex: index)
        }
    }
}

// MARK: UIPageViewControllerDataSource

extension ImagePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        var previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        if previousIndex < 0  {
            previousIndex = orderedViewControllers.count - 1
        }
        
//        if orderedViewControllers.count > previousIndex  {
//            return nil
//        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        var nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        
        if orderedViewControllersCount <= nextIndex  {
            nextIndex = 0
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}

extension ImagePageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        notifyTutorialDelegateOfNewIndex()
    }
    
}

protocol ImagePageViewControllerDelegate: class {
    
    
    func imagePageViewController(_ imagePageViewController: ImagePageViewController,
                                    didUpdatePageCount count: Int)
    
    func imagePageViewController(_ imagePageViewController: ImagePageViewController,
                                    didUpdatePageIndex index: Int)
    
}

