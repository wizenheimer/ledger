//
//  Double.swift
//  Crypto
//
//  Created by Nayan on 24/05/25.
//

import Foundation

extension Double {
    
    /// Coverts a Double into a Currency with 2 - 6 decimal places
    /// ```
    /// Convert 123.56 to $ 1,234.56
    /// Convert 0.12356 to $ 0.12
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        
        // Locale
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        
        // Between 2 - 6 decimal points
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Coverts a Double into a Currency as a string with 2 decimal places
    /// ```
    /// Convert 123.56 to "$ 1,234.56"
    /// Convert 0.12356 to "$ 0.12"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// Coverts a Double into a Currency with 2 - 6 decimal places
    /// ```
    /// Convert 123.56 to $ 1,234.56
    /// Convert 0.12356 to $ 0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        
        // Locale
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        
        // Between 2 - 6 decimal points
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Coverts a Double into a Currency as a string with 2 - 6 decimal places
    /// ```
    /// Convert 123.56 to "$ 1,234.56"
    /// Convert 0.12356 to "$ 0.123456"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Coverts a Double into a String representation
    /// ```
    /// Convert 123.5678 to "123.56"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Coverts a Double into a String representation
    /// ```
    /// Convert 123.5678 to "123.56%"
    /// ```
    func asPercentageString() -> String {
        return asNumberString() + "%"
    }
    
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Mn"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()
        default:
            return "\(sign)\(self)"
        }
    }
}
