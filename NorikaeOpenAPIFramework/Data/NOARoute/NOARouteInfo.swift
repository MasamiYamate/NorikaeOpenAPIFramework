//
//  NOARouteInfo.swift
//  NorikaeOpenAPIFramework
//
//  Created by MasamiYamate on 2018/07/04.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit

@objcMembers open class NOARouteInfo: NSObject {

    public var routeId:String = ""  //ルートID
    
    //経路の概要情報
    public var pathCount       : Int  = -1     //経路で使用する路線数
    public var routeTime       : Int  = -1     //経路の所要時間(分)
    public var routeCost       : Int  = -1     //経路の費用 (きっぷ運賃)
    public var routeIcCost     : Int  = -1     //経路の費用 (IC運賃)
    public var isIcExist       : Bool = false  //IC運賃の有無
    public var routeDist       : Int  = -1     //経路の距離 100m単位 (無効時は、負の値が入ります)
    public var transferCount   : Int  = -1     //乗換回数
    
    //経路の評価情報
    public var isFastest       : Bool = false  //最も所要時間が短いルート
    public var isCheapest      : Bool = false  //最も費用が安いルート
    public var isEasiest       : Bool = false  //最も経路数が少ない、乗り継ぎが少なく楽なルート

    public var isIcCardDiffCost    : Bool = false  //経路にICカード使用時に異なる運賃が含まれているか
    public var isTransferTimeShort : Bool = false  //検索結果の中で、最も乗継時間が短いか
    
    public var isCo2CostLeast  : Bool  = false //検索結果の中で、最もCo2排出量が少ない
    
    public var isShinkansenIncl        : Bool = false  //経路に新幹線を含む
    public var isNozomiIncl            : Bool = false  //経路に東海道新幹線のぞみを含む
    public var isLimitedExpIncl        : Bool = false  //経路に有料特急列車を含む
    public var isSleeperTrainIncl      : Bool = false  //経路に寝台列車が含まれるか
    public var isAirplaneIncl          : Bool = false  //経路に空路が含まれるか
    public var isBusIncl               : Bool = false  //経路に路線バスを含む
    public var isHighwayBusIncl        : Bool = false  //経路に高速バスを含む
    public var isAirportBusIncl        : Bool = false  //経路に空港連絡バスを含む
    public var isMidnightExpBusIncl    : Bool = false  //経路に深夜急行バスを含む
    public var isSeaRouteIncl          : Bool = false  //経路に航路を含む
    public var isWalkIncl              : Bool = false  //経路に徒歩を含む
    public var isPaidLocalTrain        : Bool = false  //経路に有料普通列車を含む
    public var isJrIncl                : Bool = false  //経路にJRを含む
    
    public var routePaths:[NOARoutePath]             = []   //Path情報
    public var routeDisplayPaths:[NOAForDisplayPath] = []   //UITableViewなど経路を順に表示する際に使用する表示用Path
    
