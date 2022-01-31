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
 * 앱 하단의 탭 바 구성
>NavigationBarWithButton
 * 앱 상단의 네비게이션 버튼 구성
>AssetView
 * 앱을 실행하면 보여질 메인 화면
