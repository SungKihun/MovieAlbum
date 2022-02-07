//
//  Photo+CoreDataProperties.swift
//  MovieAlbum
//
//  Created by 성기훈 on 2022/02/07.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var image: Data?

}

extension Photo : Identifiable {

}
