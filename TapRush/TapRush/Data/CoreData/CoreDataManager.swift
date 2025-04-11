//
//  CoreDataManager.swift
//  TapRush
//
//  Created by Adam Mitro on 1/30/25.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getGemCountById(id: NSManagedObjectID) -> GemCount? {
        do {
            return try viewContext.existingObject(with: id) as? GemCount
        } catch {
            return nil
        }
    }
    
    func deleteGemCount(gemCount: GemCount) {
        viewContext.delete(gemCount)
        save()
    }
    
    func getGemCount() -> [GemCount] {
        let request: NSFetchRequest<GemCount> = GemCount.fetchRequest()
        
        do {
            let data = try viewContext.fetch(request)
            if data.isEmpty {
                let gemCount = GemCount(context: viewContext)
                
                CoreDataManager.shared.save()
                return [gemCount]
            } else {
                return data
            }
        } catch {
            return []
        }
    }
    
    func getSavedCurrentMine() -> CurrentMine? {
        let request: NSFetchRequest<CurrentMine> = CurrentMine.fetchRequest()
        
        do {
            let results = try viewContext.fetch(request)
            return results.first
        } catch {
            print("Failed to fetch CurrentMine: \(error)")
            return nil
        }
    }

    
    func getGoldCount() -> [GoldCount] {
        let request: NSFetchRequest<GoldCount> = GoldCount.fetchRequest()
        
        do {
            let data = try viewContext.fetch(request)
            if data.isEmpty {
                let goldCount = GoldCount(context: viewContext)
                
                CoreDataManager.shared.save()
                return [goldCount]
            } else {
                return data
            }
        } catch {
            return []
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "TapRushDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
}
