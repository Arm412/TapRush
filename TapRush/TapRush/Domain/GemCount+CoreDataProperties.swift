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

    @NSManaged public var common: Int64
    @NSManaged public var uncommon: Int64
    @NSManaged public var rare: Int64
    @NSManaged public var legendary: Int64
    @NSManaged public var mythical: Int64

}

extension GemCount : Identifiable {

}
