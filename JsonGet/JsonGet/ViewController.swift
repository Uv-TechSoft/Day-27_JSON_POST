//
//  ViewController.swift
//  JsonGet
//
//  Created by Yogesh Patel on 09/12/21.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrData = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  calledCountryGetAPI()
       // calledLocalJson()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        APIHelper.shareInstance.capture { value in
//            print(value)
        }
        
        APIHelper.shareInstance.calledCountryGetAPI { arrResponse in
//            print(arrResponse)
        }
        
        APIHelper.shareInstance.calledLocalJson { jsonArray in
            for country in jsonArray{
                
                var dict: [String: Any] = [
                    "name": country["name"] as? String ?? "No name",
                    "capital": country["capital"] as? String ?? "No capital",
                    "flag": country["flag"] as? String ?? "No flag",
                    "alpha2Code": country["alpha2Code"] as? String ?? "No alpha2Code",
                    "alpha3Code": country["alpha3Code"] as? String ?? "No alpha3Code",
                    "region": country["region"] as? String ?? "No region"
                ]
                
                if let currencies = country["currencies"] as? [[String: String]]{
                    if let currency = currencies.first{
                        dict["currency"] = currency
                        //                            dict["currencyName"] = currency["name"] ?? "No currency name"
                        //                            print(currency["name"])
                    }
                }
                
                //altSpellings
                if let altSpellings = country["altSpellings"] as? [String]{
                    if let altSpelling = altSpellings.first{
                        dict["altSpelling"] = altSpelling
                    }
                }
                
                //borders
                if let borders = country["borders"] as? [String]{
                    dict["borders"] = borders
                }
                
                //languages
                var arrLangauges = [[String: String]]()
                
                if let languages = country["languages"] as? [[String: String]]{
                    for language in languages {
                        
                        let languageDict: [String: String] = [
                            "iso639_1": language["iso639_1"] ?? "No iso639_1",
                            "name": language["name"] ?? "No name"
                        ]
                        
                        arrLangauges.append(languageDict)
                    }
                    print(arrLangauges)
                    dict["languages"] = arrLangauges
                }
                
                self.arrData.append(dict)
            }
            
            self.tableView.reloadData()
        }
        
//        calledAF()
       // calledAFWithoutJSONSerialization()
    }
    
    func calledAF(){
        AF.request(APIHelper.shareInstance.baseURL).response{ response in
            switch response.result{
            case .success(let data):
                guard let data = data else { return }
                do {
                    let jsonResponse =  try JSONSerialization.jsonObject(with: data)
                    print(jsonResponse)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func calledAFWithoutJSONSerialization(){
        AF.request(APIHelper.shareInstance.baseURL).responseJSON { response in
            switch response.result{
            case .success(let jsonResponse):
                print(jsonResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
      
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{
            return UITableViewCell()
        }
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let country = arrData[indexPath.row]
        
        cell.textLabel?.text = country["name"] as? String ?? ""
        cell.detailTextLabel?.text = (country["capital"] as? String ?? "")  + " " + (country["altSpelling"] as? String ?? "")
        
//        cell.detailTextLabel?.text = "\(arrData[indexPath.row]["capital"] as? String) \(arrData[indexPath.row]["currencyName"] as? String)"
        return cell
        
//        //url start
//        if let cel{
//
//        }//url end
        
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let countryDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "CountryDetailViewController") as? CountryDetailViewController{
            countryDetailViewController.countryDict = arrData[indexPath.row]
            self.navigationController?.pushViewController(countryDetailViewController, animated: true)
        }
    }
}

/*
 1. "altSpellings" dict . first value get karna
 2. "flag" lai lena
 3. "currencies" - get whole dict - code, symbol, name
 4. "region"
 5. "alpha2Code"
 6. "alpha3Code"
 7. "borders" - get all
 8. "languages" - iso639_1, name
 */





/*
///ex   http://api.countrylayer.com/v2/all?access_key=12345678
func calledCountryGetAPI(){
    guard let url = URL(string: "http://api.countrylayer.com/v2/all?access_key=yourapikeyhere") else {
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else { return }
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data)
            if let jsonArray = jsonResponse as? [[String: AnyObject]]{
               
                for country in jsonArray{
                    
                    let dict: [String: String] = [
                        "name": country["name"] as? String ?? "No name",
                        "capital": country["capital"] as? String ?? "No capital"
                    ]
                    
                    self.arrData.append(dict)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(self.arrData)
            }
            
        } catch{
            print(error.localizedDescription)
        }
    }.resume()
    
}

func calledLocalJson(){
    guard let countryJsonURL = Bundle.main.url(forResource: "CountryJson", withExtension: "json"), let data = try? Data(contentsOf: countryJsonURL) else { return }
    do {
        let jsonResponse = try JSONSerialization.jsonObject(with: data)
        if let jsonArray = jsonResponse as? [[String: AnyObject]]{
           
            for country in jsonArray{
                
                var dict: [String: Any] = [
                    "name": country["name"] as? String ?? "No name",
                    "capital": country["capital"] as? String ?? "No capital",
                    "flag": country["flag"] as? String ?? "No flag",
                    "alpha2Code": country["alpha2Code"] as? String ?? "No alpha2Code",
                    "alpha3Code": country["alpha3Code"] as? String ?? "No alpha3Code",
                    "region": country["region"] as? String ?? "No region"
                ]
                
                if let currencies = country["currencies"] as? [[String: String]]{
                    if let currency = currencies.first{
                        dict["currency"] = currency
//                            dict["currencyName"] = currency["name"] ?? "No currency name"
//                            print(currency["name"])
                    }
                }
                
                //altSpellings
                if let altSpellings = country["altSpellings"] as? [String]{
                    if let altSpelling = altSpellings.first{
                        dict["altSpelling"] = altSpelling
                    }
                }
                
                //borders
                if let borders = country["borders"] as? [String]{
                    dict["borders"] = borders
                }
                
                //languages
                var arrLangauges = [[String: String]]()
                
                if let languages = country["languages"] as? [[String: String]]{
                    for language in languages {
                        
                        let languageDict: [String: String] = [
                            "iso639_1": language["iso639_1"] ?? "No iso639_1",
                            "name": language["name"] ?? "No name"
                        ]
                        
                        arrLangauges.append(languageDict)
                    }
                    print(arrLangauges)
                    dict["languages"] = arrLangauges
                }
                
                self.arrData.append(dict)
            }
            
            self.tableView.reloadData()
//                print(self.arrData)
        }
    } catch{
        print(error.localizedDescription)
    }
}
*/
