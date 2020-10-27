//
//  Post_List+CoreDataProperties.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/10/27.
//
//

import Foundation
import CoreData


extension Post_List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post_List> {
        return NSFetchRequest<Post_List>(entityName: "Post_List")
    }

    @NSManaged public var postDate: Date?
    @NSManaged public var keyword01: String?
    @NSManaged public var keyword02: String?
    @NSManaged public var keyword03: String?
    @NSManaged public var subTitle: String?
    @NSManaged public var memo: String?
    @NSManaged public var image01: String?
    @NSManaged public var image02: String?
    @NSManaged public var image03: String?
    @NSManaged public var image04: String?
    @NSManaged public var image05: String?
    @NSManaged public var masterpiece: String?
    @NSManaged public var colorChip01: String?
    @NSManaged public var colorChip02: String?
    @NSManaged public var colorChip03: String?
    @NSManaged public var likeArt: Bool

}

extension Post_List : Identifiable {

}
