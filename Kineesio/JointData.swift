//
//  JointData.swift
//  Kineesio
//
//  Created by Adhit Ramamurthi on 17.12.15.
//  Copyright © 2015 Adhit Ramamurthi. All rights reserved.
//

class JointData {
    static let sharedInstance = JointData()
    var delegate: updateLabel? = nil
    var jointArray: [Int] = []
    var maxFlexionAngle: Int = 0 {
        didSet {
            delegate?.update()
        }
    }
    var maxExtensionAngle: Int = 0 {
        didSet {
            delegate?.update()
            print("\(maxExtensionAngle) MAXXXX")
        }
    }
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
}

protocol updateLabel {
    func update()
}


