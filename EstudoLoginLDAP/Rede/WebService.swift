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
    var tableArray = [String] ()
    var listaAlbuns: [Album] = []
    // Teste de acesso a WS REST da PMNH.
    func TesteAcesso()
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

    func acessaAlbuns() -> [Album]
    {
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")!
        let task = URLSession.shared.dataTask(with: url)
        {(data, response, error) in
            
            guard let albums = try? JSONDecoder().decode([Album].self, from: data!)
            else
            {
                print("Error: Couldn't decode data into albums array \(String(describing: error))")
                return
            }

            self.listaAlbuns = albums
        }
        task.resume()
        return self.listaAlbuns
    }
}

