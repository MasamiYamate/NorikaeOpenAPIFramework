//
//  NOADataGetter.swift
//  NorikaeOpenAPIFramework
//
//  Created by MasamiYamate on 2018/07/04.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit

class NOADataGetter {
    
    static let share: NOADataGetter = NOADataGetter()
    
    /// 駅名検索を行います
    ///
    /// - Parameters:
    ///   - keyword: 検索キーワード
    ///   - mode: 0...前方一致検索 1...完全一致優先検索
    /// - Returns: 検索結果
    func searchStations(_ keyword: String , mode: Int) -> [NOAStation]? {
        guard let baseUrl:String = NOAParameters.endPoint else {
            NOAPrint.debugPrint("\(self) EndPoint is not set")
            return nil
        }
        guard let accessKey:String = NOAParameters.accessKey else {
            NOAPrint.debugPrint("\(self) AccessKey is not set")
            return nil
        }
        guard let encKeyWord:String = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        var searchMode = 0
        //完全一致の場合のみsearchModeを変更させます
        if mode == 1 { searchMode = mode }
        let strReqUrl:String = "\(baseUrl)sen?eki1=\(encKeyWord)&opt1=\(searchMode)&ak=\(accessKey)"
        guard let reqUrl:URL = URL(string: strReqUrl) else { return nil }
        guard let response: Data = requestUrl(reqUrl) else { return nil }
        guard let dics: [String:Any] = data2JsonSerializeData(response) else { return nil }
        return NOAStation.dic2NOAStations(dics)
    }
    
    /// 路線名検索を行います
    ///
    /// - Parameters:
    ///   - keyword: 検索キーワード
    ///   - mode: 0...前方一致検索 1...完全一致優先検索
    /// - Returns: 検索結果
    func searchLineNames(_ keyword: String , mode: Int) -> [NOALine]? {
        guard let baseUrl:String = NOAParameters.endPoint else {
            NOAPrint.debugPrint("\(self) EndPoint is not set")
            return nil
        }
        guard let accessKey:String = NOAParameters.accessKey else {
            NOAPrint.debugPrint("\(self) AccessKey is not set")
            return nil
        }
        guard let encKeyWord:String = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        var searchMode = 0
        //完全一致の場合のみsearchModeを変更させます
        if mode == 1 { searchMode = mode }
        let strReqUrl:String = "\(baseUrl)srn?rsn=\(encKeyWord)&opt1=\(searchMode)&ak=\(accessKey)"
        guard let reqUrl:URL = URL(string: strReqUrl) else { return nil }
        guard let response: Data = requestUrl(reqUrl) else { return nil }
        guard let dics: [String:Any] = data2JsonSerializeData(response) else { return nil }
        return NOALine.dic2NOALines(dics)
    }

    /// 駅の接続路線名一覧を取得します
    ///
    /// - Parameters:
    ///   - keyword: 検索キーワード
    ///   - mode: 0...前方一致検索 1...完全一致優先検索
    /// - Returns: 検索結果
    func searchStationConnectionLines(_ keyword: String , mode: Int) -> [NOALine]? {
        guard let baseUrl:String = NOAParameters.endPoint else {
            NOAPrint.debugPrint("\(self) EndPoint is not set")
            return nil
        }
        guard let accessKey:String = NOAParameters.accessKey else {
            NOAPrint.debugPrint("\(self) AccessKey is not set")
            return nil
        }
        guard let encKeyWord:String = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        var searchMode = 0
        //完全一致の場合のみsearchModeを変更させます
        if mode == 1 { searchMode = mode }
        let strReqUrl:String = "\(baseUrl)ger?eki1=\(encKeyWord)&opt1=\(searchMode)&ak=\(accessKey)"
        guard let reqUrl:URL = URL(string: strReqUrl) else { return nil }
        guard let response: Data = requestUrl(reqUrl) else { return nil }
        guard let dics: [String:Any] = data2JsonSerializeData(response) else { return nil }
        return NOALine.dic2NOALines(dics)
    }

    /// 路線の所属駅を取得します
    ///
    /// - Parameter keyword: 検索キーワード
    /// - Returns: 検索結果
    func searchStationBelongingLine(_ keyword: String) -> [NOAStation]? {
        guard let baseUrl:String = NOAParameters.endPoint else {
            NOAPrint.debugPrint("\(self) EndPoint is not set")
            return nil
        }
        guard let accessKey:String = NOAParameters.accessKey else {
            NOAPrint.debugPrint("\(self) AccessKey is not set")
            return nil
        }
        guard let encKeyWord:String = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        let strReqUrl:String = "\(baseUrl)gre?rsn=\(encKeyWord)&ak=\(accessKey)"
        guard let reqUrl:URL = URL(string: strReqUrl) else { return nil }
        guard let response: Data = requestUrl(reqUrl) else { return nil }
        guard let dics: [String:Any] = data2JsonSerializeData(response) else { return nil }
        return NOAStation.dic2NOAStations(dics)
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
