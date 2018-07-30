//
//  OnbardVC.swift
//  PageViewTest
//
//  Created by Rigin Velayudhan on 18/07/18.
//  Copyright © 2018 Rigin Velayudhan. All rights reserved.
//

import UIKit

class OnbardVC: UIPageViewController {
    
    var imageFileName: String!
    var pageIndex:Int!
    weak var pageViewDelegate: PageViewVCDelegate?
    
    // The view controllers will be shown in this order
    fileprivate(set) lazy var controllers: [UIViewController] = {
        return [self.createViewController(with: "firstVC"),
                self.createViewController(with: "secondVC"),
                self.createViewController(with: "thirdVC")]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        if let initialViewController = controllers.first {
            self.scrollTo(initialViewController)
        }
        
        pageViewDelegate?.didUpdatePageCount(self, count: controllers.count)
        
        // Do any additional setup after loading the view.
    }

    // Scroll to view controller with given index
    func scrollTo(index newIndex: Int) {
        guard let firstViewController = viewControllers?.first else{
            return
        }
        
        guard let currentIndex = controllers.index(of: firstViewController)  else {
            return
        }
        
        let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
        let nextVC = controllers[newIndex]
        
        self.scrollTo(nextVC,direction: direction)
    }
    
    // create view controller
    func createViewController(with id : String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: id)
    }
    
    // scroll to view controller, by default forward
    func scrollTo(_ vc : UIViewController, direction : UIPageViewControllerNavigationDirection = .forward){
        setViewControllers([vc], direction: direction, animated: true) { _ in
            self.notifyDelegateOfNewIndex()
        }
    }
    
    // Notifies 'PageViewDelegate' that the current page index was updated.
    fileprivate func notifyDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = controllers.index(of: firstViewController) {
            pageViewDelegate?.didUpdatePageIndex(self, index: index)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: UIPageViewControllerDataSource

extension OnbardVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // get current index
        guard let currentIndex = controllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        
        // User is on the first view controller and swiped left
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard controllers.count > previousIndex else {
            return nil
        }
        
        return controllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // get current index
        guard let currentIndex = controllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        let controllersCount = controllers.count
        
        // stop scroll on last index
        guard controllersCount > nextIndex else {
            return nil
        }
        
        return controllers[nextIndex]
    }
    
}

extension OnbardVC: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        notifyDelegateOfNewIndex()
    }
}

protocol PageViewVCDelegate : class {
    
    // Called when the number of pages is updated.
    func didUpdatePageCount(_ vc : OnbardVC, count : Int)
    
    // Called when the current index is updated.
    func didUpdatePageIndex(_ vc : OnbardVC, index : Int)
}

