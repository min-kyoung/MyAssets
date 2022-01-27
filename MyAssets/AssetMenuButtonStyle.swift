//
//  AssetMenuButtonStyle.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/28.
//

import SwiftUI

// 동일한 형태의 반복되는 버튼의 모양을 view로 만들어주는 대신에 SwiftUI에서 제공해주는 버튼 스타일을 customizing 해서 재사용 한다.

struct AssetMenuButtonStyle: ButtonStyle {
    // AssetMenu가 가지는 값에 따라서 어떠한 이미지와 텍스트를 보여줄지 판단
    let menu: AssetMenu
    func makeBody(configuration: Configuration) -> some View {
        return VStack {
            // 이미지가 위에 있고 그 아래 텍스트가 위치하는 형태
            Image(systemName: menu.systemImageName) // 만들어놓은 systemImageName을 가져옴
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .padding([.leading, .trailing], 10)
            Text(menu.title)
                .font(.system(size: 12, weight: .bold))
        }
        // VStack 설정
        .padding()
        .foregroundColor(.blue)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10)) // 테두리만 남기는 것이 아니라 전체 모양을 오려내듯이 표현하는 것
    }
}

struct AssetMenuButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 24) {
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .creditScore))
            
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .bankAccount))
            
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .creditCard))
            
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .cash))
           
        }
        .background(Color.gray.opacity(0.2))
    }
}
