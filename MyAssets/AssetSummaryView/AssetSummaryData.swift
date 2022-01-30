//
//  AssetSummaryData.swift
//  MyAssets
//
//  Created by 노민경 on 2022/01/30.
//

import SwiftUI

// 데이터 모델을 만듦
class AssetSummaryData: ObservableObject {
    // 밖으로 어떠한 데이터를 내보낼지 표현
    // @Published는 class에서만 작동
    @Published var assets: [Asset] = load("assets.json")
    
}

// 어떠한 파일을 입력하면 내가 원하는 형태로 디코딩을 해주는 함수
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError(filename + "을 찾을 수 없습니다.")
    }
    
    // 데이터를 잘 가지고 옴
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError(filename + "을 찾을 수 없습니다.")
    }
    
    // 디코더 해줌
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError(filename + "을 \(T.self)로 파실할 수 없습니다.")
    }
}
