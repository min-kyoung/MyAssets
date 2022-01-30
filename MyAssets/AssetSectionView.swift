//
//  AssetSectionView.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/30.
//

import SwiftUI

struct AssetSectionView: View {
    // AssetSummaryData를 ObservableObject로 만들었고 실제 뷰에 데이터모델을 연결해서 사용할 것
    // ObservableObject를 사용하기 위해 ObservedObject로 연결
    @ObservedObject var assetSection: Asset
    var body: some View {
        VStack(spacing: 20) {
            AssetSectionHeaderView(title: assetSection.type.title)
            ForEach(assetSection.data) { asset in
                HStack {
                    Text(asset.title)
                        .font(.title)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(asset.amount)
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                Divider()
            }
            .padding()
        }
    }
}

struct AssetSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let asset = Asset(
            id: 0,
            type: .bankAccount,
            data: [
            AssetData(id: 0, title: "신한은행", amount: "5,300,000원")
            ]
        )
        AssetSectionView(assetSection: asset)
    }
}
