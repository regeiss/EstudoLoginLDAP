//
//  ValidaLogin.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 09/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class Login
{
//    var plogin: String = ""
//    var psenha: String = ""
    
    func validaUsuario(login: String, senha: String) -> Bool
    {
        // Le JSON no Firebase
        var databaseRefer = Database.database().reference()
        var databaseHandler: DatabaseHandle!
        
        var retorno: Bool = true
        
        
        //DatabaseHandle = databaseRefer.child("usuario").observe(.childAdded, with: {(data) in let })
        if login != "rgeiss"
        {
            retorno = false
        }
        else if senha != "1234"
        {
            retorno = false
        }
        
        return retorno
    }
}

