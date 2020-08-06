//
//  ListUsers.swift
//
//  Created by Invision on 18/12/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ListUsers: NSCoding {
 //
  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let pageCount = "page_count"
    static let pageNumber = "page_number"
    static let users = "users"
    static let pageSize = "page_size"
    static let totalRecords = "total_records"
  }

  // MARK: Properties
  public var pageCount: Int?
  public var pageNumber: Int?
  public var users: [Users]?
  public var pageSize: Int?
  public var totalRecords: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    pageCount = json[SerializationKeys.pageCount].int
    pageNumber = json[SerializationKeys.pageNumber].int
    if let items = json[SerializationKeys.users].array { users = items.map { Users(json: $0) } }
    pageSize = json[SerializationKeys.pageSize].int
    totalRecords = json[SerializationKeys.totalRecords].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = pageCount { dictionary[SerializationKeys.pageCount] = value }
    if let value = pageNumber { dictionary[SerializationKeys.pageNumber] = value }
    if let value = users { dictionary[SerializationKeys.users] = value.map { $0.dictionaryRepresentation() } }
    if let value = pageSize { dictionary[SerializationKeys.pageSize] = value }
    if let value = totalRecords { dictionary[SerializationKeys.totalRecords] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.pageCount = aDecoder.decodeObject(forKey: SerializationKeys.pageCount) as? Int
    self.pageNumber = aDecoder.decodeObject(forKey: SerializationKeys.pageNumber) as? Int
    self.users = aDecoder.decodeObject(forKey: SerializationKeys.users) as? [Users]
    self.pageSize = aDecoder.decodeObject(forKey: SerializationKeys.pageSize) as? Int
    self.totalRecords = aDecoder.decodeObject(forKey: SerializationKeys.totalRecords) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(pageCount, forKey: SerializationKeys.pageCount)
    aCoder.encode(pageNumber, forKey: SerializationKeys.pageNumber)
    aCoder.encode(users, forKey: SerializationKeys.users)
    aCoder.encode(pageSize, forKey: SerializationKeys.pageSize)
    aCoder.encode(totalRecords, forKey: SerializationKeys.totalRecords)
  }

}
