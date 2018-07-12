//
//  RouteResultViewController.swift
//  NorikaeOpenAPISampleApp
//
//  Created by MasamiYamate on 2018/07/06.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit
import NorikaeOpenAPIFramework


class RouteResultViewController: UIViewController {
    
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var LoadingIcon: UIActivityIndicatorView!
    
    @IBOutlet weak var RouteResultTableView: UITableView!
    
    @IBAction func backBtnAct(_ sender: UIButton) {
        Parameters.departurePoint = nil
        Parameters.arrivalPoint = nil
    }
    
    var openApi:NorikaeOpenAPIFramework = NorikaeOpenAPIFramework.share
    var routeData:NOARoute?
    var routeDisplayPaths:[NOAForDisplayPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RouteResultTableView.isHidden = true
        RouteResultTableView.delegate = self
        RouteResultTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.routeSearchAct()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func routeSearchAct () {
        if let dpt:NOAStation = Parameters.departurePoint , let arriv:NOAStation = Parameters.arrivalPoint {
            routeData = openApi.routeSearch(departure: dpt, arrival: arriv)
            
            if let firstRoute: NOARouteInfo = routeData?.routes.first {
                routeDisplayPaths = firstRoute.routeDisplayPaths
            }

            DispatchQueue.main.async {
                self.LoadingIcon.isHidden = true
                self.RouteResultTableView.isHidden = false
                self.RouteResultTableView.reloadData()
            }
        }
    }

}

extension RouteResultViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //ジョルダンの検索結果ページへの遷移Cellは必須のためPathsCountに追加する
        return routeDisplayPaths.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: NorikaeCustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NorikaeCustomTableViewCell") as? NorikaeCustomTableViewCell {
            if indexPath.row < routeDisplayPaths.count {
                let obj: NOAForDisplayPath = routeDisplayPaths[indexPath.row]
                switch obj.pathType {
                case .DeparturePath:
                    setUpDepartureCell(cell: cell, obj: obj)
                case .SectionPath:
                    setUpSectionCell(cell: cell, obj: obj)
                case .ArrivalPath:
                    setUpArrivalCell(cell: cell, obj: obj)
                case .TransitPath:
                    setUpTransitCell(cell: cell, obj: obj)
                default:
                    break
                }
            }else{
                let defaultCell: UITableViewCell = UITableViewCell()
                defaultCell.textLabel?.text = "→ ジョルダン乗換案内を開く"
                defaultCell.textLabel?.font = defaultCell.textLabel?.font.withSize(12.0)
                return defaultCell
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= routeDisplayPaths.count {
            if let tmpJrdUrl: String = routeData?.jrdUrl , let reqUrl: URL = URL(string: tmpJrdUrl) {
                if UIApplication.shared.canOpenURL(reqUrl) {
                    UIApplication.shared.open(reqUrl, options: [:], completionHandler: nil)
                }
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// 始発駅セルを表示する
    ///
    /// - Parameters:
    ///   - cell: NorikaeCustomTableViewCell
    ///   - obj: NOAForDisplayPath
    func setUpDepartureCell (cell: NorikaeCustomTableViewCell , obj: NOAForDisplayPath) {
        let pointName: String = obj.currentPointName
        cell.DataLabel.text = pointName
        setUpLineColor(cell: cell, obj: obj)
    }
    
    /// 区間セルを表示する
    ///
    /// - Parameters:
    ///   - cell: NorikaeCustomTableViewCell
    ///   - obj: NOAForDisplayPath
    func setUpSectionCell (cell: NorikaeCustomTableViewCell , obj: NOAForDisplayPath) {
        let lineName: String = obj.currentLineName
        cell.DataLabel.text = lineName
        
        cell.DataLabel.font = cell.DataLabel.font.withSize(12.0)
        
        
        setUpLineColor(cell: cell, obj: obj)
        cell.PointCircle.isHidden = true
    }
    
    /// 乗継セルを表示する
    ///
    /// - Parameters:
    ///   - cell: NorikaeCustomTableViewCell
    ///   - obj: NOAForDisplayPath
    func setUpTransitCell (cell: NorikaeCustomTableViewCell , obj: NOAForDisplayPath) {
        let pointName: String = obj.currentPointName
        cell.DataLabel.text = pointName
        setUpLineColor(cell: cell, obj: obj)
    }
    
    /// 終着駅セルを表示する
    ///
    /// - Parameters:
    ///   - cell: NorikaeCustomTableViewCell
    ///   - obj: NOAForDisplayPath
    func setUpArrivalCell (cell: NorikaeCustomTableViewCell , obj: NOAForDisplayPath) {
        let pointName: String = obj.currentPointName
        cell.DataLabel.text = pointName
        setUpLineColor(cell: cell, obj: obj)
    }
    
    /// 路線色を設定する
    ///
    /// - Parameters:
    ///   - cell: NorikaeCustomTableViewCell
    ///   - obj: NOAForDisplayPath
    func setUpLineColor (cell: NorikaeCustomTableViewCell , obj: NOAForDisplayPath) {
        let lineColors = obj.currentLineColor
        if let firstColor: UIColor = lineColors.first {
            cell.currentFirstLineColorView.backgroundColor  = firstColor
            cell.nextFirstLineColorView.backgroundColor     = firstColor
            if let secondColor: UIColor = lineColors.last {
                cell.currentSecondLineColorView.backgroundColor = secondColor
                cell.nextSecondLineColorView.backgroundColor    = secondColor
            }else{
                cell.currentSecondLineColorView.backgroundColor = firstColor
                cell.nextSecondLineColorView.backgroundColor    = firstColor
            }
        }
        if obj.pathType == .TransitPath {
            let nextLineColors = obj.nextLineColor
            if let firstColor: UIColor = nextLineColors.first {
                cell.nextFirstLineColorView.backgroundColor         = firstColor
                if let secondColor: UIColor = nextLineColors.last {
                    cell.nextSecondLineColorView.backgroundColor    = secondColor
                }
            }
        }
    }
    
}
