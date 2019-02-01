//
//  HistoryEntity+CoreDataProperties.swift
//  mlexp
//
//  Created by zxj on 2019/2/1.
//  Copyright © 2019 Yamin Wei. All rights reserved.
//
//

import Foundation
import CoreData

extension HistoryEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryEntity> {
        return NSFetchRequest<HistoryEntity>(entityName: "HistoryEntity")
    }

    @NSManaged public var index: Int16
    @NSManaged public var date: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var type: String?
    @NSManaged public var imgPath: String?
}
