//
//  DNS.swift
//  swift-dns-parser
//
//  Created by Qasim Abbas on 10/28/18.
//  Copyright © 2018 Qasim. All rights reserved.
//

import Foundation
import CFNetwork

class DNS {
    var service: CFNetService?
    
    public static func dnsLookUp() {
            let host = CFHostCreateWithName(nil,"www.google.com" as CFString).takeRetainedValue()
            CFHostStartInfoResolution(host, .addresses, nil)
            var success: DarwinBoolean = false
            if let addresses = CFHostGetAddressing(host, &success)?.takeUnretainedValue() as NSArray? {
                for case let theAddress as NSData in addresses {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if getnameinfo(theAddress.bytes.assumingMemoryBound(to: sockaddr.self), socklen_t(theAddress.length),
                                   &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 {
                        let numAddress = String(cString: hostname)
                        print(numAddress)
                    }
                }
            }
    }
}
