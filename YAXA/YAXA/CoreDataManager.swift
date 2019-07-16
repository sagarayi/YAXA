//
//  CoreDataManager.swift
//  YAXA
//
//  Created by Sagar on 16/07/19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    var managedContext:NSManagedObjectContext
    var appDelegate:AppDelegate
    
    var datachangeClosure: ((_ type: String, _ jsondata: String, _ id: String ) -> Void)?
    
    override init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedContext = appDelegate.persistentContainer.viewContext
        self.managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func saveImageData(comicObject: XKCDComic) {
        let comic = NSEntityDescription.insertNewObject(forEntityName: "Comic",
                                                        into: self.managedContext) as! Comic
        
        comic.id = Int16(comicObject.id)
        comic.title = comicObject.title
        comic.desc = comicObject.desc
        comic.altDesc = comicObject.altDesc
        comic.imgLink = comicObject.imgLink
        comic.day = comicObject.day
        comic.month = comicObject.month
        comic.year = comicObject.year
        
        do {
            try self.managedContext.save()
        }
        catch {
            NSLog("Unresolved error \(error.localizedDescription)")
            abort()
        }
    }
    
    func fetchComicDataFor(imageID:String, completionHandler: @escaping (_ comicData:XKCDComic?, _ error:Error? ) -> ()) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Comic")
        fetchRequest.predicate = NSPredicate(format: ("id= %@"), imageID)
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count != 0 {
                completionHandler( mappingToCustomClass(dbComic: result[0] as! Comic), nil)
            }
            else {
                completionHandler(nil, nil)
            }
        } catch {
            completionHandler(nil, error)
        }
    }
    
    func mappingToCustomClass(dbComic: Comic) -> XKCDComic{
        let xkcdComic = XKCDComic.init()
        xkcdComic.id = Int(dbComic.id)
        xkcdComic.title = dbComic.title!
        xkcdComic.desc = dbComic.desc!
        xkcdComic.altDesc = dbComic.altDesc!
        xkcdComic.imgLink = dbComic.imgLink!
        xkcdComic.day = dbComic.day!
        xkcdComic.month = dbComic.month!
        xkcdComic.year = dbComic.year!
        
        return xkcdComic
    }
    
}
