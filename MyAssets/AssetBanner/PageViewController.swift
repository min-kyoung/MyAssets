//
//  PageViewController.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/29.
//

import SwiftUI
import UIKit
// UIKit에 있는 PageViewController 활용

// 구조체 PageViewController는 page 역할을 하는 view를 받고, UIKit에서 제공하는 UIViewControllerRepresentable로 설정
struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    
    // Binding이라는 property wrapper를 이용해서 현재 어떤 페이지가 보여지고 있는지 확인
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator as! UIPageViewControllerDelegate
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIViewControllerType, context: Context) {
        pageViewController.setViewControllers(
            [context.coordinator.controllers[currentPage]],
            direction: .forward,
            animated: true
        )
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UISearchControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController] ()
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0)}
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else { return nil }
            if index == 0 {
                return controllers.last
            }
            
            return controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else { return nil }
            if index + 1 == controllers.count {
                return controllers.first
            }
            
            return controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
        
    }
}


