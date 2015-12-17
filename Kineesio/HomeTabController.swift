//
//  HomeTabController.swift
//  Kineesio
//
//  Created by Adhit Ramamurthi on 28.11.15.
//  Copyright © 2015 Adhit Ramamurthi. All rights reserved.
//

import UIKit
import CoreBluetooth

class HomeTabController: UIViewController, updateLabel {

    @IBOutlet weak var maxExtensionLabel: UILabel!
    @IBOutlet weak var maxFlexionLabel: UILabel!
    @IBOutlet weak var numberUnsafeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set nav view title to image
        let TitleLogo = UIImage(named: "kiKNEEsio Title.pdf")
        let TitleimageView = UIImageView(image:TitleLogo)
        self.navigationItem.titleView = TitleimageView
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        print("Updating")
        self.maxExtensionLabel?.text =  "\(JointData.sharedInstance.maxExtensionAngle)"
        self.maxFlexionLabel?.text = "\(JointData.sharedInstance.maxFlexionAngle)"
    }
    
    @IBAction func startWorkout(sender: UIButton) {
    }

}
