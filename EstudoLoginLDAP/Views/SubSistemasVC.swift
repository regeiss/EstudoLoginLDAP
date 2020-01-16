//
//  SubSistemasVC.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 11/01/20.
//  Copyright © 2020 Roberto Edgar Geiss. All rights reserved.
//

import UIKit

class SubSistemasVC: UIViewController
{
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblSubSistema: UILabel!
    
    var album: Album?
    var Id: Int?
    {
        didSet {lblId.text = "\(Id ?? 0)"}
    }
    
    var SubSistema: String?
    {
        didSet {lblSubSistema.text = SubSistema?.NomeFormatado ?? ""}
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Id = album?.AlbumId
        SubSistema = album?.albumTitle
    }
}

//extension Int
//{
//    var IdFormatado: Int
//    {
//        return "Nº:" + String(self)
//    }
//}

extension String
{
    var NomeFormatado: String
    {
        return "-" + self
    }
}
