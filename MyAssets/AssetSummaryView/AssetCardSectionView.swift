//
//  AssetCardSectionView.swift
//  MyAssets
//
//  Created by 노민경 on 2022/02/01.
//

// 세가지의 탭을 선택한 상태에 따라 그에 맞은 내용을 보여줌
import SwiftUI

struct AssetCardSectionView: View {
    @State private var selectedTab = 1 // 화면이 보여졌을 때 두번째 탭이 선택되어 있는 것을 기본값으로 함
    @ObservedObject var asset: Asset
    
    var assetData: [AssetData] {
        return asset.data
    }
    
    var body: some View {
        VStack {
            AssetSectionHeaderView(title: asset.type.title)
            TabMenuView(
                tabs: ["지난달 결제", "이번달 결제", "다음달 결제"],
                selectedTab: $selectedTab,
                updated: .constant(.nextMonth(amount: "10,000원"))
            )
            
            TabView(
                selection: $selectedTab,
                content: {
                    ForEach(0...2, id: \.self) { i in
                        VStack { // 각각의 카드 표시
                            ForEach(assetData) { data in
                                HStack { // 카드와 결제 금액 표시
                                    Text(data.title)
                                        .font(.title)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text(data.creditCardAmounts![i].amount)
                                        .font(.title2)
                                        .foregroundColor(.primary)
                                } // hstack
                                Divider()
                            }
                        } // vstack
                        .tag(i)
                    }
                }
            ) // tabview
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        } // vstack
        padding()
    } // view
}

struct AssetCardSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let asset = AssetSummaryData().assets[5] // 카드에 대한 5번째 내용을 가져옴
        AssetCardSectionView(asset : asset)
    }
}
