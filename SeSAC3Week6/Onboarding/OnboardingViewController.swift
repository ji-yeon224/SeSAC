//
//  OnboardingViewController.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/25.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
    }
}



class OnboardingViewController: UIPageViewController,
                                    UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    //1.
    var list: [UIViewController] = []
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = [FirstViewController(), SecondViewController(), ThirdViewController()]
        view.backgroundColor = .lightGray
        delegate = self
        dataSource = self
        
        guard let first = list.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil } //인덱스가 없으면 더이상 화면이 없는 것
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : list[previousIndex]
        
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        return nextIndex >= list.count ? nil : list[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    // 보고있는 페이지에 따라 페이지 컨트롤이 변경되어야 한다.
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = list.firstIndex(of: first) else { return 0 }
        return index
    }
    
}












