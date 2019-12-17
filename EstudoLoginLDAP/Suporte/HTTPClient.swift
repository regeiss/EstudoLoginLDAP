//
//  Http.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 13/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//

import Foundation
import UIKit

class HTTPClient
{
  
  @discardableResult func getRequest(_ url: String) -> AnyObject
  {
    return Data() as AnyObject
  }
  
  @discardableResult func postRequest(_ url: String, body: String) -> AnyObject
  {
    return Data() as AnyObject
  }
  
  func downloadImage(_ url: String) -> UIImage?
  {
    let aUrl = URL(string: url)
    guard let data = try? Data(contentsOf: aUrl!),
      let image = UIImage(data: data) else {return nil}
    return image
  }
  

//let params = ["username":"john", "password":"123456"] as Dictionary<String, String>
//
//var request = URLRequest(url: URL(string: "http://localhost:8080/api/1/login")!)
//request.httpMethod = "POST"
//request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
//request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let session = URLSession.shared
//let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//    print(response!)
//    do {
//        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
//        print(json)
//    } catch {
//        print("error")
//    }
//})
//
//task.resume()
}
