//
//  NOAForDisplayPath.swift
//  NorikaeOpenAPIFramework
//
//  Created by MasamiYamate on 2018/07/06.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit

@objcMembers open class NOAForDisplayPath: NSObject {

    public var pathType: NOAParameters.DisplayRoutePathType = .UnknownPath //パスの種別
    
    public var pathNo: Int = 0 //DisplayPathの通し番号
    
    public var currentLineName : String = ""       //路線名
    public var currentPointName: String = ""       //ポイント名称
    public var currentPointExt : String = ""       //ポイント拡張情報
    
    public var nextLineName    : String = ""       //次の路線名
    public var nextPointName   : String = ""       //次のポイント名称
    public var nextPointExt    : String = ""       //ポイント拡張情報
    
    public var currentPointLat: Double?    //緯度
    public var currentPointLon: Double?    //経度
    
    public var nextPointLat: Double?    //緯度
    public var nextPointLon: Double?    //経度
    
    public var pathDist: Int = -1        //Pathの移動距離
    public var pathTime: Int = -1        //Pathの所要時間 (分単位)
    
    public var isTransfer  : Bool = false      //Pathでの乗換判別フラグ
    public var transferTime: Int  = -1         //乗換待ち時間 (分単位)
    public var moveTime    : Int  = -1         //移動時間 (分単位)
    
    public var direction   : Int    = -1       //進行方向 1...正方向 2...逆方向
    public var seatName    : String = ""       //座席名称
    
    public var pathCost            : Int    = -1            //Pathの運賃
    public var isIcExist           : Bool   = false         //IC運賃の有無
    public var icCost              : Int    = -1            //IC運賃の料金 (IC運賃がない場合はきっぷ運賃)
    
    public var isRoundTripDiscount : Bool   = false         //往復割引の適用
    public var routeCostId         : Int    = -1            //運賃ID
    public var ltdExpCost          : Int    = -1            //特急料金等の追加料金
    public var ltdExpGreenCost     : Int    = -1            //特急料金内のグリーン席分の金額
    public var ltdExpSleeperCost   : Int    = -1            //特急料金内の寝台分の金額
    
    public var trainSignName       : String = ""        //列車名
    public var trainType           : String = ""        //列車種別
    
    public var boardingPosData     : String = ""        //乗車位置情報
    
    public var fromPlatformNo      : String = ""        //発駅の番線情報
    public var toPlatformNo        : String = ""        //着駅の番線情報
    
    public var currentLineColor: [UIColor]      = []            //現在の路線の色
    public var isCurrentStripedPattern: Bool    = false         //現在の路線色を横縞にするフラグ
    
    public var nextLineColor: [UIColor]     = []            //次の路線の色
    public var isNextStripedPattern: Bool   = false         //次の路線色を横縞にするフラグ
    
    public override init() {
        super.init()
    }
    
    /// 指定したタイプのNOAForDisplayPathを生成します
    ///
    /// - Parameters:
    ///   - path: 現在のパス
    ///   - nextPath: 次のパスデータ ※Optional
    ///   - type: NOAParameters.DisplayRoutePathType
    ///   - idx: Pathの生成番号
    /// - Returns: NOAForDisplayPath
    public class func createDisplayPaths (_ path: NOARoutePath , nextPath: NOARoutePath? , type: NOAParameters.DisplayRoutePathType , idx: Int) -> NOAForDisplayPath {
        let obj = NOAForDisplayPath.init()
        obj.pathType = type
        obj.pathNo   = idx
        
        switch type {
        case .DeparturePath:
            self.createDeparturePath(obj, path: path)
        case .ArrivalPath:
            self.createArrivalPath(obj, path: path)
        case .TransitPath:
            if nextPath != nil {
                self.createTransitPath(obj, currentPath: path, nextPath: nextPath!)
            }
        case.SectionPath:
            self.createSectionPath(obj, path: path)
        default:
            break
        }
        return obj
    }

