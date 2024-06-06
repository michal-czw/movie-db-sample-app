//
//  FavoriteChangeset.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import CoreData
import Foundation

@objc protocol FavoriteObserver: AnyObject {
    func onFavoriteChange(isFavorite: Bool)
}

class FavoriteChangeset {
    
    private var observers = [Int: NSHashTable<FavoriteObserver>]()
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TMDBSampleApp")
        container.loadPersistentStores(completionHandler: { _, _ in})
        return container
    }()

    static let sharedInstance = FavoriteChangeset()

    init() {}

    subscript(id: Int) -> Bool? {
        isFavorite(id: id)
    }

    func observe(id: Int, with observer: FavoriteObserver) {
        let currentObservers = observers[id, default: NSHashTable(options: .weakMemory)]
        currentObservers.add(observer)
        observers[id] = currentObservers
    }
    
    func removeObserver(_ observer: FavoriteObserver, for id: Int) {
        let currentObservers = observers[id, default: NSHashTable(options: .weakMemory)]
        currentObservers.remove(observer)
        observers[id] = currentObservers
    }
    
    func isFavorite(id: Int) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        let fetchedResults = try? context.fetch(fetchRequest)
        
        guard let fetchedId = fetchedResults?.first?.id, fetchedId == id else {
            return false
        }
        
        return true
    }
    
    func toggleFavorite(id: Int) {
        isFavorite(id: id) ? removeFavorite(id: id) : addFavorite(id: id)
    }
    
    private func addFavorite(id: Int) {
        let context = persistentContainer.viewContext
        let newData = Favorite(context: context)
        newData.id = Int32(id)
        do {
            try context.save()
            updateAndNotifyIfNeeded(id: id, isFavorite: true)
        } catch {}
    }
    
    private func removeFavorite(id: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects {
                context.delete(object)
            }
            try context.save()
            updateAndNotifyIfNeeded(id: id, isFavorite: false)
        } catch {}
        
    }

    private func updateAndNotifyIfNeeded(id: Int, isFavorite newValue: Bool) {
        observers[id]?.allObjects.forEach { $0.onFavoriteChange(isFavorite: newValue) }
    }

}
