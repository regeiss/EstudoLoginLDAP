//
//  Sistemas.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 30/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//

import Foundation

class Sistemas
{
    init(id: Int, nome: String, subsistema: String)
    {
        self.id = id
        self.nome = nome
        self.subsistema = subsistema
    }
    
    var id: Int
    var nome: String
    var subsistema: String
}
