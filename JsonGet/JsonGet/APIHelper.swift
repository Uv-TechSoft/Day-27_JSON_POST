//
//  APIHelper.swift
//  JsonGet
//
//  Created by Yogesh Patel on 11/12/21.
//

import UIKit

class APIHelper{
    //http://api.countrylayer.com/v2/all?access_key=5d5d5770d51b5f30127b6eeecc817a89
    static let shareInstance = APIHelper()
    //() -> ()
    let baseURL = "http://api.countrylayer.com/v2/all?access_key=5d5d5770d51b5f30127b6eeecc817a89"
    let postURL = "https://jsonplaceholder.typicode.com/posts"
    func calledCountryGetAPI(completionHandler: @escaping ([[String: AnyObject]]) -> ()){
        guard let url = URL(string: "http://api.countrylayer.com/v2/all?access_key=yourapikey") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data)
                if let jsonArray = jsonResponse as? [[String: AnyObject]]{
                   
                   completionHandler(jsonArray)
                }
            } catch{
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    func capture(completion: (Int) -> ()){
        print("asdasd")
        completion(5)
    }
    
    func calledLocalJson(completionHandler: @escaping ([[String: AnyObject]]) -> ()){
        guard let countryJsonURL = Bundle.main.url(forResource: "CountryJson", withExtension: "json"), let data = try? Data(contentsOf: countryJsonURL) else { return }
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data)
            if let jsonArray = jsonResponse as? [[String: AnyObject]]{
               completionHandler(jsonArray)
            }
        } catch{
            print(error.localizedDescription)
        }
    }
}
