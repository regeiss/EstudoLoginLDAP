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
    func validaUsuario(login: String, senha: String) -> Bool
    {
        // Le JSON no Firebase
        let databaseRefer = Database.database().reference()
        var retorno: Bool = true
        
        // Le Firebase
        databaseRefer.child("usuarios").child(login).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? "vazio"
            let senha = value?["senha"] as? Int64 ?? 0
            //let user = Usuario(0)
            print(username)
            print(senha)
        })
        {
            (error) in
            print(error.localizedDescription)
        }
        
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

