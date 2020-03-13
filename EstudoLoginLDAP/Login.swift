//
//  ValidaLogin.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 09/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Login
{
    var dataLogin: String = ""
    let databaseRefer = Database.database().reference()
    let utilitarios = Utilitarios()
    let usuario = Usuario()
    
    func validaUsuario(login: String, senha: String) -> Bool
    {
        // MARK: - Propriedades

        var retorno: Bool = true
        
        self.databaseRefer.child("usuarios").child(login).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            self.usuario.nome = value?["name"] as? String ?? "vazio"
            self.usuario.senha = value?["senha"] as? String ?? "vazio"
            self.usuario.email = value?["email"] as? String ?? "vazio"
            self.usuario.dataCriado = value?["dataCriado"] as? Date ?? nil
            self.usuario.dataUltimoLogin = value?["dataUltimoLogin"] as? Date ?? nil
            self.usuario.logado = value?["logado"] as? Bool ?? false     // //self.utilitarios.dataFormatada
            print(self.usuario.nome!)
            print(self.usuario.senha!)
            print(self.usuario.email!)
            print(self.usuario.dataUltimoLogin!)
            }
        )
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
        
        if retorno
        {
            atualizaDataLogin()
        }
        
        return retorno
    }
    
    func atualizaDataLogin()
    {
        // Grava hora de login
        dataLogin = utilitarios.dataLoginFormatada
        let childUpdate = ["dataLogin": dataLogin, "name":"Roberto Edgar Geiss", "logado":"sim"]
        databaseRefer.child("usuarios").child("rgeiss").updateChildValues(childUpdate)
        {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Erro atualizando: \(error)")
            }
            else
            {
                print("Atualizado")
            }
        }
    }
    
    func atualizaStatusLogin(status: String)
    {
        // Grava status de login
        let childUpdate = ["logado": status]
        databaseRefer.child("usuarios").child("rgeiss").updateChildValues(childUpdate)
        {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Erro atualizando: \(error)")
            }
            else
            {
                print("Atualizado")
            }
        }
    }
}

