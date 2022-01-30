//
//  Asset.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/30.
//

// assets.json에 있는 데이터를 디코딩해서 뿌려주기 위해 데이터 모델에 맞는 엔티티를 만듦

import Foundation

class Asset: Identifiable, ObservableObject, Decodable {
    let id: Int
    let type: AssetMenu
    let data: [AssetData]
    
    init(id: Int, type: AssetMenu, data: [AssetData]) {
        self.id = id
        self.type = type
        self.data = data
    }
}

// asset.json을 보면 data 항목 아래에 또 다른 array가 들었으므로 새로운 entity를 하나 더 만듦
class AssetData: Identifiable, ObservableObject, Decodable {
    let id: Int
    let title: String
    let amount: String
    
    init(id: Int, title: String, amount: String) {
        self.id = id
        self.title = title
        self.amount = amount
    }
}
