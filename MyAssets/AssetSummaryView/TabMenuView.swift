//
//  TabMenuView.swift
//  MyAssets
//
//  Created by 노민경 on 2022/02/01.
//

// 카드 항목의 세가지 탭을 설정
import SwiftUI

struct TabMenuView: View {
    var tabs: [String]
    @Binding var selectedTab: Int
    @Binding var updated: CreditCardAmounts? // 업데이트된 값이 있다면 빨간 점으로 표시
    
    var body: some View {
        HStack {
            ForEach(0..<tabs.count, id: \.self) {row in
                Button(
                    action: {
                        selectedTab = row // 선택되는 탭을 버튼이 눌릴 때마다 연결시킴
                        UserDefaults.standard.set(true, forKey: "creditcard_update_checked: \(row)") // 기존에 false 값으로 설정해놓고 true 값으로 변하면 빨간 점이 사라지게 함
                    },
                    label: {
                        VStack(spacing: 0) { // 텍스트와 디바이더 표현
                            HStack { // 텍스트와 업데이트 빨간 점 표현
                                if updated?.id == row {
                                    let checked = UserDefaults.standard.bool(forKey: "creditcard_update_checked: \(row)")
                                    Circle()
                                        .fill(
                                        !checked ? Color.red : Color.clear)
                                        .frame(width: 6, height: 6)
                                        .offset(x: 2, y: -8)
                                } else {
                                    Circle()
                                        .fill(Color.clear)
                                        .frame(width: 6, height: 6)
                                        .offset(x: 2, y: -8)
                                }
                                
                                Text(tabs[row])
                                    .font(.system(.headline))
                                    .foregroundColor(
                                        selectedTab == row ? .accentColor : .gray)
                                    .offset(x: -4, y: 0)
                            } // hstack
                            .frame(height: 52)
                            
                            Rectangle()
                                .fill(
                                    selectedTab == row ? Color.secondary : Color.clear)
                                .frame(height: 3)
                                .offset(x: 4, y: 0)
                        } // vstack
                    } // label
                ) // button
                .buttonStyle(PlainButtonStyle())
            } // foreach
        } // hstack
        .frame(height: 55)
    } // view
}

struct TabMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TabMenuView(tabs: ["지난달 결제","이번달 결제", "다음달 결제"], selectedTab: .constant(1), updated: .constant(.currentMonth(amount: "10,000원")))
    }
}
