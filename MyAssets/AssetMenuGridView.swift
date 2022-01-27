//
//  AssetMenuGridView.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/28.
//

import SwiftUI

struct AssetMenuGridView: View {
    let menuList: [[AssetMenu]] = [
        [.creditScore, .bankAccount, .investment, .loan],
        [.insurance, .creditCard, .cash, .realEstate]
    ]
    
    var body: some View {
        VStack(spacing: 20) { // 수직
            ForEach(menuList, id: \.self) { row in
                // row의 값은  assetMenu의 하나의 리스트가 될 것
                HStack(spacing: 10) { // 수평
                    ForEach(row) { menu in
                        // 행에서 가져온 각각의 item들은 assetMenu가 될 것
                        Button("") {
                            print("\(menu.title)버튼 tapped")
                        }
                        .buttonStyle(AssetMenuButtonStyle(menu: menu))
                    }
                }
            }
        }
    }
}

struct AssetMenuGridView_Previews: PreviewProvider {
    static var previews: some View {
        AssetMenuGridView()
    }
}
