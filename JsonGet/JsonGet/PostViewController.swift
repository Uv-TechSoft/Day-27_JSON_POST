//
//  PostViewController.swift
//  JsonGet
//
//  Created by Yogesh Patel on 18/12/21.
//

import UIKit
import Alamofire

struct ContactModel: Encodable{
    var title: String
    var body: String
    var userId: Int
}

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      //  postAPIURL()
      //  postAPIModel()
      //  alamofireDictAPI()
        alamofireWithModel()
    }
    
    func postAPIURL(){
        //let str = ""
        let parameter: [String: Any] = [
          //  "title": "\(str)",
            "title": "Post API",
            "body": "Calling first api please check the response",
            "userId": 101
        ]
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
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
    
    func postAPIModel(){
        let contact = ContactModel(title: "My title", body: "My body", userId: 1011)
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = try? JSONEncoder().encode(contact)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
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
    
    func alamofireDictAPI(){
        let parameter: [String: Any] = [
            "title": "Post API",
            "body": "Calling first api please check the response",
            "userId": 101
        ]
        
        AF.request(APIHelper.shareInstance.postURL, method: .post, parameters: parameter).responseJSON { response in
            switch response.result{
            case .success(let jsonResponse):
                print(jsonResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func alamofireWithModel(){
        let contact = ContactModel(title: "My title", body: "My body", userId: 1011)
        
//        let httpHeaders: HTTPHeaders = [
//          //  .contentType("application/json")
//            "Content-Type": "application/json"
//        ]
        
        AF.request(APIHelper.shareInstance.postURL, method: .post, parameters: contact).responseJSON { response in
            switch response.result{
            case .success(let jsonResponse):
                print(jsonResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
