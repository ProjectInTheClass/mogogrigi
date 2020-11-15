//
//  DataaManager.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/11/15.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let shared = DataManager()
    private init() {
        
    }
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var boarList = [Board]()
    
    func fetchBoard() {
        let request: NSFetchRequest<Board> = Board.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key: "registrationDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            boarList = try mainContext.fetch(request)
            
        } catch  {
            print(error)
        }
    }
    
    func addnewText(_ keyword1: String?, _ keyword2: String?, _ keyword3: String?, _ mainDescription: String?, _ subDescription: String?, _ images: [UIImage]) {
        let newText = Board(context: mainContext)
        
        newText.keyword1 = keyword1
        newText.keyword2 = keyword2
        newText.keyword3 = keyword3
        newText.mainDescription = mainDescription
        newText.subDescription = subDescription
        newText.registrationDate = Date()
        
        if images.count == 1 {
            let data: [Data] = [(images[0].pngData())!]
            newText.images = data
        } else if images.count == 2 {
            let data: [Data] = [(images[0].pngData())!, (images[1].pngData())!]
            newText.images = data
        } else if images.count == 3 {
            let data: [Data] = [(images[0].pngData())!, (images[1].pngData())!, (images[2].pngData())!]
            newText.images = data
        } else if images.count == 4 {
            let data: [Data] = [(images[0].pngData())!, (images[1].pngData())!, (images[2].pngData())!, (images[3].pngData())!]
            newText.images = data
        } else if images.count == 5 {
            let data: [Data] = [(images[0].pngData())!, (images[1].pngData())!, (images[2].pngData())!, (images[3].pngData())!, (images[4].pngData())!]
            newText.images = data
        } else {
            return
        }
        
        boarList.insert(newText, at: 0)
        saveContext()
        
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "mogrige")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}
