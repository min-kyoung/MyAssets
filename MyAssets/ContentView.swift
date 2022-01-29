//
//  ContentView.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/27.
//

import SwiftUI

struct ContentView: View {
    // 하단에 탭 바가 있는 TabView를 표현
    @State private var selection: Tab = .asset
    
    // 먼저 선택된 탭이 항상 존재할 것이므로, 첫번째 탭으로 표현할 수 있도록 enum을 생성
    enum Tab {
        case asset
        case recommend
        case alert
        case setting
    }
    
    var body: some View {
        TabView(selection: $selection) {
            AssetView() // AssetView 추가
                .tabItem {
                    // 시스템 이미지로 나타냄
                    Image(systemName: "dollarsign.circle.fill")
                    Text("자산")
                }
                .tag(Tab.asset)
            
            Color.blue
                .edgesIgnoringSafeArea(.all)
                .tabItem {
                    Image(systemName: "hand.thumbsup.fill")
                    Text("추천")
                }
                .tag(Tab.recommend)
            
            Color.yellow
                .edgesIgnoringSafeArea(.all)
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("알림")
                }
                .tag(Tab.alert)
            
            Color.red
                .edgesIgnoringSafeArea(.all)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("설정")
                }
                .tag(Tab.setting)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
