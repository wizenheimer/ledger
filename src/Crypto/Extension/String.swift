//
//  String.swift
//  Crypto
//
//  Created by Nayan on 26/05/25.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
