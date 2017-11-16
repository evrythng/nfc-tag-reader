//
//  evrythngNFC.swift
//  EVRYTHNG NFC Reader
//
//  Created by Joel Vogt on 30/10/2017.
//  Copyright © 2017 EVRYTHNG. All rights reserved.
//

import Foundation
import Foundation
import CoreNFC
import UIKit

struct  ADIValidator {
    //Source: https://learn.adafruit.com/adafruit-pn532-rfid-nfc/ndef
    static let uriPrefixMap:[Character:String] = [Character("\u{0}"):"",Character("\u{1}"):"http://www.",Character("\u{2}"):"https://www.",Character("\u{3}"):"http://",Character("\u{4}"):"https://",Character("\u{5}"):"tel:",Character("\u{6}"):"mailto:",Character("\u{7}"):"ftp://anonymous:anonymous@",Character("\u{8}"):"ftp://ftp.",Character("\u{9}"):"ftps://",Character("\u{10}"):"sftp://",Character("\u{11}"):"smb://",Character("\u{12}"):"nfs://",Character("\u{13}"):"ftp://",Character("\u{14}"):"dav://",Character("\u{15}"):"news:",Character("\u{16}"):"telnet://",Character("\u{17}"):"imap:",Character("\u{18}"):"rtsp://",Character("\u{19}"):"urn:",Character("\u{20}"):"pop:",Character("\u{21}"):"sip:",Character("\u{22}"):"sips:",Character("\u{23}"):"tftp:",Character("\u{24}"):"btspp://",Character("\u{25}"):"btl2cap://",Character("\u{26}"):"btgoep://",Character("\u{27}"):"tcpobex://",Character("\u{28}"):"irdaobex://",Character("\u{29}"):"file://",Character("\u{30}"):"urn:epc:id:",Character("\u{31}"):"urn:epc:tag:",Character("\u{32}"):"urn:epc:pat:",Character("\u{33}"):"urn:epc:raw:",Character("\u{34}"):"urn:epc:",Character("\u{35}"):"urn:nfc:"]
    
    static func parseNFCPayload(payload:NFCNDEFPayload, handler: @escaping (URL?)->Void) -> Void {
        print("DEBUG 0")
        guard let str = String(data: payload.payload, encoding:.utf8), payload.payload.count > 4 else {
            handler(nil)
            return
        }
        print("DEBUG 1")
        guard let prefix = str.first else {
            handler(nil)
            return
        }
        if let uri = URL(string:ADIValidator.uriPrefixMap[prefix]! + str[str.index(str.startIndex, offsetBy:1)...]), (ADIValidator.uriPrefixMap[prefix] != nil) {
            UIApplication.shared.open(uri,options: [:]){ (success) in
                if success {
                    print("URL \(uri)")
                    handler(uri)
                } else {
                    handler(nil)
                }
            }
        } else {
            let uri = URL(string: str)!
            if uri.scheme != nil {
                handler(uri)
            } else {
                if let uri = URL(string:"https://"+str) {
                    UIApplication.shared.open(uri,options: [:]){ (success) in
                        if success {
                            handler(uri)
                        } else {
                            handler(nil)
                        }
                    }
                }
            }
        }
    }
}
