//
//  StationTableViewController.swift
//  Radio
//
//  Created by Georgy Dyagilev on 18/10/2018.
//  Copyright © 2018 Georgy Dyagilev. All rights reserved.
//

import UIKit

class StationTableViewController: UITableViewController {
    
    var stations = [Station]()

    override func viewDidLoad() {
        super.viewDidLoad()
           
        loadStations { (stations) in
            self.stations = stations
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as! StationTableViewCell
        
        cell.stationNameLabel.text = stations[indexPath.row].name
        cell.descriptionLabel.text = stations[indexPath.row].description
        cell.imageView?.image = stations[indexPath.row].image
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StationView" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let stationViewController = segue.destination as! StationViewController
                stationViewController.streamURL = stations[indexPath.row].streamURL
            }
        }
    }
}
