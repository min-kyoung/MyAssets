//
//  PageControl.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/29.
//

import SwiftUI
import UIKit

// 각각의 PageController 안에 들어갈 해당 뷰에 대한 Representable
struct PageControl: UIViewRepresentable {
    var numberOfPages: Int // 전체 페이지의 수
    @Binding var currentPage: Int // 현재 페이지
    
    // 프로토콜 준수사항 1
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // 프로토콜 준수사항 2
    func makeUIView(context: Context) -> UIPageControl {
        // 컨트롤에 대한 속성 정의
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.addTarget( // 액션 정의
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged // 값이 변경되는 것에 따라 action을 실행시킴
        )
        
        return control
    }
    
    // 프로토콜 준수사항 3
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        var control: PageControl
        
        init(_ control: PageControl) {
            self.control = control
        }
        
        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}

