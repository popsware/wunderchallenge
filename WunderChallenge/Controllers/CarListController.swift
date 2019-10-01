//
//  CarListController.swift
//  WunderChallenge
//
//  Created by Mohab Ayman on 9/29/19.
//  Copyright © 2019 Mohab Ayman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import EmptyKit

class CarListController: UITableViewController {
    
    var cars: [Car] = []
    var emptystatmessage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(loadData), for: .valueChanged)
        self.refreshControl = refreshControl
        
        
        loadData()
         
    }
    @objc func loadData(){
        
        //let hud = MBProgressHUD.showAdded(to: view, animated: true)
        if(!refreshControl!.isRefreshing)
        {
            refreshControl?.beginRefreshing()
        }
        
        Alamofire.request(Keys.Network.carList, method: .get, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
            //print("carlist: \(String(describing: response.request))")
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                self.parseData(json: json)
            case .failure(let error):
                print(error)
                
                self.initEmptyStat(message: Keys.Messages.somethingwrong)
                self.tableView.reloadData()
            }
            
            //will have to reload also if empty, to remove cells if were prev loaded)
            
            //hud.hide(animated: true)
            self.refreshControl?.endRefreshing()
        }
    }
    func parseData(json: JSON) {
        if let placemarks = json["placemarks"].array
        {
            for subJson:JSON in placemarks
            {

                do
                {
                    self.cars.append(try Car(dictionary: subJson))
                }
                catch
                {
                    print("skipping car, may have had incorrect data")
                }
 
            }
            
        }
        else{
            print("JSON placemarkers could not be found")
        }
        
        if self.cars.count == 0
        {
            self.initEmptyStat(message: Keys.Messages.nocars)
        }
        else{
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return cars.count > 0 ? 1 : 0
        }
        else
        {
            return cars.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            return tableView.dequeueReusableCell(withIdentifier: "allcarscell", for: indexPath)
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "carcell", for: indexPath) as! CarCell
            cell.fillCar(car: cars[indexPath.row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? MapsController,
            let sender = sender as? UITableViewCell
        {
            if let indexPath = tableView.indexPath(for: sender)
            {
                if indexPath.section == 0
                {
                    vc.cars = cars
                    vc.car = nil
                    
                }
                else {
                    vc.cars = nil
                    vc.car = cars[indexPath.row]
                }
                
                self.tableView.deselectRow(at: indexPath, animated: true)
                
            }
        }
    }
    
    
}


extension CarListController: EmptyDataSource {
    
    
    //My Method
    func initEmptyStat(message: String) {
        
        emptystatmessage = message
        
        //EmptyKit
        tableView.tableFooterView = UIView()
        tableView.ept.dataSource = self
        //tableView.ept.delegate = self
        tableView.ept.reloadData()
    }
    
    func imageForEmpty(in view: UIView) -> UIImage? {
        return UIImage(named: "nocars")
    }
    
    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        let font = UIFont.systemFont(ofSize: 14)
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: font]
        return NSAttributedString(string: emptystatmessage, attributes: attributes)
    }
    
}
