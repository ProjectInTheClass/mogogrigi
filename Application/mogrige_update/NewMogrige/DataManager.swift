//
//  DataManager.swift
//  NewMogrige
//
//  Created by EunBee Jang on 2020/11/15.
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
        
        let sortByDateDesc = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        do {
            boarList = try mainContext.fetch(request)
        } catch  {
            print(error)
        }
    }//============fetch==============//
    
    
    
    func addnewBoard(_ paraKeyword1: String?, _ paraKeyword2: String?, _ paraKeyword3: String?,  paraMainText: String?, paraSubText: String?, _ paraImages: [UIImage], _ paraBookmark: Bool){
        
        let newBoard = Board(context: mainContext)
        
        newBoard.keyword1 = paraKeyword1
        newBoard.keyword2 = paraKeyword2
        newBoard.keyword3 = paraKeyword3
        
        newBoard.text1 = paraMainText
        newBoard.text2 = paraSubText
        
        newBoard.date = Date()
        
        newBoard.bookmark = paraBookmark
        
        if paraImages.count == 1 {
            let data: [Data] = [(paraImages[0].pngData())!]
            newBoard.images = data
        } else if paraImages.count == 2 {
            let data: [Data] = [(paraImages[0].pngData())!, (paraImages[1].pngData())!]
            newBoard.images = data
        } else if paraImages.count == 3 {
            let data: [Data] = [(paraImages[0].pngData())!, (paraImages[1].pngData())!, (paraImages[2].pngData())!]
            newBoard.images = data
        } else if paraImages.count == 4 {
            let data: [Data] = [(paraImages[0].pngData())!, (paraImages[1].pngData())!, (paraImages[2].pngData())!, (paraImages[3].pngData())!]
            newBoard.images = data
        } else if paraImages.count == 5 {
            let data: [Data] = [(paraImages[0].pngData())!, (paraImages[1].pngData())!, (paraImages[2].pngData())!, (paraImages[3].pngData())!, (paraImages[4].pngData())!]
            newBoard.images = data
        } else {
            return
        }
        
        boarList.insert(newBoard, at: 0)
        saveContext()
    } //==========addNewBoard===========//
    
    
    
    func deletBoard(_ board: Board?) {
        if let board = board {
            mainContext.delete(board)
            saveContext()
        }
    }
    
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NewMogrige")
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
