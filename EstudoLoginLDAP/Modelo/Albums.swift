//
//  Albums.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 07/01/20.
//  Copyright © 2020 Roberto Edgar Geiss. All rights reserved.
//

import Foundation


// Usado para fins de teste. 
struct Album: Codable
{
    var userId: Int
    var AlbumId: Int
    var albumTitle: String
    
    // Necessario para o decode JSON
    enum CodingKeys: String, CodingKey
    {
        case userId = "userId"
        case AlbumId = "id"
        case albumTitle = "title"
    }
}
