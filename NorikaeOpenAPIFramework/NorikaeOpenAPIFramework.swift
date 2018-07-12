//
//  NorikaeOpenAPIFramework.swift
//  NorikaeOpenAPIFramework
//
//  Created by MasamiYamate on 2018/07/06.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit

@objcMembers open class NorikaeOpenAPIFramework : NSObject {
    
    //Share instance
    public static let share:NorikaeOpenAPIFramework = NorikaeOpenAPIFramework()
    
    public override init() {
        super.init()
    }
    
    /// Set access Key
    ///
    /// - Parameter key: Access key string
    public func setAccessKey (_ key: String) {
        NOAParameters.accessKey = key
    }
    
    /// Set end point
    ///
    /// - Parameter uri: URI such as a VPS to be bridged
    public func setEndPoint (_ uri: String) {
        NOAParameters.endPoint = uri
    }
    
    /// Search by station name
    ///
    /// - Parameters:
    ///   - keyword: Station name you want to search
    ///   - mode: SearchMode 0...Forward match search 1...Exact match priority search
    /// - Returns: NOAStation Array
    public func searchStations (_ keyword: String , mode: Int) -> [NOAStation]? {
        return NOADataGetter.share.searchStations(_:keyword, mode:mode)
    }
    
    /// Search by line name
    ///
    /// - Parameters:
    ///   - keyword: Line name you want to search
    ///   - mode: SearchMode 0...Forward match search 1...Exact match priority search
    /// - Returns: NOALine Array
    public func searchLineNames (_ keyword: String , mode: Int) -> [NOALine]? {
        return NOADataGetter.share.searchLineNames(_:keyword, mode:mode)
    }

    /// Search the name of the route to be connected at the station
    ///
    /// - Parameters:
    ///   - keyword: Station name you want to search
    ///   - mode: SearchMode 0...Forward match search 1...Exact match priority search
    /// - Returns: NOALine Array
    public func searchTheNameOfTheLineConnectingToTheStation (_ keyword: String, mode: Int) -> [NOALine]? {
        return NOADataGetter.share.searchStationConnectionLines(_:keyword, mode:mode)
    }
    
    /// Search for the station on the route
    ///
    /// - Parameter keyword: Line name you want to search
    /// - Returns: NOAStation Array
    public func searchForTheStationOnTheLine (_ keyword: String) -> [NOAStation]? {
        return NOADataGetter.share.searchStationBelongingLine(_:keyword)
    }
    
    /// Perform route search
    ///
    /// - Parameters:
    ///   - eki1: Departure point name
    ///   - eki2: Arrival point name
    ///   - kbn1: Departure point type
    ///   - kbn2: Arrival point type
    ///   - date: Search date
    /// - Returns: NOARouteInfo...Route result ※Optional
    @nonobjc public func routeSearch (eki1: String , eki2: String , kbn1: String? , kbn2: String? , date: Date?) -> NOARoute? {
        return NOARouteDataGetter.share.routeSearch(eki1:eki1 , eki2:eki2 , kbn1:kbn1 , kbn2:kbn2 , date:date)
    }
    
    /// Perform route search
    ///
    /// - Parameters:
    ///   - eki1: Departure point name
    ///   - eki2: Arrival point name
    ///   - kbn1: Departure point type
    ///   - kbn2: Arrival point type
    ///   - date: Search date
    /// - Returns: NOARouteInfo...Route result ※Optional
    public func routeSearch (eki1: String , eki2: String , kbn1: String , kbn2: String , date: Date) -> NOARoute? {
        return NOARouteDataGetter.share.routeSearch(eki1:eki1 , eki2:eki2 , kbn1:kbn1 , kbn2:kbn2 , date:date)
    }
    
    /// Perform route search
    ///
    /// - Parameters:
    ///   - eki1: Departure point name
    ///   - eki2: Arrival point name
    ///   - kbn1: Departure point type
    ///   - kbn2: Arrival point type
    /// - Returns: NOARouteInfo...Route result ※Optional
    public func routeSearch (eki1: String , eki2: String , kbn1: String , kbn2: String) -> NOARoute? {
        return NOARouteDataGetter.share.routeSearch(eki1:eki1 , eki2:eki2 , kbn1:kbn1 , kbn2:kbn2 , date:nil)
    }
    
    /// Perform route search
    ///
    /// - Parameters:
    ///   - eki1: Departure point name
    ///   - eki2: Arrival point name
    ///   - date: Search date
    /// - Returns: NOARouteInfo...Route result ※Optional
    public func routeSearch (eki1: String , eki2: String , date: Date) -> NOARoute? {
        return NOARouteDataGetter.share.routeSearch(eki1:eki1 , eki2:eki2 , kbn1:nil , kbn2:nil , date:date)
    }
    
    /// Perform route search
    ///
    /// - Parameters:
    ///   - departure: Departure NOAStation object
    ///   - arrival: Arrival NOAStation object
    ///   - date: Search date
    /// - Returns: NOARoute
    public func routeSearch (departure:NOAStation , arrival:NOAStation , date:Date) -> NOARoute? {
        let deptName        : String = departure.name
        let deptKubun       : String = departure.type.rawValue
        let arrivalName     : String = arrival.name
        let arrivalKubun    : String = arrival.type.rawValue

        return NOARouteDataGetter.share.routeSearch(eki1: deptName, eki2: arrivalName, kbn1: deptKubun, kbn2: arrivalKubun, date: date)
    }
    
    /// Perform route search
    ///
    /// - Parameters:
    ///   - departure: Departure NOAStation object
    ///   - arrival: Arrival NOAStation object
    /// - Returns: NOARoute
    public func routeSearch (departure:NOAStation , arrival:NOAStation) -> NOARoute? {
        let deptName        : String = departure.name
        let deptKubun       : String = departure.type.rawValue
        let arrivalName     : String = arrival.name
        let arrivalKubun    : String = arrival.type.rawValue
        
        return NOARouteDataGetter.share.routeSearch(eki1: deptName, eki2: arrivalName, kbn1: deptKubun, kbn2: arrivalKubun, date: nil)
    }
    
    
}
