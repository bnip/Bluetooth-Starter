//
//  BluetoothPeripheral.swift
//  Bluetooth Starter
//
//  Created by Polaris on 11/14/19.
//  Copyright © 2019 bryannip. All rights reserved.
//

import UIKit
import CoreBluetooth

class BluetoothPeripheral : UITableViewCell {
    
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceUUIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
