//
//  GoldCount+CoreDataProperties.swift
//  TapRush
//
//  Created by Adam Mitro on 1/31/25.
//
//

import Foundation
import CoreData


extension GoldCount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoldCount> {
        return NSFetchRequest<GoldCount>(entityName: "GoldCount")
    }

    @NSManaged public var count: Int64

}

extension GoldCount : Identifiable {

}
