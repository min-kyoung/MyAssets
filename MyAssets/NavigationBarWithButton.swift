//
//  NavigationBarWithButton.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/28.
//

import SwiftUI

// ViewModifier는 후에 view에 바로 이 버튼을 함수처럼 적용해서 이 ViewModifier가 표현하고 있는 내용을 그대로 적용할 수 있다.
struct NavigationBarWithButton: ViewModifier {
    var title: String = ""
    func body(content: Content) -> some View {
        return content
            .navigationBarItems(
                leading: Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .padding(),
                trailing: Button(
                    action: {
                        print("자산 추가 버튼 tapped")
                    },
                    label: {
                        Image(systemName: "plus")
                        Text("자산추가")
                            .font(.system(size: 12))
                    }
                )
                    .accentColor(.black)
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black) // 내부에 채움 없이 테두리만 가져옴
                    )
            )
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // navigationbar의 appearance를 조정하려면 UIKit의 정보를 활용
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.backgroundColor = UIColor(white: 1, alpha: 0.6)
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance // 조금 줄어들었을 때
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
    }
}

extension View {
    func navigationBarWithButtonStyle(_ title: String) -> some View {
        return self.modifier(NavigationBarWithButton(title: title))
    }
}

// Modifier를 한 경우 preview를 볼 때 버튼에 바로 실행하는 것이 아니라
// SwiftUI에서 제공하는 이 뷰에 위의 modifier를 바로 적용할 수 있다.
struct NavigationBarWithButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Color.gray.edgesIgnoringSafeArea(.all)
                .navigationBarWithButtonStyle("내 자산")
               
        }
        
    }
}
