//
//  Usuario+CoreDataProperties.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 13/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//
//

import Foundation
import CoreData

extension Usuario
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Usuario>
    {
        return NSFetchRequest<Usuario>(entityName: "Usuario")
    }

    @NSManaged public var dataUltimoLogin: Date?
    @NSManaged public var email: String?
    @NSManaged public var logado: Bool
    @NSManaged public var nome: String?
    @NSManaged public var senha: String?
}
