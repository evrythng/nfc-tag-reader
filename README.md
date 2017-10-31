# [EVRYTHNG](https://evrythng.com) NFC Tag Reader

This is a simple NFC reader that lets you to open a URI on an NFC tag. Please note that this app only works with iOS 11 and it requires at least an iPhone 7.  We'll also release this app on the Apple App Store at a later stage. Feel free to download the code and use it. Also any feedback is much appreciated.

## Overview

We wrote this app because we needed a simple way to open URIs in NFC tags on iOS 11. This allows us to use NFC tags with our cloud platform in the same way as QR encoded URI can be opened with the [iOS 11 camera app](https://developers.evrythng.com/docs/ios-native-qr-capabilities). The EVRYTHNG cloud has a pretty neat service called [Redirector](https://developers.evrythng.com/reference#redirector), which is essentially context-aware URI redirection.

Our app is a barebone iOS single view app that starts scanning for NFC tags on startup. When the app reads an NFC tag, it calls `ADIValidator.parseNFCPayload` to extract a URI from a NDEF payload. If the payload is a URI, it will call handler and pass  URL object as argument. ADI stands for Active Digital Identity. It is a generalisation of an URI.


## Getting Started

You will need at an iPhone 7 running iOS11 and a commerical developer license.

1. Activate the Near Field Communication Tag Reading capability.

2. The app needs permissions to use the NFC reader. I this is not set, the app will crash as soon as the NFC reader is started. In  [info.plist](), add an entry key: `Privacy - NFC Scan Usage Description`  value: `NFC tag to read NDEF messages into the application`.
