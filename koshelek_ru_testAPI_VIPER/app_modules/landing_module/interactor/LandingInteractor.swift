//
//  LandingInteractor.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 06.11.2020.
//

import Foundation
import Starscream

final class LandingInteractor : PresenterToLandingInteractorProtocol, WebSocketDelegate {
    
    var presenter: InteractorToLandingPresenterProtocol?
    
    fileprivate static let constants : Constants = Constants()
    fileprivate var landingResponse : LandingResponse? = nil
    fileprivate  var selectArray : [String]? = constants.arrayСurrencies
    fileprivate var socket = WebSocket(url: URL(string: constants.socketUrl)!)
    fileprivate var from : From?
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(String(error?.localizedDescription ?? ""))")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        responseSocketText(text : text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
    }
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    
    private func responseSocketText(text : String?){
        
        guard let data = text?.data(using: .utf8),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let jsonDict = jsonData as? [String : Any] else { return }
        
        let e = jsonDict["e"] as! String     // Event type
        let E = jsonDict["E"] as! Int        // Event time
        let s = jsonDict["s"] as! String     // Symbol
        let U = jsonDict["U"] as! Int        // First update ID in event
        let u = jsonDict["u"] as! Int        // Final update ID in event
        let b = jsonDict["b"] as! [[String]] // Bids to be updated
        let a = jsonDict["a"] as! [[String]] // Asks to be updated
        
        switch from {
        case .bid:
            let bb = dataProcessing(text : text, arr : b)
            let response = LandingResponse(e: e, E: E, s: s, U: U, u: u, b: bb, a: [])
            presenter?.dataTransfer(response: response)
        case .ask:
            let aa = dataProcessing(text : text, arr : a)
            let response = LandingResponse(e: e, E: E, s: s, U: U, u: u, b: [], a: aa)
            presenter?.dataTransfer(response: response)
        default:
            return
        }
    }
    
    private func dataProcessing(text : String?, arr : [[String]]) -> [[Double]]{
        
        var array : [[Double]] = []
        for i in 0..<arr.count{
            let price = Double(arr[i][0])?.rounded(toPlaces: 6) ?? 0 // Price level to be updated
            let amount = Double(arr[i][1])?.rounded(toPlaces: 4) ?? 0 // Quantity
            let total = Double(price * amount).rounded(toPlaces: 2) // Total
            array.append([])
            for _ in 0..<arr[i].count{
                array[i].append(price)
                array[i].append(amount)
                array[i].append(total)
            }
        }
        return array
    }
    
    private func arrForButton() -> [String]{
        
        var arr : [String]? = []
        for i in 0..<selectArray!.count{
            var selectWord = selectArray![i]
            selectWord.insert(contentsOf: " / ", at: selectWord.index(selectWord.startIndex, offsetBy: 3))
            arr?.append(selectWord)
        }
        return arr!
    }
    
    func selectDataProcessing(select : Int?){
        
        webSocketDiconnect()
        let selectString = selectArray![select ?? 0].lowercased()
        let url = LandingInteractor.constants.socketUrlEndpoint + LandingInteractor.constants.socletUrlWs + selectString + LandingInteractor.constants.socletUrlDiffDepthStreamName
        socket = WebSocket(url: URL(string: url)!)
        webSocketConnect()
    }
    
    func startProcessing(from : From?){
        
        let arr = arrForButton()
        presenter?.fromTabBarTransfer(from : from, selectArray : arr)
        self.from = from
        webSocketConnect()
    }
    
    func stopProcessing(){
        
        webSocketDiconnect()
    }
    
    private func webSocketConnect(){
        
        socket.delegate = self
        socket.connect()
    }
    
    private func webSocketDiconnect(){
        
        socket.disconnect(forceTimeout: 0, closeCode: 0)
        socket.delegate = nil
    }
}
