//
//  ArrivalSearchViewController.swift
//  NorikaeOpenAPISampleApp
//
//  Created by MasamiYamate on 2018/07/06.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit
import NorikaeOpenAPIFramework

class ArrivalSearchViewController: UIViewController {
    
    @IBOutlet weak var PointSearchBar: UISearchBar!
    @IBOutlet weak var PointTableView: UITableView!
    
    var openApi:NorikaeOpenAPIFramework = NorikaeOpenAPIFramework.share
    var stations:[NOAStation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PointSearchBar.delegate = self
        PointTableView.delegate = self
        PointTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ArrivalSearchViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row < stations.count {
            let station: NOAStation = stations[indexPath.row]
            let spotName: String = station.name
            let kubun: String = station.type.rawValue
            cell.textLabel?.text = "\(spotName) 区分:\(kubun)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < stations.count {
            let station: NOAStation = stations[indexPath.row]
            Parameters.arrivalPoint = station
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "jumpToRouteResult", sender: nil)
            }
        }
    }
    
}

extension ArrivalSearchViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.global(qos: .default).async {
            if let keyword:String = searchBar.text {
                if let searchresponse:[NOAStation] = self.openApi.searchStations(keyword, mode: 0) {
                    self.stations = searchresponse
                }else{
                    self.stations = []
                }
            }else{
                self.stations = []
            }
            DispatchQueue.main.async {
                self.PointTableView.reloadData()
            }
        }
    }
    
}

