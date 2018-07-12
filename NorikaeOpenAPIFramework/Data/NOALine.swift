//
//  NOALine.swift
//  NorikaeOpenAPIFramework
//
//  Created by MasamiYamate on 2018/07/04.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit

@objcMembers open class NOALine: NSObject , NSCoding {

    public var name         : String                                //候補の名称
    public var company      : String                                //候補の所属する会社名称
    public var type         : NOAParameters.LineTyps = .Unknown     //候補の区分
    public var isDiagram    : Bool = false                          //時刻表データの有無を示すフラグ
    public var createDate   : Date                                  //Objectの生成日
    
    public init(setName: String , setCompany: String , setKubun: String , setDiaframFlg: String) {
        name = setName
        company = setCompany
        if let tmpType: NOAParameters.LineTyps = NOAParameters.LineTyps(rawValue: setKubun) {
            type = tmpType
        }
        if setDiaframFlg == "1" {
            isDiagram = true
        }
        createDate = Date()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "NAME")
        aCoder.encode(company, forKey: "COMPANY")
        aCoder.encode(type, forKey: "TYPE")
        aCoder.encode(isDiagram, forKey: "DIAGRAMFLG")
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
        
        if let decodeType: NOAParameters.LineTyps = aDecoder.decodeObject(forKey: "TYPE") as? NOAParameters.LineTyps {
            type = decodeType
        }
        
        if let decodeDate: Date = aDecoder.decodeObject(forKey: "DATE") as? Date {
            createDate = decodeDate
        }else{
            createDate = Date()
        }
    }
    
    /// DictionaryからNOALineObjectの配列に変換します
    ///
    /// - Parameter dics: 検索結果のDictionary
    /// - Returns: 検索結果のNOALinesの配列
    public class func dic2NOALines (_ dics: [String:Any]) -> [NOALine]? {
        guard let norikaeBizApiResult: [String:Any] = dics["NorikaeBizApiResult"] as? [String:Any] else { return nil }
        guard let header: [String:Any] = norikaeBizApiResult["head"] as? [String:Any] else { return nil }
        guard let body: [String:Any] = norikaeBizApiResult["body"] as? [String:Any] else { return nil }
        guard let strErrCode: String = header["errorCode"] as? String else { return nil }
        guard let errCode: Int = Int(strErrCode) else { return nil }
        if errCode != 0 {
            NOAPrint.debugPrint("\(self) ErrCode:\(errCode)")
            return nil
        }
        guard let rosens: [[String:Any]] = body["rosen"] as? [[String:Any]] else { return nil }
        let retRosens = rosens.map{(rosen: [String:Any]) -> NOALine in
            var name: String = "" , company: String = "" , kubun: String = "" , diagram: String = "0"
            if let tmpName: String = rosen["name"] as? String {
                name = tmpName
            }
            if let tmpCompany: String = rosen["company"] as? String {
                company = tmpCompany
            }
            if let tmpkubun: String = rosen["kubun"] as? String {
                kubun = tmpkubun
            }
            if let tmpDiagram: String = rosen["diagram"] as? String {
                diagram = tmpDiagram
            }
            return NOALine(setName: name, setCompany: company, setKubun: kubun, setDiaframFlg: diagram)
        }
        return retRosens
    }

}
