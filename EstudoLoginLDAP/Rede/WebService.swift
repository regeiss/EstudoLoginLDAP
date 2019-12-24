//
//  WebService.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 17/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//

import Foundation

class AcessoWS
{
    func teste()
    {
        let apiKey = "5a55c163db824179819ef6d1b167c342"
        let url = URL(string: "https://desenv-ws.novohamburgo.rs.gov.br/index.php/api/Memo/buscaSecretarias/")!
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        //let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!

        let task = session.dataTask(with: request, completionHandler: { data, response, error in

            if error != nil || data == nil
            {
                print("Client error!")
                return
            }

            guard let response1 = response as? HTTPURLResponse, (200...299).contains(response1.statusCode)
            else
            {
                print("Server error!");print(response!)
                return
            }

            guard let mime = response1.mimeType, mime == "application/json"
            else
            {
                print("Wrong MIME type!")
                return
            }

            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
            }
            catch
            {
                print("JSON error: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    func handleServerError(response: HTTPURLResponse)
    {
        
    }
}
