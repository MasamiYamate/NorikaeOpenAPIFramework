//
//  NOARoute.swift
//  NorikaeOpenAPIFramework
//
//  Created by MasamiYamate on 2018/07/05.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit

@objcMembers open class NOARoute: NSObject {
    
    public var jrdUrl   : String            = ""                //乗換案内へのリンク
    public var routeCnt : Int               = -1                //ルートの総数
    public var storeData: String            = ""                //経路再検索用の文字列
    public var routes   : [NOARouteInfo]    = []                //ルートオブジェクトが収まる配列
    
    public init (_ body: [String:Any]) {
        if let tmpJrdUrl: String = body["jrdurl"] as? String { jrdUrl = tmpJrdUrl }
        if let tmpStrNum: String = body["num"] as? String , let tmpNum: Int = Int(tmpStrNum) { routeCnt = tmpNum }
        if let tmpStoreData: String = body["storeData"] as? String { storeData = tmpStoreData }
        if routeCnt != 0 , let setRoutes: [[String:Any]] = body["route"] as? [[String:Any]] {
            routes = setRoutes.map{(route: [String:Any]) -> NOARouteInfo in
                return NOARouteInfo(route)
            }
        }
    }
    
}