    public init(_ route:[String:Any]) {
        if let tmpRouteId: String = route["id"] as? String {
            routeId = tmpRouteId
        }
        if let hyouka: [String:Any] = route["hyouka"] as? [String:Any] {
            if let strPathCnt: String = hyouka["pathCnt"] as? String , let setPathCnt: Int = Int(strPathCnt) { pathCount = setPathCnt }
            if let strRouteTime: String = hyouka["jikan"] as? String , let setRouteTime: Int = Int(strRouteTime) { routeTime = setRouteTime }
            if let strHiyou: String = hyouka["hiyou"] as? String , let setHiyou: Int = Int(strHiyou) { routeCost = setHiyou }
            if let strIcExist: String = hyouka["icExist"] as? String , strIcExist == "1" { isIcExist = true }
            if let strIcHiyou: String = hyouka["icHiyou"] as? String , let setIcHiyou: Int = Int(strIcHiyou) { routeIcCost = setIcHiyou }
            if let strKyori: String = hyouka["kyori"] as? String , let setKyori: Int = Int(strKyori) { routeDist = setKyori }
            if let strNorikaeCnt: String = hyouka["norikaeCnt"] as? String , let setNorikaeCnt: Int = Int(strNorikaeCnt) { transferCount = setNorikaeCnt }
            if let status: [String:Any] = hyouka["status"] as? [String:Any] {
                if let hayai: String = status["hayai"] as? String , hayai == "1" { isFastest = true }
                if let yasui: String = status["yasui"] as? String , yasui == "1" { isCheapest = true }
                if let raku : String = status["raku"] as? String , raku == "1" { isEasiest = true}
                if let icCard: String = status["icCard"] as? String , icCard == "1" { isIcCardDiffCost = true }
                if let norikae: String = status["norikae"] as? String , norikae == "1" { isTransferTimeShort = true }
                if let co2: String = status["co2"] as? String , co2 == "1" { isCo2CostLeast = true }
            }
            if let kubun: [String:Any] = hyouka["kubun"] as? [String:Any] {
                if let shinkansen: String = kubun["shinkansen"] as? String , shinkansen == "1" { isShinkansenIncl = true }
                if let nozomi: String = kubun["nozomi"] as? String , nozomi == "1" { isNozomiIncl = true }
                if let tokkyu: String = kubun["tokkyu"] as? String , tokkyu == "1" { isLimitedExpIncl = true}
                if let shindai: String = kubun["shindai"] as? String , shindai == "1" { isSleeperTrainIncl = true }
                if let kuuro: String = kubun["kuuro"] as? String , kuuro == "1" { isAirplaneIncl = true }
                if let bus: String = kubun["bus"] as? String , bus == "1" { isBusIncl = true }
                if let kousoku: String = kubun["kousoku"] as? String , kousoku == "1" { isHighwayBusIncl = true }
                if let renraku: String = kubun["renraku"] as? String , renraku == "1" { isAirportBusIncl = true }
                if let shinya: String = kubun["shinya"] as? String , shinya == "1" { isMidnightExpBusIncl = true }
                if let ferry: String = kubun["ferry"] as? String , ferry == "1" { isSeaRouteIncl = true }
                if let toho: String = kubun["toho"] as? String , toho == "1" { isWalkIncl = true }
                if let yuryou: String = kubun["yuryou"] as? String , yuryou == "1" { isPaidLocalTrain = true }
                if let jr: String = kubun["jr"] as? String , jr == "1" { isJrIncl = true }
            }
        }
        
        if let paths: [[String:Any]] = route["path"] as? [[String:Any]] {
            routePaths = paths.map{(path: [String:Any]) -> NOARoutePath in
                return NOARoutePath(path)
            }
        }
        
        routeDisplayPaths = NOARouteInfo.generateDisplayPaths(paths: routePaths)
        
    }
    
    
    class func generateDisplayPaths (paths: [NOARoutePath]) -> [NOAForDisplayPath] {
        var retPaths: [NOAForDisplayPath] = []
        
        for (i , path) in paths.enumerated() {
            //1区間のみの場合
            if i == 0 , paths.count == 1 {
                retPaths.append(NOAForDisplayPath.createDisplayPaths(path, nextPath: nil, type: .DeparturePath, idx: retPaths.count))
                retPaths.append(NOAForDisplayPath.createDisplayPaths(path, nextPath: nil, type: .SectionPath, idx: retPaths.count))
                retPaths.append(NOAForDisplayPath.createDisplayPaths(path, nextPath: nil, type: .ArrivalPath, idx: retPaths.count))
            } else {
                if i == 0 {
                    retPaths.append(NOAForDisplayPath.createDisplayPaths(path, nextPath: nil, type: .DeparturePath, idx: retPaths.count))
                    retPaths.append(NOAForDisplayPath.createDisplayPaths(path, nextPath: nil, type: .SectionPath, idx: retPaths.count))
                    retPaths.append(NOAForDisplayPath.createDisplayPaths(path, nextPath: paths[i + 1], type: .TransitPath, idx: retPaths.count))
                }else if i == paths.count - 1 {
                    retPaths.append(NOAForDisplayPath.createDisplayPaths(path, nextPath: nil, type: .SectionPath, idx: retPaths.count))
                    retPaths.append(NOAForDisplayPath.createDisplayPaths(path, nextPath: nil, type: .ArrivalPath, idx: retPaths.count))
                    break
                }else{
                    retPaths.append(NOAForDisplayPath.createDisplayPaths(path, nextPath: nil, type: .SectionPath, idx: retPaths.count))
                    retPaths.append(NOAForDisplayPath.createDisplayPaths(path, nextPath: paths[i + 1], type: .TransitPath, idx: retPaths.count))
                }
            }
        }
        return retPaths
    }
    
}
