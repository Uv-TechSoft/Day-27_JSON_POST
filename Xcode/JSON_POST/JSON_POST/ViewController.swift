//
//  ViewController.swift
//  JSON_POST
//
//  Created by Imam MohammadUvesh on 23/12/21.
//

import UIKit

//MARK: Structure
struct ContactModel: Encodable {
    var title: String
    var body: String
    var userId: Int
}

class ViewController: UIViewController {

    //MARK: Helper Methods
    override func viewDidLoad() {
        super.viewDidLoad()
     //   PostApiUrl()
          PostApiModel()
    //    alamofireDictAPI()
    // alamofireWithModel()
    }
    func PostApiUrl()
    {
        let parameter : [String:Any] = [
            "title":"Post API",
            "body":"Calling Body and First API",
            "userId": 111
            
        ]
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else
            {
                return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:data)
                print(jsonResponse)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func PostApiModel()
    {
        let contact = ContactModel(title: "POST API TITLE", body: "POST API BODY", userId: 111)
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(contact)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data else
            {
                return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data)
                print(jsonResponse)
            } catch {
                print(error)
            }
        
        }.resume()
    }
    
    //MARK: ALAMOFIRE JSON POST 
//    func alamofireDictAPI(){
//        let parameter: [String: Any] = [
//            "title": "Post API",
//            "body": "Calling first api please check the response",
//            "userId": 101
//        ]
//
//        AF.request(APIHelper.shareInstance.postURL, method: .post, parameters: parameter).responseJSON { response in
//            switch response.result{
//            case .success(let jsonResponse):
//                print(jsonResponse)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
//    func alamofireWithModel(){
//        let contact = ContactModel(title: "My title", body: "My body", userId: 1011)
//
////        let httpHeaders: HTTPHeaders = [
////          //  .contentType("application/json")
////            "Content-Type": "application/json"
////        ]
//
//        AF.request(APIHelper.shareInstance.postURL, method: .post, parameters: contact).responseJSON { response in
//            switch response.result{
//            case .success(let jsonResponse):
//                print(jsonResponse)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }


}
