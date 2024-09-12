//
//  APIStructuresMB.swift
//  Tracktify
//
//  Created by Christian Catenacci on 12/09/24.
//

import Foundation


struct MBResponse: Decodable {
    var recordings : [RecordingInfo]
}

struct RecordingInfo: Decodable {
    var id : String 
}
