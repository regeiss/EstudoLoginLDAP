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
        // MARK: - Propriedades
        var utilitarios: Utilitarios = Utilitarios()
        var retorno: Bool = true
        // Le Firebase
        let databaseRefer = Database.database().reference()
        databaseRefer.child("usuarios").child(login).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? "vazio"
            let senha = value?["senha"] as? Int64 ?? 0
            let email = value?["email"] as? String ?? "vazio"
            let dataCriado = value?["criadoEm"] as? Date ?? Date()
            let dateString = utilitarios.dataFormatada
            print(username + " " + String(senha) + " " + email  + " " + dateString)
            print(dataCriado)
            }
        )
        {
            (error) in
            print(error.localizedDescription)
        }
        
        // Grava hora de login
//        let dataCriado = Date()
//        let dataCriadoString = dateFormatter.string(from: dataCriado)
        
//        databaseRefer.child("usuarios").child(login).setValue(["ultimoLogin": dataCriadoString])
//        {
//            (error:Error?, ref:DatabaseReference) in
//            if let error = error {
//                print("Erro atualizando: \(error)")
//            }
//            else
//            {
//                print("Atualizado")
//            }
//        }
        
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

