//
//  Utilitarios.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 10/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//

import Foundation

public class Utilitarios
{

    private let dateFormatter = DateFormatter()
    
    var dataFormatada: String
    {
        get
        {
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .full
            dateFormatter.locale = Locale(identifier: "pt_BR")
            return dateFormatter.string(from: Date())
        }
        set
        {
            //
        }
    }
    //
    
    
}
