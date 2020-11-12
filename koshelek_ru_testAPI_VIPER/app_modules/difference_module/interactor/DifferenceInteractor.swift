//
//  DifferenceInteractor.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 07.11.2020.
//

import Foundation
import Starscream

final class DifferenceInteractor : PresenterToDifferenceInteractorProtocol, WebSocketDelegate{
    
    var presenter: InteractorToDifferencePresenterProtocol?
    
    fileprivate static let constants : Constants = Constants()
    fileprivate var socket = WebSocket(url: URL(string: constants.socketUrl)!)
    fileprivate var timer : Timer?
    fileprivate var selectArray : [String]? = constants.arrayСurrencies
    
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
        
        let bb = dataProcessing(text : text, arr : b)
        let aa = dataProcessing(text : text, arr : a)
        
        let response = DifferenceResponse(e: e, E: E, s: s, U: U, u: u, b: bb, a: aa)
        presenter?.dataTransfer(response: response)
    }
    
    private func dataProcessing(text : String?, arr : [[String]]) -> [[Double]]{
        
        var array : [[Double]] = []
        for i in 0..<arr.count{
            let price = Double(arr[i][0])?.rounded(toPlaces: 6) ?? 0 // Price level to be updated
            let diff = Double(arr[i][1])?.rounded(toPlaces: 4) ?? 0 // Quantity
            array.append([])
            for _ in 0..<arr[i].count{
                array[i].append(price)
                array[i].append(diff)
            }
        }
        return array
    }
    
    func timerProcessing(){
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkTime), userInfo: nil, repeats: true)
    }
    
    @objc private func checkTime(){
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DifferenceInteractor.constants.dateFormat
        let timer = formatter.string(from: currentDateTime)
        presenter?.timerTransfer(timer : timer)
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
        let url = DifferenceInteractor.constants.socketUrlEndpoint + DifferenceInteractor.constants.socletUrlWs + selectString + DifferenceInteractor.constants.socletUrlDiffDepthStreamName
        socket = WebSocket(url: URL(string: url)!)
        webSocketConnect()
    }
    
    func startProcessing(){
        
        let arr = arrForButton()
        presenter?.dataForButtonTransfer(selectArray: arr)
        webSocketConnect()
    }
    
    func stopProcessing(){
        
        webSocketDiconnect()
        timer = nil
        timer?.invalidate()
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

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
