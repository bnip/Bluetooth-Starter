//
//  ViewController.swift
//  Bluetooth Starter
//
//  Created by Polaris on 11/14/19.
//  Copyright © 2019 bryannip. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {

    @IBOutlet weak var devicesTableView: UITableView!
    
    var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral!
    var availableDevices: [CBPeripheral] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        devicesTableView.dataSource = self
        devicesTableView.delegate = self
    }
}

extension ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
          case .unknown:
            print("central.state is .unknown")
          case .resetting:
            print("central.state is .resetting")
          case .unsupported:
            print("central.state is .unsupported")
          case .unauthorized:
            print("central.state is .unauthorized")
          case .poweredOff:
            print("central.state is .poweredOff")
          case .poweredOn:
            centralManager.scanForPeripherals(withServices: nil)
            print("central.state is .poweredOn")
        @unknown default:
            print("Fatal Error")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if !availableDevices.contains(peripheral) {
            availableDevices.append(peripheral)
            devicesTableView.reloadData()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(availableDevices.count)
        return availableDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deviceCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BluetoothPeripheral
        
        let device = availableDevices[indexPath.row]
        
        deviceCell.deviceNameLabel.text = device.name
        deviceCell.deviceUUIDLabel.text = device.identifier.uuidString
        return deviceCell
    }
}
