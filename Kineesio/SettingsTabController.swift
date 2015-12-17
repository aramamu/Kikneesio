//
//  SettingsTabController.swift
//  Kineesio
//
//  Created by Adhit Ramamurthi on 28.11.15.
//  Copyright © 2015 Adhit Ramamurthi. All rights reserved.
//

import UIKit
import CoreBluetooth
import Foundation

class SettingsTabController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate{
    
    var bleManager: CBCentralManager!
    var blePeripheral: CBPeripheral!
    var blePeripheralManager = CBPeripheralManager()
    
    var uuidService = CBUUID.init(string: "E805671E-BD01-4A41-A294-056034CE2EEF")
    var uuidChar = CBUUID.init(string: "06d90da3-8110-4358-8f23-e0955cb890ca")
    
    @IBOutlet weak var stopScanningButton: UIButton!
    @IBOutlet weak var bleStatusLabel: UILabel!
    @IBOutlet weak var startScanningButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    
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
        
        if let deviceName = peripheral.name {
            if deviceName == "Kikneesio Brace"
            {
                blePeripheral = peripheral
                blePeripheral.delegate = self
                bleManager.stopScan()
                bleManager.connectPeripheral(blePeripheral, options: nil)
            }
        }
    }
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        self.bleStatusLabel.text = "Connected to \(peripheral.name!)"
        self.startScanningButton.hidden = true
        self.stopScanningButton.hidden = true
        self.disconnectButton.hidden = false
        
        blePeripheral.discoverServices([uuidService])
        
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        self.bleStatusLabel.text = "Disconnected From \(peripheral.name!)"
        self.startScanningButton.hidden = false
        self.stopScanningButton.hidden = false
        self.disconnectButton.hidden = true
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        let bleService: CBService = blePeripheral.services![0]
        blePeripheral.discoverCharacteristics([uuidChar], forService: bleService)
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        blePeripheral.readValueForCharacteristic(service.characteristics![0])
        blePeripheral.setNotifyValue(true, forCharacteristic: service.characteristics![0])
    }
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if let jointAngle: NSData = characteristic.value {
            let dataString = String(jointAngle)
            let string = dataString.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>"))
            let jointValue = UInt8(strtoul(string, nil, 16))
            print(jointValue)
            JointData.sharedInstance.jointArray.append(Int(jointValue))
            if Int(jointValue) > JointData.sharedInstance.maxExtensionAngle {
                JointData.sharedInstance.maxExtensionAngle = Int(jointValue)
            }
        }
        
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if (error != nil) {
            print("Error Subscribing to Service")
        }
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
