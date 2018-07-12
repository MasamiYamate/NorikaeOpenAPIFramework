//
//  NOALatLonUtility.swift
//  NorikaeOpenAPIFramework
//
//  Created by MasamiYamate on 2018/07/06.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit

class NOALatLonUtility {

    class func strDms2Deg (_ dms:String) -> Double? {
        let split:[String] = dms.components(separatedBy: ",")
        if split.count == 4 {
            let strH = split[0]
            let strM = split[1]
            let strS = "\(split[2]).\(split[3])"
            if let doubleH: Double = Double(strH) , let doubleM: Double = Double(strM) , let doubbleS: Double = Double(strS) {
                return NOALatLonUtility.dms2Deg(h: doubleH, m: doubleM, sec: doubbleS)
            }
        }
        return nil
    }

    class func dms2Deg (h:Double , m:Double , sec:Double) -> Double {
        return h + m / 60.0 + sec / 60.0 / 60.0
    }
    
}
