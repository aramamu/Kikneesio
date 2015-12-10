//
//  AngleTabBarController.swift
//  Kineesio
//
//  Created by Adhit Ramamurthi on 10.12.15.
//  Copyright © 2015 Adhit Ramamurthi. All rights reserved.
//

import Foundation
import UIKit

class AngleTabBarController: UITabBarController {
    var jointArray: [NSData]
    var jointAngle: NSData {
        didSet {
            jointArray.append(jointAngle)
        }
    }
    
    init(jointAngle: NSData, jointArray: [NSData]) {
        self.jointAngle = jointAngle
        self.jointArray = jointArray
    }
}
