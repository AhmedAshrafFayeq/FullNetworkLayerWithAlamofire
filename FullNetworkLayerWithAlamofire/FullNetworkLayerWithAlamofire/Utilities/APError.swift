//
//  APError.swift
//  FullNetworkLayerWithAlamofire
//
//  Created by Ahmed Fayeq on 09/01/2022.
//

import Foundation

enum APError: String, Error{
    case invalidUsername    = "This username created an invalid request. please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data recieved from server was invalid. Please try again."
    case unableToFavorites  = "There was an error favoriting this user. Please try again"
    case alreadyInFavorites = "You've already favorited this user. You  must REALLY like them!"
}
