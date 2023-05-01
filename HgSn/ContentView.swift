//
//  ContentView.swift
//  HgSn
//
//  Created by 4rNe5 on 2023/05/01.
//
import SwiftUI
import Alamofire

struct ContentView: View {
    
    @State var temperature: String = "0"
    
    var body: some View {
        VStack {
            Image(systemName: "humidity")
                .resizable()
                .frame(width: 200, height: 150)
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Text("Hello, Hangang!")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.blue)
            
            Text("지금 한강은 \(temperature)도 입니다!")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.blue)
                .padding(.top, 10)
            
//            HStack(spacing: 30) {
//                Button("1번") { sendAPIRequest(number: 0) }
//                    .frame(width: 50, height: 30)
//                    .foregroundColor(Color.white)
//                    .background(Color.blue)
//                Button("2번") { sendAPIRequest(number: 1) }
//                    .frame(width: 50, height: 30)
//                    .foregroundColor(Color.white)
//                    .background(Color.blue)
//                Button("3번") { sendAPIRequest(number: 2) }
//                    .frame(width: 50, height: 30)
//                    .foregroundColor(Color.white)
//                    .background(Color.blue)
//                Button("4번") { sendAPIRequest(number: 3) }
//                    .frame(width: 50, height: 30)
//                    .foregroundColor(Color.white)
//                    .background(Color.blue)
//            }
            .padding(.top, 40)
        }
        .padding()
        .onAppear {
            sendAPIRequest(number: 0)
        }
    }
    
    func sendAPIRequest(number: Int) {
        
        let url = "http://openapi.seoul.go.kr:8088/6e416945703233773131316f716e6d53/json/WPOSInformationTime/1/5"
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding(options: []),
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .validate()
        .responseData { response in
            print(response)
            
            switch response.result {
                
            case .success:
                guard let value = response.value else { return }
                guard let result = try? JSONDecoder().decode(RiverTemperature.self, from: value) else { return }
                
                print(result)
                
                self.temperature = result.wposInformationTime.row[number].wTemp
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

