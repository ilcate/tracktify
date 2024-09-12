//
//  NetworkError.swift
//  Tracktify
//
//  Created by Christian Catenacci on 05/08/24.
//

import Foundation

enum NetworkError : Error{
    case invalidURL
    case invalidServer
    case generalError
}
