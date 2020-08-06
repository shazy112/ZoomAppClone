//
//  Users.swift
//
//  Created by Invision on 18/12/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Users: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let verified = "verified"
    static let lastClientVersion = "last_client_version"
    static let lastName = "last_name"
    static let id = "id"
    static let timezone = "timezone"
    static let email = "email"
    static let createdAt = "created_at"
    static let lastLoginTime = "last_login_time"
    static let firstName = "first_name"
    static let type = "type"
    static let pmi = "pmi"
  }

  // MARK: Properties
  public var verified: Int?
  public var lastClientVersion: String?
  public var lastName: String?
  public var id: String?
  public var timezone: String?
  public var email: String?
  public var createdAt: String?
  public var lastLoginTime: String?
  public var firstName: String?
  public var type: Int?
  public var pmi: Int?

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
    verified = json[SerializationKeys.verified].int
    lastClientVersion = json[SerializationKeys.lastClientVersion].string
    lastName = json[SerializationKeys.lastName].string
    id = json[SerializationKeys.id].string
    timezone = json[SerializationKeys.timezone].string
    email = json[SerializationKeys.email].string
    createdAt = json[SerializationKeys.createdAt].string
    lastLoginTime = json[SerializationKeys.lastLoginTime].string
    firstName = json[SerializationKeys.firstName].string
    type = json[SerializationKeys.type].int
    pmi = json[SerializationKeys.pmi].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = verified { dictionary[SerializationKeys.verified] = value }
    if let value = lastClientVersion { dictionary[SerializationKeys.lastClientVersion] = value }
    if let value = lastName { dictionary[SerializationKeys.lastName] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = timezone { dictionary[SerializationKeys.timezone] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = lastLoginTime { dictionary[SerializationKeys.lastLoginTime] = value }
    if let value = firstName { dictionary[SerializationKeys.firstName] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = pmi { dictionary[SerializationKeys.pmi] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.verified = aDecoder.decodeObject(forKey: SerializationKeys.verified) as? Int
    self.lastClientVersion = aDecoder.decodeObject(forKey: SerializationKeys.lastClientVersion) as? String
    self.lastName = aDecoder.decodeObject(forKey: SerializationKeys.lastName) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.timezone = aDecoder.decodeObject(forKey: SerializationKeys.timezone) as? String
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.lastLoginTime = aDecoder.decodeObject(forKey: SerializationKeys.lastLoginTime) as? String
    self.firstName = aDecoder.decodeObject(forKey: SerializationKeys.firstName) as? String
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? Int
    self.pmi = aDecoder.decodeObject(forKey: SerializationKeys.pmi) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(verified, forKey: SerializationKeys.verified)
    aCoder.encode(lastClientVersion, forKey: SerializationKeys.lastClientVersion)
    aCoder.encode(lastName, forKey: SerializationKeys.lastName)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(timezone, forKey: SerializationKeys.timezone)
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(lastLoginTime, forKey: SerializationKeys.lastLoginTime)
    aCoder.encode(firstName, forKey: SerializationKeys.firstName)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(pmi, forKey: SerializationKeys.pmi)
  }

}
