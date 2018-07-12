//
//  NOARouteDataGetter.swift
//  NorikaeOpenAPIFramework
//
//  Created by MasamiYamate on 2018/07/05.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit

class NOARouteDataGetter {

    static let share: NOARouteDataGetter = NOARouteDataGetter()
    
    
    func routeSearch(eki1: String , eki2: String , kbn1: String? , kbn2: String? , date: Date?) -> NOARoute? {
        guard let baseUrl: String = NOAParameters.endPoint else {
            NOAPrint.debugPrint("\(self) EndPoint is not set")
            return nil
        }
        guard let accessKey: String = NOAParameters.accessKey else {
            NOAPrint.debugPrint("\(self) AccessKey is not set")
            return nil
        }
        
        let searchDate: String = getSearchDate(date)
        
        guard let encEki1: String = eki1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        guard let encEki2: String = eki2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }

        var strReqUrl: String = "\(baseUrl)sr?ak=\(accessKey)&eki1=\(encEki1)&eki2=\(encEki2)&date=\(searchDate)"
        
        if let setKbn1: String = kbn1 {
            strReqUrl = "\(strReqUrl)&kbn1=\(setKbn1)"
        }
        if let setKbn2: String = kbn2 {
            strReqUrl = "\(strReqUrl)&kbn2=\(setKbn2)"
        }
        
        guard let reqUrl:URL = URL(string: strReqUrl) else { return nil }
        guard let response: Data = requestUrl(reqUrl) else { return nil }
        guard let dics: [String:Any] = data2JsonSerializeData(response) else { return nil }
        
        guard let norikaeBizApiResult: [String:Any] = dics["NorikaeBizApiResult"] as? [String:Any] else { return nil }
        guard let header: [String:Any] = norikaeBizApiResult["head"] as? [String:Any] else { return nil }
        guard let body: [String:Any] = norikaeBizApiResult["body"] as? [String:Any] else { return nil }
        guard let strErrCode: String = header["errorCode"] as? String else { return nil }
        guard let errCode: Int = Int(strErrCode) else { return nil }
        if errCode != 0 {
            NOAPrint.debugPrint("\(self) ErrCode:\(errCode)")
            return nil
        }
        return NOARoute(body)
    }
    
    private func getSearchDate (_ date:Date?) -> String {
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "ja_JP")
        fmt.date(from: "yyyyMMdd")
        var searchDate:String = fmt.string(from: Date())
        if let anyDate:Date = date {
            searchDate = fmt.string(from:anyDate)
        }
        return searchDate
    }
    
    private func data2JsonSerializeData (_ data:Data) -> [String:Any]? {
        var retJsonDics:[String:Any]? = nil
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            if let items:[String:Any] = json as? [String:Any] {
                retJsonDics = items
            }
        } catch {
            NOAPrint.debugPrint("\(self) Parse Error ErrorCode:\(error)")
        }
        return retJsonDics
    }
    
    private func requestUrl (_ reqUrl: URL) -> Data? {
        var retData:Data?
        let semaphore = DispatchSemaphore.init(value: 0)
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: reqUrl) { (data: Data?, res: URLResponse?, err: Error?) in
            retData = data
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return retData
    }
    
    
}
