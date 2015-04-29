// Playground - noun: a place where people can play

import UIKit
public protocol Formattable {
    func formattedString(amount: Double, currency: CurrencySymbol) -> String
}
public protocol CurrencySymbol {
    func symbol() -> String
    var description: String{get}
}

public enum Currency{
    case EUR
    case USD
    case RMB
}

extension Currency: CurrencySymbol {
    public func symbol() -> String {
        switch self {
        case .EUR: return "€"
        case .USD: return "$"
        case .RMB: return "￥"
        }
    }
    public var description: String{
        get{
            switch self {
            case .EUR: return "EUR"
            case .USD: return "USD"
            case .RMB: return "RMB"
            }
        }
    }
}

// with the extension, it's possible to add additional currencies
public struct BitCoin: CurrencySymbol {
    public func symbol() -> String {
        return "B⃦"
    }
    public var description: String {
        get {
            return "BitCoin"
        }
    }
}


class CurrencyConverter: Formattable{
    func formattedString(amount: Double, currency: CurrencySymbol) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.currencySymbol = currency.symbol()
        return formatter.stringFromNumber(amount)!
    }
}

let c = CurrencyConverter()
let b = BitCoin()
println(b.description)
println(b.symbol())
//let str = c.formattedString(10, currency: BitCoin())
let str = c.formattedString(10, currency: BitCoin())
println(str)
