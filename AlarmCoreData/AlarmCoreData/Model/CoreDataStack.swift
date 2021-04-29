import CoreData

enum CoreDataStack{
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AlarmCoreData")
        container.loadPersistentStores { (storeDesctiption, error) in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
        return container
    }()
    static var context:NSManagedObjectContext {container.viewContext}
    static func saveContext(){
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                print("oh no \(error)")
            }
        }
    }
    
}
