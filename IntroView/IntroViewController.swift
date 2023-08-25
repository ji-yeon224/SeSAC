//
//  IntroViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/25.
//

import UIKit

class IntroViewController: UIPageViewController {
    
    var pageViewControllerList: [UIViewController] = []
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setPageViewController()
        configurePageViewController()
    }
    
    func setPageViewController() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: FirstViewController.identifier) as! FirstViewController
        let vc2 = sb.instantiateViewController(withIdentifier: SecondViewController.identifier) as! SecondViewController
        
        pageViewControllerList = [vc1, vc2]
    }
    
    func configurePageViewController() {
        delegate = self
        dataSource = self
        
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
        
    }
    


}

extension IntroViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewConIdx = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let previous = viewConIdx - 1
        
        return previous < 0 ? nil: pageViewControllerList[previous]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewConIdx = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIdx = viewConIdx + 1
        
        return nextIdx >= pageViewControllerList.count ? nil: pageViewControllerList[nextIdx]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        return index
    }
    
    
    
}
