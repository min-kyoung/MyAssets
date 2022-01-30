//
//  BannerCard.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/29.
//

import SwiftUI

// BannerCard를 하나의 View로 만듦
struct BannerCard: View {
    var bannner: AssetBanner
    
    var body: some View {
        // 방법 1
        ZStack {
            Color(bannner.backgroundColor)
            VStack {
                Text(bannner.title)
                    .font(.title)
                Text(bannner.description)
                    .font(.subheadline)
            }
        }
        
        // 방법 2
//        Color(bannner.backgroundColor)
//            .overlay(
//                VStack {
//                    Text(bannner.title)
//                        .font(.title)
//                    Text(bannner.description)
//                        .font(.subheadline)
//                }
//            )
        
    }
}

struct BannerCard_Previews: PreviewProvider {
    static var previews: some View {
        let banner0 = AssetBanner(title: "공지사항", description: "추가된 공지사항을 확인하세요.", backgroundColor: .red)
        BannerCard(bannner: banner0)
    }
}
