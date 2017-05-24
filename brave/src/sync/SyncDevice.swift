/* This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit
import Shared

class SyncDevice: SyncRecord {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let name = "name"
    }
    
    // MARK: Properties
    var name: String?
    
    required init(record: Syncable?, deviceId: [Int]?, action: Int?) {
        super.init(record: record, deviceId: deviceId, action: action)
        
        let device = record as? Device
        self.name = device?.name
        
        // Preference
        self.objectData = nil
    }
    
    required init(json: JSON?) {
        super.init(json: json)
        // This won't work
        self.name = json?[SerializationKeys.name].asString
        
        // Preference
        self.objectData = nil
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    override func dictionaryRepresentation() -> [String: AnyObject] {
        
        // Notice there is no objectData type, this is technically part of Preferences, which does not use that key/value pair
        
        // Create nested bookmark dictionary
        var deviceDict = [String: AnyObject]()
        deviceDict[SerializationKeys.name] = self.name

        // Fetch parent, and assign bookmark
        var dictionary = super.dictionaryRepresentation()
        dictionary[SyncObjectDataType.Device.rawValue] = deviceDict
        
        return dictionary
    }

}
