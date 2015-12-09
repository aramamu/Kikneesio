//
//  SettingsTabController.swift
//  Kineesio
//
//  Created by Adhit Ramamurthi on 28.11.15.
//  Copyright © 2015 Adhit Ramamurthi. All rights reserved.
//

import UIKit
import CoreBluetooth

class SettingsTabController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var bleManager: CBCentralManager!
    var blePeripheral: CBPeripheral!
    var rssiTimer = NSTimer()
    
    @IBOutlet weak var stopScanningButton: UIButton!
    @IBOutlet weak var bleStatusLabel: UILabel!
    @IBOutlet weak var startScanningButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        self.disconnectButton.hidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set nav view title to image
        let TitleLogo = UIImage(named: "Settings Title.pdf")
        let TitleimageView = UIImageView(image:TitleLogo)
        self.navigationItem.titleView = TitleimageView
        bleManager = CBCentralManager()
        bleManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startScanningBLE(sender: UIButton) {
        if (bleManager.state == .PoweredOff) {
            self.bleStatusLabel.text = "Bluetooth is Turned Off"
        }
        else if (bleManager.state == .PoweredOn) {
            self.bleStatusLabel.text = "Scanning for connections..."
            
            bleManager.scanForPeripheralsWithServices(nil, options: nil)
        }
        
    }
    
    @IBAction func stopScanningBLE(sender: UIButton) {
        bleManager.stopScan()
        self.bleStatusLabel.text = "Stopped Scanning"
    }
    
    
    @IBAction func disconnectBLE(sender: UIButton) {
        bleManager.cancelPeripheralConnection(blePeripheral)
        self.disconnectButton.hidden = true
        self.startScanningButton.hidden = false
        self.stopScanningButton.hidden = false
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
    }
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("Discovered \(peripheral.name)")
        
        if let deviceName = peripheral.name {
            if deviceName == "Kikneesio"
            {
                blePeripheral = peripheral
                bleManager.stopScan()
                print(blePeripheral.name!)
                bleManager.connectPeripheral(blePeripheral, options: nil)
            }
        }
    }
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        self.bleStatusLabel.text = "Connected to \(peripheral.name!)"
        self.startScanningButton.hidden = true
        self.stopScanningButton.hidden = true
        self.disconnectButton.hidden = false
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        self.bleStatusLabel.text = "Disconnected From Bluetooth"
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
