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
   ```swift
   struct ContentView: View {
       // 하단에 탭 바가 있는 TabView를 표현
       @State private var selection: Tab = .asset

       // 먼저 선택된 탭이 항상 존재할 것이므로, 첫번째 탭으로 표현할 수 있도록 enum을 생성
       enum Tab {
           case asset
           case recommend
           case alert
           case setting
       }
   ```
>NavigationBarWithButton
 * 앱 상단의 네비게이션 버튼을 구성한다.
 * ViewModifier는 후에 view에 바로 이 버튼을 함수처럼 적용해서 이 ViewModifier가 표현하고 있는 내용을 그대로 적용할 수 있다.
   ```swift
   struct NavigationBarWithButton: ViewModifier { ... }
   ```
 * Modifier를 한 경우 preview를 볼 때 버튼에 바로 실행하는 것이 아니라 SwiftUI에서 제공하는 이 뷰에 위의 modifier를 바로 적용할 수 있다.
   ```swift
   struct NavigationBarWithButton_Previews: PreviewProvider {
       static var previews: some View {
           NavigationView {
               Color.gray.edgesIgnoringSafeArea(.all)
                   .navigationBarWithButtonStyle("내 자산")
           }
       }
   }
   ```
>AssetView 
 * 앱을 실행하면 보여질 메인 화면
 * stack이나 grid의 경우 스크롤을 포함하고 있지 않다. <br>
   따라서 스크롤 했을 때 자연스럽게 뷰가 내려가게 하려면 스크롤 뷰 안에 stack이나 gird를 넣어주어야 컨테이너 밖에 있는 데이터도 자연스럽게 표현 된다.
   ```swift
   NavigationView {
       ScrollView {
            VStack(spacing: 30) {
                Spacer()
                AssetMenuGridView()
                AssetBannerView()
                    .aspectRatio(5/2, contentMode: .fit)
                AssetSummaryView()
                    .environmentObject(AssetSummaryData())
            }
        }
        .background(Color.gray.opacity(0.2))
        .navigationBarWithButtonStyle("내 자산")
   }
   ```
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
 * 구조체 PageViewController는 page 역할을 하는 view를 받으며, UIKit에서 제공하는 UIViewControllerRepresentable로 설정한다.
   ```swift
   struct PageViewController<Page: View>: UIViewControllerRepresentable {
      var pages: [Page]

      @Binding var currentPage: Int  // Binding이라는 property wrapper를 이용해서 현재 어떤 페이지가 보여지고 있는지 확인

      // 프로토콜 준수사항 1
      func makeCoordinator() -> Coordinator { ... }
      
      // 프로토콜 준수사항 2
      func makeUIViewController(context: Context) -> UIPageViewController { ... }
      
      // 프로토콜 준수사항 3
      func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) { ... }
    ```
 * UIKit의 특성인 DataSource와 Delegate를 받을 수 있도록 별도의 Coordinator라고 부르는 조정자를 추가하며, 이 안에서 사용할 DataSource와 Delegate를 구현한다.
    ```swift
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController] ()
       
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0)} // UIHostingController로 감싸줌
        }
        
        // index가 0이라면 컨트롤러의 마지막을 보여줌
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? { ... }
         
        // 마지막 카운트에 도달했다면 첫번째 컨트롤러를 보여줌
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? { ... }
    ```
>PageControl
 * 각각의 PageController 안에 들어갈 해당 뷰를 Representable로 설정한다.
   ```swift
   struct PageControl: UIViewRepresentable {
       var numberOfPages: Int // 전체 페이지의 수
       @Binding var currentPage: Int // 현재 페이지
       
       // 프로토콜 준수사항 1
       func makeCoordinator() -> Coordinator { ... }

       // 프로토콜 준수사항 2
       func makeUIView(context: Context) -> UIPageControl { ... }

       // 프로토콜 준수사항 3
       func updateUIView(_ uiView: UIPageControl, context: Context) { ... }
   }
   ```
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
#### AssetMenu
>AssetMenuButtonStyle
 * 동일한 형태의 반복되는 버튼의 모양을 view로 만들어주는 대신에 SwiftUI에서 제공해주는 버튼 스타일을 customizing 해서 재사용 한다.
>AssetMenuGridView
 * 8가지 항목의 grid를 설정한다. 
#### Entities
>AssetMenu
 * 8가지 항목 엔티티를 정의한다.
>AssetBanner
 * 배너 엔티티를 정의한다.
>Asset
 * assets.json에 있는 데이터를 디코딩해서 뿌려주기 위해 데이터 모델에 맞는 엔티티를 만든다.
