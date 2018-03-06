//
//  Petition.swift
//  petitions
//
//  Created by Gabriel Chapel on 3/1/18.
//  Copyright © 2018 Gabriel Chapel. All rights reserved.
//

import Foundation

struct Petition: Decodable{
    let title : String
    let sigCount : Int
    let url : String
}
