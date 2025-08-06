//
//  Route.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/8/25.
//

import UIKit

enum Route {
    case login
    case signup
    case userProfile
    case notificationCenter
    case main
}

enum Storyboard: String {
    case main = "Main"
    case authentication = "Authentication"
    case userProfile = "User Profile"
}
