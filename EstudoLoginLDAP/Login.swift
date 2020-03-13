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
    var dataLogin: String = ""
    let databaseRefer = Database.database().reference()
    let utilitarios = Utilitarios()
    
    func validaUsuario(login: String, senha: String) -> Bool
    {
        // MARK: - Propriedades

        var retorno: Bool = true
        
        self.databaseRefer.child("usuarios").child(login).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? "vazio"
            let senha = value?["senha"] as? Int64 ?? 0
            let email = value?["email"] as? String ?? "vazio"
            let dataCriado = value?["criadoEm"] as? Date ?? Date()
            self.dataLogin = self.utilitarios.dataFormatada
            print(username + " " + String(senha) + " " + email  + " " + self.dataLogin)
            print(dataCriado)
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
        dataLogin = utilitarios.dataFormatada
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

