//
//  JsonDecoderViewController.swift
//  JsonGet
//
//  Created by Yogesh Patel on 16/12/21.
//

import UIKit
import Alamofire

struct CountryModel: Decodable{
    var name: String
    var capital: String
    var region: String
    var borders: [String]
    var currencies: [CurrencyModel]
    
    struct CurrencyModel: Decodable{
        var code: String?
        var symbol: String?
        var name: String?
    }
}


class JsonDecoderViewController: UIViewController {
    
    var arrData = [CountryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //arrData.count
        //arrData[indexPath.row].name
        calledLocalJson()
    }
    
    func calledLocalJson(){
        guard let countryJsonURL = Bundle.main.url(forResource: "CountryJson", withExtension: "json"), let data = try? Data(contentsOf: countryJsonURL) else { return }
        do {
            //CountryModel.self - Dictionary - Main starting ka response hai wo
            //[CountryModel].self - Array
            let jsonResponse = try JSONDecoder().decode([CountryModel].self, from: data)
            print(jsonResponse)
        } catch{
            print(error.localizedDescription)
        }
    }
    
    /*
     func calledJSONDecoder(){
     AF.request(APIHelper.shareInstance.baseURL).response { response in
     switch response.result{
     case .success(let data):
     guard let data = data else { return }
     
     do {
     let jsonResponse = try JSONDecoder().decode([CountryModel].self, from: data)
     print(jsonResponse)
     } catch  {
     print(error)
     }
     
     case .failure(let error):
     print(error)
     }
     }
     }
     */
}
