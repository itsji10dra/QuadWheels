//
//  Navigation.swift
//  QuadWheels
//
//  Created by Jitendra on 01/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

enum StoryBoard: String {
    case main = "Main"
}

struct Navigation {
    
    static func getViewController<T: UIViewController>(_ storyboard: StoryBoard = .main, type: T.Type, identifer: String) -> T? {
        
        let storyBoard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: identifer) as? T else { return nil }
        return viewController
    }
}
