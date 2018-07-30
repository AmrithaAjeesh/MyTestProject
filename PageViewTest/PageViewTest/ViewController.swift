//
//  ViewController.swift
//  PageViewTest
//
//  Created by Rigin Velayudhan on 18/07/18.
//  Copyright © 2018 Rigin Velayudhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {

   
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    var pageImages:NSArray!
    var pageViewController:UIPageViewController!
    var pendingIndex:Int?
//    var pageViewVC: OnbardVC? {
//        didSet {
//            pageViewVC?.pageViewDelegate = self
//        }
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        pageImages = NSArray(objects:"screen1","screen2","screen3")
        self.pageControl.numberOfPages = pageImages.count
        self.createPageViewController()
      //  pageControl.addTarget(self, action: #selector(createPageViewController), for: .valueChanged)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let tutorialPageViewController = segue.destination as? OnbardVC {
//            self.pageViewVC = tutorialPageViewController
//        }
//    }
    @objc func createPageViewController()
    {
        let pageController = self.storyboard?.instantiateViewController(withIdentifier: "pageVC") as! UIPageViewController
        pageController.dataSource = self
        pageController.delegate = self
        if pageImages.count > 0
        {
            let contentController = getContentViewController(withIndex: 0)
            let contentControllers = [contentController]
            pageController.setViewControllers(contentControllers as! [UIViewController], direction: .forward, animated: true, completion: nil)
        }
        pageViewController = pageController
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
    }
    func getContentViewController(withIndex index:Int) -> ShowPageVC?
    {
        if index < pageImages.count
        {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "firstVC") as! ShowPageVC
            controller.pageIndex = index
            controller.imageFileName = pageImages[index] as! String
            return controller
        }
        return nil
    }
//    // When the user taps on the pageControl to change its current page.
//    @objc func didChangePageControlValue() {
//        pageViewVC?.scrollTo(index: pageControl.currentPage)
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let contentVC = viewController as! ShowPageVC
        if contentVC.pageIndex > 0
        {
            return getContentViewController(withIndex: contentVC.pageIndex - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let contentVC = viewController as! ShowPageVC
        if contentVC.pageIndex + 1 < pageImages.count
        {
            return getContentViewController(withIndex: contentVC.pageIndex + 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = (pendingViewControllers.first as! ShowPageVC).pageIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed
        {
            let currentIndex = pendingIndex
            if let index = currentIndex
            {
                self.pageControl.currentPage = index
            }
        }
    }
    
}
//extension ViewController: PageViewVCDelegate {
//
//    func didUpdatePageCount(_ vc: OnbardVC, count: Int) {
//        pageControl.numberOfPages = count
//    }
//
//    func didUpdatePageIndex(_ vc: OnbardVC, index: Int) {
//        pageControl.currentPage = index
//    }
//}

