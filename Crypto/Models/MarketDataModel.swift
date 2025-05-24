//
//  MarketDataModel.swift
//  Crypto
//
//  Created by Nayan on 25/05/25.
//

import Foundation

// JSON DATA:
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON RESPONSE:
 {
   "data": {
     "active_cryptocurrencies": 17192,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1272,
     "total_market_cap": {
       "btc": 32524395.705536,
       "eth": 1392993163.56311,
       "ltc": 36693642201.7108,
       "bch": 8322664432.32963,
       "bnb": 5265200213.19939,
       "eos": 4784133705547.39,
       "xrp": 1509803793844.96,
       "xlm": 12339349645182.6,
       "link": 229636618594.014,
       "dot": 775654323616.439,
       "yfi": 631758308.338764,
       "usd": 3517804243522.97,
       "aed": 12920771863311.4,
       "ars": 3.98092710860572e+15,
       "aud": 5415339512717.45,
       "bdt": 428625359467449,
       "bhd": 1326184057374.21,
       "bmd": 3517804243522.97,
       "brl": 19860819198082,
       "cad": 4832231799115.33,
       "chf": 2889767134122.57,
       "clp": 3.3117312709374e+15,
       "cny": 25259945151041.1,
       "czk": 76922418271419.4,
       "dkk": 23094736639152.7,
       "eur": 3093989741676.05,
       "gbp": 2597507957570.68,
       "gel": 9638783627252.94,
       "hkd": 27555066173642.7,
       "huf": 1249770313596406,
       "idr": 57151127191335080,
       "ils": 12703758519528.4,
       "inr": 299280889712173,
       "jpy": 501480683137497,
       "krw": 4804369301475431,
       "kwd": 1078277356724.66,
       "lkr": 1.05351676388599e+15,
       "mmk": 7380353302911193,
       "mxn": 67695217740658.7,
       "myr": 14883829754345.7,
       "ngn": 5592605186352819,
       "nok": 35551985026316.2,
       "nzd": 5876720646080.95,
       "php": 194710443772171,
       "pkr": 991836150646540,
       "pln": 13182285430774.9,
       "rub": 279579792897963,
       "sar": 13194221340573.1,
       "sek": 33533117170958.4,
       "sgd": 4528001534722.73,
       "thb": 114305044001435,
       "try": 136777150396310,
       "twd": 105461653502664,
       "uah": 146069859477693,
       "vef": 352237738903.955,
       "vnd": 91300401776407400,
       "zar": 62775779574346.4,
       "xdr": 2540329567396.46,
       "xag": 105024819607.312,
       "xau": 1047777993.93332,
       "bits": 32524395705536,
       "sats": 3252439570553604
     },
     "total_volume": {
       "btc": 803272.855180037,
       "eth": 34403516.8515414,
       "ltc": 906243024.626157,
       "bch": 205549412.256254,
       "bnb": 130037540.025112,
       "eos": 118156376401.606,
       "xrp": 37288453111.4306,
       "xlm": 304751691938.845,
       "link": 5671461629.66236,
       "dot": 19156760629.9312,
       "yfi": 15602881.7481338,
       "usd": 86881142519.6801,
       "aed": 319111395634.797,
       "ars": 98319142152394.5,
       "aud": 133745612725.078,
       "bdt": 10585995798943.7,
       "bhd": 32753495680.7792,
       "bmd": 86881142519.6801,
       "brl": 490513554437.61,
       "cad": 119344281422.159,
       "chf": 71370165264.4991,
       "clp": 81791645190877.2,
       "cny": 623858731976.815,
       "czk": 1899795191020.84,
       "dkk": 570383388755.952,
       "eur": 76413963112.3366,
       "gbp": 64152079943.9641,
       "gel": 238054330503.924,
       "hkd": 680542595790.93,
       "huf": 30866263502966.8,
       "idr": 1.41149276166035e+15,
       "ils": 313751697952.758,
       "inr": 7391504425061.43,
       "jpy": 12385343721941.2,
       "krw": 118656146022679,
       "kwd": 26630807805.1324,
       "lkr": 26019281851336.2,
       "mmk": 182276637006289,
       "mxn": 1671905954191.72,
       "myr": 367594114000.767,
       "ngn": 138123640377787,
       "nok": 878046890646.643,
       "nzd": 145140595853.389,
       "php": 4808870717177.44,
       "pkr": 24495921886260.1,
       "pln": 325570139769.71,
       "rub": 6904935622018.79,
       "sar": 325864927486.279,
       "sek": 828185802954.599,
       "sgd": 111830539573.629,
       "thb": 2823054420066.72,
       "try": 3378060367883.55,
       "twd": 2604644350292.21,
       "uah": 3607567505348.67,
       "vef": 8699408800.49557,
       "vnd": 2254896142514221,
       "zar": 1550407889246.49,
       "xdr": 62739913853.4492,
       "xag": 2593855623.7764,
       "xau": 25877548.2994867,
       "bits": 803272855180.037,
       "sats": 80327285518003.7
     },
     "market_cap_percentage": {
       "btc": 61.0907426846559,
       "eth": 8.65902565495452,
       "usdt": 4.32588786912656,
       "xrp": 3.88321444861286,
       "bnb": 2.76828969239165,
       "sol": 2.6020710775894,
       "usdc": 1.74789711007688,
       "doge": 0.956223755790484,
       "ada": 0.763481879905366,
       "trx": 0.727069106001
     },
     "market_cap_change_percentage_24h_usd": -2.37100360024204,
     "updated_at": 1748126604
   }
 }

 Enable Expert Mode


 */

struct GlobalDataModel: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let activeCryptocurrencies, upcomingIcos, ongoingIcos, endedIcos: Double?
    let markets: Double?
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentageString()
        }
        return ""
    }
}


extension MarketDataModel {
    
    var ethDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "eth" }) {
            return item.value.asPercentageString()
        }
        return ""
    }
    
    var usdtDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "usdt" }) {
            return item.value.asPercentageString()
        }
        return ""
    }
    
    var altcoinDominance: String {
        if let btcPercentage = marketCapPercentage["btc"] {
            let altcoinPercentage = 100 - btcPercentage
            return altcoinPercentage.asPercentageString()
        }
        return ""
    }
    
    var activeCryptocurrenciesFormatted: String {
        guard let count = activeCryptocurrencies else { return "" }
        return count.formattedWithAbbreviations()
    }
    
    var marketsFormatted: String {
        guard let count = markets else { return "" }
        return count.formattedWithAbbreviations()
    }
    
    var ongoingIcosFormatted: String {
        guard let count = ongoingIcos else { return "" }
        return "\(count)"
    }
    
    var endedIcosFormatted: String {
        guard let count = endedIcos else { return "" }
        return count.formattedWithAbbreviations()
    }
    
    var volumeToMarketCapRatio: String {
        guard let marketCapUSD = totalMarketCap["usd"],
              let volumeUSD = totalVolume["usd"],
              marketCapUSD > 0 else { return "" }
        
        let ratio = (volumeUSD / marketCapUSD) * 100
        return ratio.asPercentageString()
    }
    
    var top10Dominance: String {
        let top10Total = marketCapPercentage.values.reduce(0, +)
        return top10Total.asPercentageString()
    }
    
    var stablecoinDominance: String {
        let usdtPercentage = marketCapPercentage["usdt"] ?? 0
        let usdcPercentage = marketCapPercentage["usdc"] ?? 0
        let stablecoinTotal = usdtPercentage + usdcPercentage
        return stablecoinTotal.asPercentageString()
    }
}
