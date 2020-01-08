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
        albuns = acesso.acessaAlbuns()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return albuns.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CelulaSistemasCL", for: indexPath) as! CelulaSistemasCL
        let album = albuns[indexPath.row]
        cell.lblId.text = "\(String(describing: album.AlbumId))"
        cell.lblNome.text = album.albumTitle
        return cell
    }
}

