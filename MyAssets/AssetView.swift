//
//  AssetView.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/28.
//

import SwiftUI

struct AssetView: View {
    var body: some View {
        NavigationView {
            // stack이나 grid의 경우 스크롤을 포함하고 있지 않음
            // 따라서 스크롤 했을 때 자연스럽게 뷰가 내려가게 하려면 스크롤 뷰 안에 stack이나 gird를 넣어주어야 컨테이너 밖에 있는 데이터도 자연스럽게 표현 됨
            ScrollView {
                VStack(spacing: 30) {
                    Spacer()
                    AssetMenuGridView()
                    AssetBannerView()
                        .aspectRatio(5/2, contentMode: .fit)
                }
            }
            .background(Color.gray.opacity(0.2))
            .navigationBarWithButtonStyle("내 자산")
        }
    }
}

struct AssetView_Previews: PreviewProvider {
    static var previews: some View {
        AssetView()
    }
}
