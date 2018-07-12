//
//  NOAStation.swift
//  NorikaeOpenAPIFramework
//
//  Created by MasamiYamate on 2018/07/04.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit

@objcMembers open class NOAStation: NSObject , NSCoding {
    
    public var name         : String                                    //候補の名称
    public var company      : String                                    //候補の所属する会社名称
    public var type         : NOAParameters.StationTypes = .Unknown     //候補の区分
    public var createDate   : Date                                      //Objectの生成日
    
    public init (setName: String , setCompany: String , setKubun: String) {
        name = setName
        company = setCompany
        if let tmpType = NOAParameters.StationTypes(rawValue: setKubun) {
            type = tmpType
        }
        createDate = Date()
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "NAME")
        aCoder.encode(company, forKey: "COMPANY")
        aCoder.encode(type, forKey: "TYPE")
        aCoder.encode(createDate, forKey: "DATE")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        if let decodeName: String = aDecoder.decodeObject(forKey: "NAME") as? String {
            name = decodeName
        }else{
            name = ""
        }
        
        if let decodeCompany: String = aDecoder.decodeObject(forKey: "COMPANY") as? String {
            company = decodeCompany
        }else{
            company = ""
        }
        
        if let decodeType: NOAParameters.StationTypes = aDecoder.decodeObject(forKey: "TYPE") as? NOAParameters.StationTypes {
            type = decodeType
        }
        
        if let decodeDate: Date = aDecoder.decodeObject(forKey: "DATE") as? Date {
            createDate = decodeDate
        }else{
            createDate = Date()
        }
    }
    
    /// DictionaryからNOAStationObjectの配列に変換します
    ///
    /// - Parameter dics: 検索結果のDictionary
    /// - Returns: 検索結果のNOAStationの配列
    public class func dic2NOAStations (_ dics: [String:Any]) -> [NOAStation]? {
        guard let norikaeBizApiResult: [String:Any] = dics["NorikaeBizApiResult"] as? [String:Any] else { return nil }
        guard let header: [String:Any] = norikaeBizApiResult["head"] as? [String:Any] else { return nil }
        guard let body: [String:Any] = norikaeBizApiResult["body"] as? [String:Any] else { return nil }
        guard let strErrCode: String = header["errorCode"] as? String else { return nil }
        guard let errCode: Int = Int(strErrCode) else { return nil }
        if errCode != 0 {
            NOAPrint.debugPrint("\(self) ErrCode:\(errCode)")
            return nil
        }
        guard let ekis: [[String:Any]] = body["eki"] as? [[String:Any]] else { return nil }
        let retEkis = ekis.map{(eki: [String:Any]) -> NOAStation in
            var name    : String = "" , company : String = "" , kubun   : String = ""
            if let tmpName: String = eki["name"] as? String {
                name = tmpName
            }
            if let tmpCompany: String = eki["company"] as? String {
                company = tmpCompany
            }
            if let tmpKubun: String = eki["kubun"] as? String {
                kubun = tmpKubun
            }
            return NOAStation(setName: name, setCompany: company, setKubun: kubun)
        }
        return retEkis
    }
    
    
}
