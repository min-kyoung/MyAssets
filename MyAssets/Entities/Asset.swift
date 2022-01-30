//
//  Asset.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/30.
//

// assets.json에 있는 데이터를 디코딩해서 뿌려주기 위해 데이터 모델에 맞는 엔티티를 만듦

import Foundation
import SwiftUI

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
    let creditCardAmounts: [CreditCardAmounts]?
    
    init(id: Int, title: String, amount: String, creditCardAmounts: [CreditCardAmounts]? = nil) {
        self.id = id
        self.title = title
        self.amount = amount
        self.creditCardAmounts = creditCardAmounts
    }
}

enum CreditCardAmounts: Identifiable, Decodable {
    case previousMonth(amount: String)
    case currentMonth(amount : String)
    case nextMonth(amount: String)
    
    var id: Int {
        switch self {
        case .previousMonth:
            return 0
        case .currentMonth:
            return 1
        case .nextMonth:
            return 2
        }
    }
    
    var amount: String {
        switch self {
        case .previousMonth(let amount),
             .currentMonth(let amount),
             .nextMonth(let amount):
            return amount
        }
    }
    
    // decodable을 위한 CodingKeys
    enum CodingKeys: String, CodingKey {
        case previousMonth
        case currentMonth
        case nextMonth
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let value = try? values.decode(String.self, forKey: .previousMonth) {
            self = .previousMonth(amount: value)
            return
        }
        
        if let value = try? values.decode(String.self, forKey: .currentMonth) {
            self = .currentMonth(amount: value)
            return
        }
        
        if let value = try? values.decode(String.self, forKey: .nextMonth) {
            self = .nextMonth(amount: value)
            return
        }
        
        throw fatalError("ERROR: CreditCardAmounts JSON Decoding")
    }
   
}
