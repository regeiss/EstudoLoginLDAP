//
//  PersistenceService.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 13/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService
{
    // MARK: - Core Data stack

    private init() {}
    static var context: NSManagedObjectContext
    {
        persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EstudoLoginLDAP")
        container.loadPersistentStores(completionHandler:
            { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    static func saveContext ()
    {
        let context = persistentContainer.viewContext
        if context.hasChanges
        {
            do
            {
                try context.save()
            }
            catch
            {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
