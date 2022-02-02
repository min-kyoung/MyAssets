# MyAssets
## Description
SwiftUI를 이용하여 자산관리 어플 샘플을 만드는 프로젝트이다. <br>
상단에는 네비게이션 버튼이 들어가 있으며 하단에는 탭 바를 넣어 화면 이동을 가능하게 하나, 현재 프로젝트에서는 첫번째 탭 구성만 다룬다. <br>
화면 위쪽에는 자산관리 어플에 필요한 8가지 항목을 배치하고 중간에는 배너를 넣어 좌우 슬라이딩을 할 수 있도록 한다. <br>
그 아래에는 JSON 파일을 디코딩해서 가져와 샘플 정보를 표시하고 상하 스크롤 이동을 가능하게 한다. <br>
<img src="https://user-images.githubusercontent.com/62936197/151796172-4a091034-be6e-4454-8b5c-f90b3fb5d3f2.png" width="150" height="320"> <br>
## Prerequisite
* 아이폰의 다크 모드, 라이트 모드에 관계없이 항상 라이트 모드 상태로 앱을 유지하기 위해 info.plist에서 Appearance를 추가하고 value는 Light로 설정한다.<br>
 <img src="https://user-images.githubusercontent.com/62936197/151698643-286eab94-62b5-4f23-b48f-d2bf1e85f32a.png" width="550" height="50"> <br>
## Files
>ContentView
 * 앱 하단의 탭 바를 구성한다.
>NavigationBarWithButton
 * 앱 상단의 네비게이션 버튼을 구성한다.
>AssetView 
 * 앱을 실행하면 보여질 메인 화면
#### AssetSummaryView
>AssetSummaryData
 * 데이터 모델을 생성한다.
 * class는 ObservableObject로 설정하고, @Publish를 이용하여 밖으로 "assets.json" 파일을 내보내는 것을 표현한다.
   ```swift
   class AssetSummaryData: ObservableObject {
       @Published var assets: [Asset] = load("assets.json")
   }
   ```
 * 함수를 이용하여 입력한 파일에 대해 원하는 형태로 디코딩한다.
   ```swift
   func load<T: Decodable>(_ filename: String) -> T {
       let data: Data

       ...

       do {
           let decoder = JSONDecoder()
           return try decoder.decode(T.self, from: data)
       } catch {
           fatalError(filename + "을 \(T.self)로 파실할 수 없습니다.")
       }
   }
   ```
>AssetSectionHeader
 * 섹션의 헤더를 설정한다.
>AssetSectionView
 * 데이터 모델을 연결한다.
 * AssetSummaryData를 ObservableObject로 만들었고 실제 뷰에 데이터모델을 연결해서 사용할 것이므로 ObservableObject를 사용하기 위해 ObservedObject로 연결한다.
   ```swift
   struct AssetSectionView: View {
       @ObservedObject var assetSection: Asset
       var body: some View { ... }
   }
   ```
>AssetSummaryView
 * 8개의 자산 타입을 하나씩 넣어줄 부모 뷰
 * AssetSummaryDatad에서 load함수를 통해 json을 디코딩해서 내보내고, AssetSummaryView에서 내보낸 데이터를 받아 바로 표현한다.
 * @EnvironmentObject를 사용하여 외부에서 AssetSummaryData를 받아서 전체 상태를 변경시키고 표현한다.
   ```swift
   struct AssetSummaryView: View {
       @EnvironmentObject var assetData: AssetSummaryData
       var assets: [Asset] {
           return assetData.assets
       }
       var body: some View { ... }
   }
   ```
>TabMenuView
 * 카드 항목의 세가지 탭을 설정한다.
 * 세가지 탭 중 업데이트된 값이 있다면 빨간 점으로 표시한다.
   ```swift
   struct TabMenuView: View {
      var tabs: [String]
      @Binding var selectedTab: Int
      @Binding var updated: CreditCardAmounts? 
      var body: some View { ... }
   }
   
   struct TabMenuView_Previews: PreviewProvider {
       static var previews: some View {
           TabMenuView(tabs: ["지난달 결제","이번달 결제", "다음달 결제"], selectedTab: .constant(1), updated: .constant(.currentMonth(amount: "10,000원")))
       }
   }
   ```
>AssetCardSectionView 
 * 세가지의 탭을 선택한 상태에 따라 그에 맞은 내용을 보여준다.
 * assets.json에서 카드에 대한 5번째 내용을 가져온다.
   ```swift
   struct AssetCardSectionView_Previews: PreviewProvider {
       static var previews: some View {
           let asset = AssetSummaryData().assets[5] // 카드에 대한 5번째 내용을 가져옴
           AssetCardSectionView(asset : asset)
       }
   }
   ```
#### AssetBanner
>BannerCard
 * BannerCard를 하나의 View로 만든다.
>PageViewController
 * UIKit에 있는 PageViewController 활용하여 페이지 스크롤링 기능을 추가한다. 
>PageControl
 * 각각의 PageController 안에 들어갈 해당 뷰에 대한 Representable을 설정한다.
>AssetBannerView
 * PageViewController와 PageControl을 전체적으로 View로 감싸준다.
   ```swift
   var body: some View {
       let bannerCards = bannerList.map {
           BannerCard(bannner: $0) } // bannerList를 가져와서 BannerCard를 가짐
        
       ZStack(alignment: .bottomTrailing) {
           PageViewController(pages: bannerCards, currentPage: $currentPage)
           PageControl(numberOfPages: bannerList.count, currentPage: $currentPage)
               .frame(width: CGFloat(bannerCards.count * 18))
               .padding(.trailing)
       }
   }
   ```
