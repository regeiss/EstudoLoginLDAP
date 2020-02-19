//
//  ValidaLogin.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 09/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//

import Foundation

class ValidaLogin
{
    var plogin: String = ""
    var psenha: String = ""
    
    func ValidaUsuario(login: String, senha: String) -> Bool
    {
        if login.isEmpty
        {
            return false
        }
        else if senha.isEmpty
        {
            return false 
        }
        
        if login != "rgeiss"
        {
            return false
        }
        
        if senha != "1234"
        {
            return false
        }
        
        return true
    }
}

