//
//  HomeTabController.swift
//  Kineesio
//
//  Created by Adhit Ramamurthi on 28.11.15.
//  Copyright © 2015 Adhit Ramamurthi. All rights reserved.
//

import UIKit

class HomeTabController: UIViewController, NRFManagerDelegate{

    // initialize NRFmanager
    var nrfManager:NRFManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nrfManager = NRFManager(delegate:self)
    
        // Set nav view title to image
        let TitleLogo = UIImage(named: "kiKNEEsio Title.pdf")
        let TitleimageView = UIImageView(image:TitleLogo)
        self.navigationItem.titleView = TitleimageView
    }
    
    
    // Connect to bluetooth device
    func sendData(){
        let result = self.nrfManager.writeString("Hello, world!")
    }
        
        
    // NRFManagerDelegate methods
    func nrfDidConnect(nrfManager:NRFManager){
        print("Connected")
        self.sendData()
    }
        
        // Do any additional setup after loading the view.
    

    
    
    // Bluetooth Button is pushed
    @IBAction func bluetoothdownloadbutton(sender: UIButton) {
        
        //Connect to device
        
        
        //Download Data
        func nrfReceivedData(nrfManager:NRFManager, data: NSData?, string: String?) {
            print("Received data - String: \(string) - Data: \(data)")
        }
        

        //
        
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
