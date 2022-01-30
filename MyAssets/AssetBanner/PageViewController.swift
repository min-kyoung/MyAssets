//
//  PageViewController.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/29.
//

import SwiftUI
import UIKit
// UIKit에 있는 PageViewController 활용

// 구조체 PageViewController는 page 역할을 하는 view를 받으며, UIKit에서 제공하는 UIViewControllerRepresentable로 설정
struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    
    // Binding이라는 property wrapper를 이용해서 현재 어떤 페이지가 보여지고 있는지 확인
    @Binding var currentPage: Int
    
    // 프로토콜 준수사항 1
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // 프로토콜 준수사항 2
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    // 프로토콜 준수사항 3
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [context.coordinator.controllers[currentPage]],
            direction: .forward,
            animated: true
        )
    }
    
    // UIKit의 특성인 DataSource와 Delegate를 받을 수 있도록 별도의 Coordinator라고 부르는 조정자를 추가한다.
    // 이 안에서 사용할 DataSource와 Delegate를 구현한다.
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController] ()
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0)} // UIHostingController로 감싸줌
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else { return nil }
            if index == 0 {
                return controllers.last // index가 0이라면 컨트롤러의 마지막을 보여줌
            }
            
            return controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else { return nil }
            if index + 1 == controllers.count {
                return controllers.first // 마지막 카운트에 도달했다면 첫번째 컨트롤러를 보여줌
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