    /// 始発駅のパスを生成します
    ///
    /// - Parameters:
    ///   - obj: 表示用パスデータ
    ///   - path: 現在のパスデータ
    private class func createDeparturePath (_ obj: NOAForDisplayPath , path: NOARoutePath) {
        obj.currentLineName     = path.lineName
        obj.currentPointName    = path.from
        obj.currentPointExt     = path.fromExt
        
        obj.currentPointLat     = path.fromLat
        obj.currentPointLon     = path.fromLon

        obj.fromPlatformNo          = path.fromPlatformNo
        obj.currentLineColor        = path.lineColors
        obj.isCurrentStripedPattern = path.isStripedPattern
    }
    
    /// 終着駅のパスを生成します
    ///
    /// - Parameters:
    ///   - obj: 表示用パスデータ
    ///   - path: 現在のパスデータ
    private class func createArrivalPath (_ obj: NOAForDisplayPath , path: NOARoutePath) {
        obj.currentLineName     = path.lineName
        obj.currentPointName    = path.to
        obj.currentPointExt     = path.toExt
        
        obj.currentPointLat = path.toLat
        obj.currentPointLon = path.toLon
        
        obj.fromPlatformNo          = path.toPlatformNo
        obj.currentLineColor        = path.lineColors
        obj.isCurrentStripedPattern = path.isStripedPattern
    }
    
    /// 乗継駅のパスを生成します
    ///
    /// - Parameters:
    ///   - obj: 表示用パスデータ
    ///   - currentPath: 現在のパスデータ
    ///   - nextPath: 次のパスデータ
    private class func createTransitPath (_ obj: NOAForDisplayPath , currentPath: NOARoutePath , nextPath: NOARoutePath) {
        obj.currentLineName     = currentPath.lineName
        obj.currentPointName    = currentPath.to
        obj.currentPointExt     = currentPath.toExt
        obj.currentPointLat     = currentPath.toLat
        obj.currentPointLon     = currentPath.toLon
        
        obj.nextLineName        = nextPath.lineName
        //名称が違う乗継の際のみ乗継駅の別名を収めます
        if currentPath.to != nextPath.from {
            obj.nextPointName   = nextPath.from
            obj.nextPointExt    = nextPath.fromExt
            obj.nextPointLat    = nextPath.fromLat
            obj.nextPointLon    = nextPath.fromLon
        }
        
        //乗換フラグの設定 true...乗降の必要な乗換 , false...乗降不要な乗換
        obj.isTransfer = currentPath.isTransfer
        obj.transferTime = currentPath.transferTime
        obj.moveTime = currentPath.moveTime
        
        //乗降位置を取得します
        obj.toPlatformNo    = currentPath.toPlatformNo
        obj.fromPlatformNo  = nextPath.fromPlatformNo
        obj.boardingPosData = nextPath.boardingPosData
        
        obj.currentLineColor        = currentPath.lineColors
        obj.isCurrentStripedPattern = currentPath.isStripedPattern
        
        obj.nextLineColor           = nextPath.lineColors
        obj.isNextStripedPattern    = nextPath.isStripedPattern
    }
    
    /// セクションのパスを生成します
    ///
    /// - Parameters:
    ///   - obj: 表示用パスデータ
    ///   - path: 現在のパスデータ
    private class func createSectionPath (_ obj: NOAForDisplayPath , path: NOARoutePath) {
        obj.currentLineName = path.lineName
        obj.pathDist = path.pathDist
        obj.pathTime = path.pathTime
        
        obj.direction   = path.direction
        obj.seatName    = path.seatName
        
        obj.pathCost            = path.pathCost
        obj.isIcExist           = path.isIcExist
        obj.isRoundTripDiscount = path.isRoundTripDiscount
        obj.routeCostId         = path.routeCostId
        obj.ltdExpCost          = path.routeCostId
        obj.ltdExpGreenCost     = path.ltdExpGreenCost
        obj.ltdExpSleeperCost   = path.ltdExpSleeperCost
        obj.trainSignName       = path.trainSignName
        obj.trainType           = path.trainType
        
        obj.currentLineColor        = path.lineColors
        obj.isCurrentStripedPattern = path.isStripedPattern
    }
    
}
