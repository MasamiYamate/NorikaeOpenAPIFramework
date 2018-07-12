//
//  NOARoutePath.swift
//  NorikaeOpenAPIFramework
//
//  Created by MasamiYamate on 2018/07/04.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit

@objcMembers open class NOARoutePath: NSObject {

    public var id          : Int        = -1                                        //Pathの通し番号
    public var lineName    : String     = ""                                        //路線名
    public var pathType    : NOAParameters.RoutePathTypes = .Unknown                //路線種別
    
    public var from    : String = ""    //出発地の名称
    public var fromExt : String = ""    //出発地拡張情報
    public var to      : String = ""    //到着地の名称
    public var toExt   : String = ""    //到着地拡張情報
    
    public var pathDist: Int = -1        //Pathの移動距離
    public var pathTime: Int = -1        //Pathの所要時間 (分単位)
    
    public var isTransfer  : Bool = false      //Pathの着地点での乗換判別フラグ
    public var transferTime: Int  = -1         //乗換待ち時間 (分単位)
    public var moveTime    : Int  = -1         //移動時間 (分単位)
    
    public var direction   : Int    = -1       //進行方向 1...正方向 2...逆方向
    public var seatName    : String = ""       //座席名称

    public var pathCost            : Int    = -1            //Pathの運賃
    public var isRoundTripDiscount : Bool   = false         //往復割引の適用
    public var routeCostId         : Int    = -1            //運賃ID
    public var ltdExpCost          : Int    = -1            //特急料金等の追加料金
    public var ltdExpGreenCost     : Int    = -1            //特急料金内のグリーン席分の金額
    public var ltdExpSleeperCost   : Int    = -1            //特急料金内の寝台分の金額
    
    public var seasonCostType      : Int   = -1        //季節料金区分 -1...なし 0...通常期 1...繁忙期
    public var isLtdExpDiscount    : Bool  = false     //特急乗継割引の有無
    public var ltdExpCostId        : Int   = 0         //特急料金ID
    
    public var isIcExist           : Bool  = false     //IC運賃の有無
    public var icCost              : Int   = -1        //IC運賃の料金 (IC運賃がない場合はきっぷ運賃)
    
    public var airLineName         : String = ""       //空路の場合の航空会社名
    
    public var strFromDate         : String?   //発日付
    public var strFromTime         : String?   //発時刻
    public var fromTimeType        : Int = 0   //発時刻タイプ
    
    public var strToDate           : String?   //着日付
    public var strToTime           : String?   //着時刻
    public var toTimeType          : Int = 0   //着時刻タイプ
    
    public var trainSignName       : String = ""        //列車名
    public var trainId             : String = ""        //列車識別子
    public var trainNo             : String = ""        //列車番号  ※ジョルダンが固有に付与した番号のため、運行管理システム上の番号とは異なる
    public var trainType           : String = ""        //列車種別
    
    public var lineColors          : [UIColor]  = []     //路線色
    public var isStripedPattern    : Bool       = false  //二色の路線色を横縞にするフラグ 新幹線などで用いる
    
    public var isHaveDiagram       : Bool = false       //路線時刻表の有無
    public var isUseDiagram        : Bool = false       //結果の時刻表適用
    
    public var pathCorpName        : String = ""        //路線の会社略称
    public var busCorpName         : String = ""        //バス会社名 ※バスのPathの場合
    
    public var boardingPosData     : String = ""        //乗車位置情報
    
    public var fromPlatformNo      : String = ""        //発駅の番線情報
    public var toPlatformNo        : String = ""        //着駅の番線情報
    
    public var fromLat : Double?       //発駅の緯度
    public var fromLon : Double?       //発駅の経度
    
    public var toLat : Double?         //着駅の緯度
    public var toLon : Double?         //着駅の経度
    
