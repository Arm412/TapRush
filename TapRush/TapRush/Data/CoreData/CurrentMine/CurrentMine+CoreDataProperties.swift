//
//  CurrentMine+CoreDataProperties.swift
//  TapRush
//
//  Created by Adam Mitro on 4/7/25.
//
//

import Foundation
import CoreData


extension CurrentMine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentMine> {
        return NSFetchRequest<CurrentMine>(entityName: "CurrentMine")
    }

    @NSManaged public var mineName: String?

}

extension CurrentMine : Identifiable {

}
