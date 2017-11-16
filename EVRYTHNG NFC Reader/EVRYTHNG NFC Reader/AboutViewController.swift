//
//  AboutViewController.swift
//  EVRYTHNG NFC Reader
//
//  Created by Joel Vogt on 16/11/2017.
//  Copyright © 2017 EVRYTHNG. All rights reserved.
//

import Foundation
import UIKit
//UIViewController
class AboutViewController:UIViewController {
    @IBAction func emailEvtSupport(_ sender: Any){
        UIApplication.shared.openURL(URL(string:"mailto:support@evrythng.com")!)
    }
}
