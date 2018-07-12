//
//  NOAParameters.swift
//  NorikaeOpenAPIFramework
//
//  Created by MasamiYamate on 2018/07/04.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit

@objcMembers open class NOAParameters: NSObject {
    
    static var endPoint :String?    = nil
    static var accessKey:String?    = nil

    public enum LineTyps: String {
        case Airplane       = "A" //飛行機
        case Bus            = "B" //バス
        case Car            = "C" //自動車
        case SeaRoute       = "F" //船、航路
        case ChargeLtdExp   = "E" //有料特急列車
        case ChargeExp      = "Q" //有料急行列車
        case Liner          = "L" //ライナー
        case Tram           = "K" //路面電車
        case Shinkansen     = "S" //新幹線
        case Railway        = "-" //在来線
        case Walk           = "W" //徒歩
        case Unknown        = ""  //不明なタイプ
    }
    
    public enum StationTypes: String {
        case Railway    = "R"   //鉄道
        case Airportbus = "P"   //空港連絡バス
        case Highwaybus = "H"   //高速バス
        case Bus        = "B"   //路線バス
        case Ferry      = "F"   //フェリー
        case Unknown    = ""    //不明なタイプ
    }
    
    public enum RoutePathTypes: Int {
        case JRLocal        = 0     //JR在来線
        case Local          = 1     //私鉄在来線
        case Metro          = 2     //地下鉄
        case Tram           = 3     //路面電車
        case Walk           = 4     //徒歩
        case Bus            = 5     //バス
        case Airplane       = 6     //飛行機
        case SeaRoute       = 7     //船、航路
        case ChargeLtdExp   = 8     //有料特急列車
        case Shinkansen     = 9     //新幹線
        case SleeperTrain   = 10    //寝台列車
        case ChargeExp      = 11    //有料急行列車
        case HighwayBus     = 12    //高速バス
        case Car            = 13    //自動車
        case Airportbus     = 14    //空港連絡バス
        case Unknown        = 99    //不明なタイプ
    }
    
    public enum DisplayRoutePathType: Int {
        case DeparturePath = 0      //始発駅のパス
        case TransitPath   = 1      //経由駅のパス
        case ArrivalPath   = 2      //到着駅のパス
        case SectionPath   = 3      //区間パス
        case UnknownPath   = 99     //不明なパス
    }
        
}
