//
//  ADIViewController.swift
//  EVRYTHNG NFC Reader
//
//  Created by Joel Vogt on 30/10/2017.
//  Copyright © 2017 EVRYTHNG. All rights reserved.
//

import Foundation
import UIKit
import CoreNFC

class ADIViewController:UIViewController, NFCNDEFReaderSessionDelegate{
    
    let reuseIdentifier = "reuseIdentifier"
    var detectedMessages = [NFCNDEFMessage]()
    var session: NFCNDEFReaderSession?
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print("DEBUG CTRL 0")
        let message = messages[messages.startIndex]
        
        switch message.records[0].typeNameFormat {
        case .nfcWellKnown:
            ADIValidator.parseNFCPayload(payload: message.records[0]) {(uri) in
                if let uri = uri {
                    UIApplication.shared.open(uri, options: [:])
                } else {
                    let alertController = UIAlertController(title: "Cannot read tag this tag", message: "This tag does not contain a valid URI", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    DispatchQueue.main.async {
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        case .absoluteURI:
            ADIValidator.parseNFCPayload(payload: message.records[0]) {(uri) in
                if let uri = uri {
                    UIApplication.shared.open(uri, options: [:])
                } else {
                    let alertController = UIAlertController(title: "Cannot read tag this tag", message: "This tag does not contain a valid URI", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    DispatchQueue.main.async {
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        case .empty:
            let alertController = UIAlertController(title: "Session Invalidated", message: "The tag format .empty is not supported", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
            
        case .media:
            let alertController = UIAlertController(title: "Session Invalidated", message: "The tag format .media is not supported", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
            
        case .nfcExternal:
            let alertController = UIAlertController(title: "Session Invalidated", message: "The tag format .nfcExternal is not supported", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
            
        case .unknown:
            let alertController = UIAlertController(title: "Session Invalidated", message: "The tag format .unkown is not supported", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
            
        case .unchanged:
            let alertController = UIAlertController(title: "Session Invalidated", message: "The tag format .unchanged is not supported", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.begin()
    }
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Check invalidation reason from the returned error. A new session instance is required to read new tags.
        
        if let readerError = error as? NFCReaderError {
            // Show alert dialog box when the invalidation reason is not because of a read success from the single tag read mode,
            // or user cancelled a multi-tag read mode session from the UI or programmatically using the invalidate method call.
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                let alertController = UIAlertController(title: "Session Invalidated", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func beginScanning(_ sender: Any) {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.begin()
    }
}
