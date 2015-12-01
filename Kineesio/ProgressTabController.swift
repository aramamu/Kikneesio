//
//  ProgressTabController.swift
//  Kineesio
//
//  Created by Adhit Ramamurthi on 28.11.15.
//  Copyright © 2015 Adhit Ramamurthi. All rights reserved.
//

import UIKit

class ProgressTabController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set nav view title to image
        let TitleLogo = UIImage(named: "Progress Title.pdf")
        let TitleimageView = UIImageView(image:TitleLogo)
        self.navigationItem.titleView = TitleimageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
