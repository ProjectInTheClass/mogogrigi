//
//  MoodboardList+CoreDataProperties.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/11/02.
//
//

import Foundation
import CoreData


extension MoodboardList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoodboardList> {
        return NSFetchRequest<MoodboardList>(entityName: "MoodboardList")
    }

    @NSManaged public var keyword1: String?
    @NSManaged public var keyword2: String?
    @NSManaged public var keyword3: String?
    @NSManaged public var mainDescription: String?
    @NSManaged public var subDescription: String?
    @NSManaged public var image1: String?
    @NSManaged public var image2: String?
    @NSManaged public var image3: String?
    @NSManaged public var image4: String?
    @NSManaged public var image5: String?
    @NSManaged public var colorPick1: String?
    @NSManaged public var colorPick2: String?
    @NSManaged public var colorPick3: String?
    @NSManaged public var likeArt: Bool
    @NSManaged public var registrationDate: Date?

}
