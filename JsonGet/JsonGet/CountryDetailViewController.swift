//
//  CountryDetailViewController.swift
//  JsonGet
//
//  Created by Yogesh Patel on 14/12/21.
//

import UIKit

class CountryDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var countryDict = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension CountryDetailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryDict.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{
            return UITableViewCell()
        }
       
        let sortDict = countryDict.sorted(by: { $0.key < $1.key })
        
        let key = sortDict.map{ $0.key }[indexPath.row]
        let value = sortDict.map{ $0.value }[indexPath.row]
        
//        let key = Array(sortDict.keys)[indexPath.row]
//        let value = Array(sortDict.values)[indexPath.row]
        cell.textLabel?.text = "\(key) : \(value)"
        /*
        let key = Array(countryDict.keys)[indexPath.row]
//        let value = Array(countryDict.values)[indexPath.row]
        if let value = countryDict[key]{
            
            cell.textLabel?.text = "\(key) : \(value)"
        }
        */
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension CountryDetailViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sortDict = countryDict.sorted(by: { $0.key < $1.key })
        
        let value = sortDict.map{ $0.value }[indexPath.row]
         /*
        if let _ = value as? String{//Value ki type check kar sakhate ho
            return
        }else if let borders = value as? [String]{
            print(borders)
        }else if let currencies = value as? [String: String]{
            print(currencies)
        }
        */
        
        if let _ = value as? String{//Value ki type check kar sakhate ho
            return
        }
        
        if let countrySubDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "CountrySubDetailViewController") as? CountrySubDetailViewController{
            countrySubDetailViewController.value = value as AnyObject
            self.navigationController?.pushViewController(countrySubDetailViewController, animated: true)
        }
        
        //countrySubDetailViewController.arrData = value as? [String] ?? []
    }
}
