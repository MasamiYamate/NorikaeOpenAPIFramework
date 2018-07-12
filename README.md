# NorikaeOpenAPIFramework
ジョルダンが提供している乗換案内オープンAPI iOS向けFramework
## Description
　本Frameworkは、ジョルダン株式会社が提供している「乗換案内オープンAPI」をiOS上で利用する際のFrameworkです。乗換案内オープンAPIを利用する際は、
 利用申請及び、クライアントからリクエストするための、エンドポイントが別途必要になります。  
　なお、本Frameworkは個人の活動の一貫でリリースしています。所属団体やAPI提供元のジョルダン株式会社とは無関係になります。各方面への問い合わせはご遠慮ください。
 
## Installation
・CocoaPodsを利用する場合
Podfileに下記項目を追記してください。

```
pod 'NorikaeOpenAPIFramework'
```
・マニュアルでインストールする場合  
```NorikaeOpenAPIFramework.xcodeproj```を開き、Buildしてください。生成されたFrameworkを任意のProjectにImportすると利用できます。

## Usage
### Import

```sample.swift
import NorikaeOpenAPIFramework
```

### Setup
AppDelegate.swift内で、乗換案内オープンAPI利用申請後に発行されるアクセスキーとクライアントからリクエストする任意のエンドポイントを設定します。

```AppDelegate.swift
import UIKit
import NorikaeOpenAPIFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        NorikaeOpenAPIFramework.share.setAccessKey("アクセスキー")
        NorikaeOpenAPIFramework.share.setEndPoint("エンドポイント")
        
        // Override point for customization after application launch.
        return true
    }
}
```

### Search

```Search.swift

/// 任意の文字列から駅名検索を行います
///
/// - Parameters:
///   - keyword: 検索したい駅名のキーワード
///   - mode: 検索モードの指定 0...前方一致(デフォルト) 1...完全一致優先
/// - Returns: NOAStationの配列が返却されます。エラー発生時は、nilが返却されます。
let stations: [NOAStation]? = NorikaeOpenAPIFramework.share.searchStations ("keyword String" , mode: 0)

/// 任意の文字列から路線名検索を行います
///
/// - Parameters:
///   - keyword: 検索したい駅名のキーワード
///   - mode: 検索モードの指定 0...前方一致(デフォルト) 1...完全一致優先
/// - Returns: NOALineの配列が返却されます。エラー発生時は、nilが返却されます。
let lines: [NOALine]? = NorikaeOpenAPIFramework.share.searchLineNames ("keyword String" , mode: 0)

/// 特定の駅を通る路線名を取得します
///
/// - Parameters:
///   - keyword: 駅名検索で取得した任意の駅名
///   - mode: 検索モードの指定 0...前方一致(デフォルト) 1...完全一致優先
/// - Returns: NOALineの配列が返却されます。エラー発生時は、nilが返却されます。
let groupLines: [NOALine]? = NorikaeOpenAPIFramework.share.searchTheNameOfTheLineConnectingToTheStation ("keyword String", mode: 0)

/// 特定の路線に所属する駅名を取得します
///
/// - Parameter keyword: 路線名検索で取得した任意の路線名
/// - Returns: NOAStationの配列が返却されます。エラー発生時は、nilが返却されます。
let groupStations: [NOAStation]? = NorikaeOpenAPIFramework.share.searchForTheStationOnTheLine ("keyword String")

/// 任意の区間の経路検索を行う
///
/// - Parameters:
///   - eki1: 出発地の名称 (検索結果から得られた正式名称)
///   - eki2: 目的地の名称 (検索結果から得られた正式名称)
///   - kbn1: 出発地の区分 (NOAStationオブジェクトのtype.rawValueで取得可能)
///   - kbn2: 目的地の区分 (NOAStationオブジェクトのtype.rawValueで取得可能)
///   - date: 検索する日付 ※Optional
/// - Returns: NOARouteが返却されます。エラー発生時は、nilが返却されます。
let route: NOARoute? = NorikaeOpenAPIFramework.share.routeSearch(eki1: "DepartureName" , eki2: "ArrivalName" , kbn1: "DepartureType String" , kbn2: "ArrivalType String" , date: Date() )

```

