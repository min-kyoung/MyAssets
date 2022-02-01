//
//  AssetSummaryView.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/30.
//

import SwiftUI

// 8개의 자산 타입을 하나씩 넣어줄 부모 뷰
struct AssetSummaryView: View {
    // AssetSummaryDatad에서 load함수를 통해 json을 디코딩해서 내보내고,
    // AssetSummaryView에서 내보낸 데이터를 받아 바로 표현함
    
    // @EnvironmentObject를 사용하여 외부에서 AssetSummaryData를 받아서 전체 상태를 변경시키고 표현함
    @EnvironmentObject var assetData: AssetSummaryData
    var assets: [Asset] {
        return assetData.assets
    }
    var body: some View {
        VStack(spacing: 20) {
            ForEach(assets) { asset in
                switch asset.type {
                case .creditCard:
                    AssetCardSectionView(asset: asset)
                        .frame(idealHeight: 250)
                default:
                    AssetSectionView(assetSection: asset)
                }
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
        }
    }
}

struct AssetSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AssetSummaryView()
            .environmentObject(AssetSummaryData())
            .background(Color.gray.opacity(0.2))
    }
}
