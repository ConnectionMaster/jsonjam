import JSONHelper
import Foundation

public typealias JSONDictionary = [String: AnyObject]

open class JSONJam: Deserializable {

    fileprivate var jsonData: JSONDictionary?
    fileprivate var parameters = JSONDictionary()
    
    open func propertyMap() {
        fatalError("must override this")
    }
    
    open func parameterize() -> JSONDictionary {
        propertyMap()
        return parameters
    }
    
    required public init(dictionary: JSONDictionary) {
        jsonData = dictionary
        propertyMap()
        jsonData = nil
    }
    
    public init() {
    }
    
    open func map(_ key: String, boolean: inout Bool?) {
        if let jsonData = jsonData {
            boolean <-- jsonData[key]
        } else {
            parameters[key] = boolean as AnyObject?
        }
    }
    
    open func map(_ key: String, booleanArray: inout [Bool]?) {
        if let jsonData = jsonData {
            booleanArray <-- jsonData[key]
        } else {
            parameters[key] = booleanArray as AnyObject?
        }
    }
    
    open func map(_ key: String, int: inout Int?) {
        if let jsonData = jsonData {
            int <-- jsonData[key]
        } else {
            parameters[key] = int as AnyObject?
        }
    }
    
    open func map(_ key: String, intArray: inout [Int]?) {
        if let jsonData = jsonData {
            intArray <-- jsonData[key]
        } else {
            parameters[key] = intArray as AnyObject?
        }
    }
    
    open func map(_ key: String, float: inout Float?) {
        if let jsonData = jsonData {
            float <-- jsonData[key]
        } else {
            parameters[key] = float as AnyObject?
        }
    }
    
    open func map(_ key: String, floatArray: inout [Float]?) {
        if let jsonData = jsonData {
            floatArray <-- jsonData[key]
        } else {
            parameters[key] = floatArray as AnyObject?
        }
    }
    
    open func map(_ key: String, double: inout Double?) {
        if let jsonData = jsonData {
            double <-- jsonData[key]
        } else {
            parameters[key] = double as AnyObject?
        }
    }
    
    open func map(_ key: String, doubleArray: inout [Double]?) {
        if let jsonData = jsonData {
            doubleArray <-- jsonData[key]
        } else {
            parameters[key] = doubleArray as AnyObject?
        }
    }
    
    open func map(_ key: String, string: inout String?) {
        if let jsonData = jsonData {
            string <-- jsonData[key]
        } else {
            parameters[key] = string as AnyObject?
        }
    }
    
    open func map(_ key: String, stringArray: inout [String]?) {
        if let jsonData = jsonData {
            stringArray <-- jsonData[key]
        } else {
            parameters[key] = stringArray as AnyObject?
        }
    }
    
    public func map(_ key: String, date: inout Date?, dateFormat: String) {
        let dateFormat = dateFormat
        if let jsonData = jsonData {
            date <-- (jsonData[key], dateFormat as AnyObject?)
        } else {
            if let date = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = dateFormat
                parameters[key] = dateFormatter.string(from: date) as AnyObject?
            }
        }
    }
    
    public func map(_ key: String, dateArray: inout [Date]?, dateFormat: String) {
        var dateFormat = dateFormat
        if let jsonData = jsonData {
            dateArray <-- (jsonData[key], dateFormat)
        } else {
            if let dateArray = dateArray {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = dateFormat
                var parameterizedArray = [String]()
                for date in dateArray {
                    parameterizedArray.append(dateFormatter.string(from: date))
                }
                self.parameters[key] = parameterizedArray as AnyObject?
            }
        }
    }
    
    open func map(_ key: String, url: inout URL?) {
        if let jsonData = jsonData {
            url <-- jsonData[key]
        } else {
            parameters[key] = url?.absoluteString as AnyObject?
        }
    }
    
    open func map(_ key: String, urlArray: inout [URL]?) {
        if let jsonData = jsonData {
            urlArray <-- jsonData[key]
        } else {
            if let urlArray = urlArray {
                var parameterizedArray = [String]()
                for url in urlArray {
                    parameterizedArray.append(url.absoluteString)
                }
                self.parameters[key] = parameterizedArray as AnyObject?
            }
        }
    }
    
    open func map<T:JSONJam>(_ key: String, object: inout T?) {
        if let jsonData = jsonData {
            if let data = convertToNilIfNull(jsonData[key]) as? JSONDictionary {
                object = T(dictionary: data)
            } else {
                object = nil
            }
        } else {
            if let object = object {
                self.parameters[key] = object.parameterize() as AnyObject?
            }
        }
    }
    
    open func map<T:JSONJam>(_ key: String, objectArray: inout [T]?) {
        if let jsonData = jsonData {
            if let dataArray = convertToNilIfNull(jsonData[key]) as? [JSONDictionary] {
                objectArray = [T]()
                for data in dataArray {
                    objectArray!.append(T(dictionary: data))
                }
            } else {
                objectArray = nil
            }
        } else {
            if let objectArray = objectArray {
                var parameterizedArray = [AnyObject]()
                for object in objectArray {
                    parameterizedArray.append(object.parameterize() as AnyObject)
                }
                self.parameters[key] = parameterizedArray as AnyObject?
            }
        }
    }
    
    open func map<T>(_ key: String, serializeClosure: (inout AnyObject?) -> Void, deserializeClosure: (T?) -> Void) {
        if let jsonData = jsonData {
            deserializeClosure(jsonData[key] as! T?)
        } else {
            serializeClosure(&self.parameters[key])
        }
    }
    
    fileprivate func convertToNilIfNull(_ object: AnyObject?) -> AnyObject? {
        if object is NSNull {
            return nil
        }
        return object
    }
}
