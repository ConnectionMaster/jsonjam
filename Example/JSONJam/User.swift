//
//  User.swift
//  JSONJam
//
//  Created by Matt Luedke on 7/18/15.
//  Copyright (c) 2015 Matt Luedke. All rights reserved.
//

import JSONJam

open class User: JSONJam {
    
    open var name: String?
    open var shoeSize: ShoeSize?
    
    override open func propertyMap() {
        map("name", string: &name)
        map("shoe_size", object: &shoeSize)
    }
}
