//
//  GemCount+CoreDataProperties.swift
//  TapRush
//
//  Created by Adam Mitro on 1/29/25.
//
//

import Foundation
import CoreData


extension GemCount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GemCount> {
        return NSFetchRequest<GemCount>(entityName: "GemCount")
    }

    @NSManaged public var common: Int
    @NSManaged public var uncommon: Int
    @NSManaged public var rare: Int
    @NSManaged public var legendary: Int
    @NSManaged public var mythical: Int

}

extension GemCount : Identifiable {

}
