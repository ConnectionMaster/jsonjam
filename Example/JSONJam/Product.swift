//
//  Product.swift
//  JSONJam
//
//  Created by Matt Luedke on 7/18/15.
//  Copyright (c) 2015 Matt Luedke. All rights reserved.
//

import JSONJam

open class Product: JSONJam {
    
    open var dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    open var productDescription: String?
    open var tags: [String]?
    open var price: Double?
    open var creationDate: Date?
    open var transactionDates: [Date]?
    open var owner: User?
    open var buyers: [User]?
    open var detailURL: URL?
    open var photoURLs: [URL]?
    open var thingIDontWantSerialized: String?
    
    override open func propertyMap() {
        map("product_description", string: &productDescription)
        map("tags", stringArray: &tags)
        map("price", double: &price)
        map("creation_date", date: &creationDate, dateFormat: dateFormat)
        map("transaction_dates", dateArray: &transactionDates, dateFormat: dateFormat)
        map("owner", object: &owner)
        map("buyers", objectArray: &buyers)
        map("url", url: &detailURL)
        map("photos", urlArray: &photoURLs)
    }
}

