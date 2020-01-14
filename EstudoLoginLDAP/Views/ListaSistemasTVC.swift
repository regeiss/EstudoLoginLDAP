//
//  ListaSistemasTVC.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 30/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//  UITableViewDelegate, UITableViewDataSource

import UIKit

class ListaSistemasTVC: UITableViewController //, UITableViewDelegate, UITableViewDataSource
{
    var sistemas: [Sistemas] = []
    var albuns: [Album] = []
    var acesso = AcessoWS()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        showIndicator(withTitle: "Aguarde", and: "")
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")!
        let task = URLSession.shared.dataTask(with: url)
        {(data, response, error) in
            
            guard let albums = try? JSONDecoder().decode([Album].self, from: data!)
            else
            {
                print("Error: Couldn't decode data into albums array \(String(describing: error))")
                return
            }

            self.albuns = albums
            DispatchQueue.main.async
            {
                self.tableView.reloadData()
            }
        }
        
        task.resume()
        hideIndicator()
    }

// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.albuns.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CelulaSistemasCL", for: indexPath) as! CelulaSistemasCL
        let album = self.albuns[indexPath.row]
        cell.lblId.text = "\(String(describing: album.AlbumId))"
        cell.lblNome.text = album.albumTitle
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        <#code#>
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        //
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let row = tableView.indexPathForSelectedRow?.row
        {
            let selectedLine = self.albuns[row]
            (segue.destination as? SubSistemasVC)?.album = selectedLine
        }
    }
}

extension ListaSistemasTVC
{
  @IBAction func cancelToSistemas(_ segue: UIStoryboardSegue)
  {
  }

  @IBAction func saveDetail(_ segue: UIStoryboardSegue)
  {
  }
}
