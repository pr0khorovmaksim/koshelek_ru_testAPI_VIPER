//
//  Constants.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 09.11.2020.
//

import Foundation

final class Constants {
    
    let appTitle = "Test Application"
    let tabBarBidIcon = "plusIcon"
    let tabBarAskIcon = "minusIcon"
    let tabBarDetailsIcon = "infoIcon"
    
    let tabBarBidItem = "Info: Bid"
    let tabBarAskItem = "Info: Ask"
    let tabBarDetailsItem = "Details"
    
    let cellValue = "Cell"
    let cellSecondValue = "Cell2"
    
    let socketUrl = "wss://stream.binance.com:9443/ws/btcusdt@depth@1000ms"
    let socketUrlEndpoint = "wss://stream.binance.com:9443"
    let socletUrlWs = "/ws/"
    let socletUrlDiffDepthStreamName = "@depth@1000ms"
    
    let arrayСurrencies =  ["BTCUSDT", "BNBBTC", "ETHBTC"]
    
    let dateFormat = "yyyy/MM/dd HH:mm:ss"
    
    let selectWord = "BTC / USDT"
    let zeroValue = "0.0"
    let amountValue = "Amount BTC"
    let priceValue = "Price USDT"
    let totalValue = "Total"
    let bidValue = "Bid price"
    let askValue = "Ask price"
    let diffValue = "DIFF"
    
    let dropdownOutIcon = "arrowIcon"
}