    public var pathCo2 : Int    = -1        //この区間で排出されるCo2量
    
    
    public init (_ dic:[String:Any]) {
        if let strId: String = dic["id"] as? String , let setId: Int = Int(strId) { id = setId }
        if let rosen: String = dic["rosen"] as? String { lineName = rosen }
        if let rosenSyubetu: String = dic["rosenSyubetu"] as? String , let intSyubetu: Int = Int(rosenSyubetu) {
            if let setType: NOAParameters.RoutePathTypes = NOAParameters.RoutePathTypes(rawValue: intSyubetu) {
                pathType = setType
            }
        }
        if let setFrom: String = dic["from"] as? String { from = setFrom }
        if let setFromExt: String = dic["fromExt"] as? String { fromExt = setFromExt }
        if let setTo: String = dic["to"] as? String { to = setTo }
        if let setToExt: String = dic["toExt"] as? String { toExt = setToExt }
        if let strKyori: String = dic["kyori"] as? String , let intKyori: Int = Int(strKyori) { pathDist = intKyori }
        if let strJikan: String = dic["jikan"] as? String , let intJikan: Int = Int(strJikan) { pathDist = intJikan }
        if let norikae: String = dic["norikae"] as? String , norikae == "1" { isTransfer = true }
        if let strMachi: String = dic["mati"] as? String , let intMachi: Int = Int(strMachi) { transferTime = intMachi }
        if let strIdou: String = dic["idou"] as? String , let intIdou: Int = Int(strIdou) { moveTime = intIdou }
        if let strDir: String = dic["direction"] as? String , let intDir: Int = Int(strDir) { direction = intDir }
        if let setSeatName: String = dic["seatName"] as? String { seatName = setSeatName }
        if let strUntin: String = dic["untin"] as? String , let intUntin: Int = Int(strUntin) { pathCost = intUntin }
        if let untinOufuku: String = dic["untinOufuku"] as? String , untinOufuku == "1" { isRoundTripDiscount = true }
        if let strUntinTuusan: String = dic["untinTuusan"] as? String , let intUntinTuusan: Int = Int(strUntinTuusan) { routeCostId = intUntinTuusan }
        if let strTokkyu: String = dic["tokkyu"] as? String , let intTokkyu: Int = Int(strTokkyu) { ltdExpCost = intTokkyu }
        if let strGreen: String = dic["tokkyuGreen"] as? String , let intGreen: Int = Int(strGreen) { ltdExpGreenCost = intGreen }
        if let strShindai: String = dic["tokkyuShindai"] as? String , let intShindai: Int = Int(strShindai) { ltdExpSleeperCost = intShindai }
        if let strKisetu: String = dic["tokkyuKisetu"] as? String , let intKisetu: Int = Int(strKisetu) { seasonCostType = intKisetu }
        if let tokkyuWaribiki: String = dic["tokkyuWaribiki"] as? String , tokkyuWaribiki == "1" { isLtdExpDiscount = true }
        if let strTokkyuTuusan: String = dic["tokkyuTuusan"] as? String , let intTokkyuTuusan: Int = Int(strTokkyuTuusan) { ltdExpCostId = intTokkyuTuusan }
        if let icExist: String = dic["icExist"] as? String , icExist == "1" { isIcExist = true }
        if let strIcUntin: String = dic["icUntin"] as? String , let intIcUntin: Int = Int(strIcUntin) { icCost = intIcUntin }
        if let airLine: String = dic["airLine"] as? String { airLineName = airLine }
        
        //時刻関連の設定
        if let tmpStrFromDate: String = dic["fromDate"] as? String {
            strFromDate = tmpStrFromDate
        }
        if let tmpFromTime: String = dic["fromTime"] as? String {
            strFromTime = tmpFromTime
        }
        if let strFType: String = dic["fromTimeType"] as? String , let intFType: Int = Int(strFType) { fromTimeType = intFType }
        
        if let tmpStrToDate: String = dic["toDate"] as? String {
            strToDate = tmpStrToDate
        }
        if let tmpStrToTime: String = dic["toTime"] as? String {
            strToTime = tmpStrToTime
        }
        if let strTType: String = dic["toTimeType"] as? String , let intTType: Int = Int(strTType) { toTimeType = intTType }
        
        if let tmpTrainName: String = dic["lineName"] as? String { trainSignName = tmpTrainName }
        if let tmpTrainId: String = dic["lineIndex"] as? String { trainId = tmpTrainId }
        if let selectLine: String = dic["selectLine"] as? String { trainNo = selectLine }
        if let lineType: String = dic["lineType"] as? String { trainType = lineType }
        
        //路線色の抽出
        if let lineColor: [String:Any] = dic["lineColor"] as? [String:Any] {
            if let lineColorType: String = lineColor["type"] as? String , lineColorType == "1" { isStripedPattern = true }
            if let colorCodes: [String] = lineColor["rgb"] as? [String] {
                lineColors = colorCodes.map{(code: String) -> UIColor in
                    return NOAColorExtension.hexToUiColor(hex: code)
                }
            }
        }
        
        if let haveDiagram: String = dic["haveDiagram"] as? String , haveDiagram == "1" { isHaveDiagram = true }
        if let useDiagram: String = dic["useDiagram"] as? String , useDiagram == "1" { isUseDiagram = true }
        if let rosenCorp: String = dic["rosenCorp"] as? String { pathCorpName = rosenCorp }
        if let busCorp: String = dic["busCorp"] as? String { busCorpName = busCorp }
        if let josyaText: String = dic["josyaText"] as? String { boardingPosData = josyaText }
        if let fromPlatform: String = dic["fromPlatform"] as? String { fromPlatformNo = fromPlatform }
        if let toPlatform: String = dic["toPlatform"] as? String { toPlatformNo = toPlatform }
        
        //緯度経度の抽出
        if let strFromX: String = dic["fromX"] as? String {
            fromLon = NOALatLonUtility.strDms2Deg(strFromX)
        }
        if let strFromY: String = dic["fromY"] as? String {
            fromLat = NOALatLonUtility.strDms2Deg(strFromY)
        }
        if let strToX: String = dic["toX"] as? String {
            toLon = NOALatLonUtility.strDms2Deg(strToX)
        }
        if let strToY: String = dic["toY"] as? String {
            toLat = NOALatLonUtility.strDms2Deg(strToY)
        }
        if let strCo2: String = dic["co2"] as? String , let intCo2: Int = Int(strCo2) {
            pathCo2 = intCo2
        }
    }
    
    
}
