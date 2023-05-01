//
//  ContentView.swift
//  HgSn
//
//  Created by 4rNe5 on 2023/05/01.
//
import SwiftUI
import Alamofire

struct ContentView: View {
    
    @State var temp: RiverTemperature?
    
    func sendAPIRequest() {
        let url = "http://openapi.seoul.go.kr:8088/6e416945703233773131316f716e6d53/json/WPOSInformationTime/1/5"
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding(options: []),
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                do {
                    // 응답 데이터를 JSON 데이터로 변환하지 않고, response.data를 그대로 사용하여 디코딩
                    self.temp = try JSONDecoder().decode(RiverTemperature.self, from: response.data!)
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "humidity")
                .resizable()
                .frame(width: 200, height: 150)
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, Hangang!")
                .font(.system(size: 25))
                .bold()
                .foregroundColor(.blue)
                .padding()
            Text("지금 한강은 \(temp?.wposInformationTime.row.first?.wTemp ?? "")도 입니다!")
                .font(.system(size: 18))
                .bold()
                .foregroundColor(.blue)
        }
        .padding()
        .onAppear {
            sendAPIRequest()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

