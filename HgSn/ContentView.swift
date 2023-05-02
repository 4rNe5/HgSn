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
            Image(systemName: "drop.degreesign")
                .resizable()
                .frame(width: 150, height: 200)
                .imageScale(.large)
//                .foregroundColor(.accentColor)
                .foregroundColor(.blue)
                .padding(20)
            Text("Hello, Hangang!")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.blue)
            
            Text("지금 한강의 온도는 \(temperature)도 입니다!")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.blue)
                .padding(.top, 10)
            
            HStack(spacing: 20) {
                Button("탄천") { sendAPIRequest(number: 0) }
                    .frame(width: 50, height: 30)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(12)
                Button("중랑천") { sendAPIRequest(number: 1) }
                    .frame(width: 50, height: 30)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(10)
            HStack(spacing: 20) {
                Button("안양천") { sendAPIRequest(number: 2) }
                    .frame(width: 50, height: 30)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(12)
                Button("선유") { sendAPIRequest(number: 3) }
                    .frame(width: 50, height: 30)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(12)
                Button("노량진") { sendAPIRequest(number: 4) }
                    .frame(width: 50, height: 30)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.top, 3)
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
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json"]
        )
        .validate()
        .responseData { response in
            
            switch response.result {
                
            case .success:
                
                guard let value = response.value else { return }
                guard let result = try? JSONDecoder().decode(WPOSInformationTime.self, from: value) else { return }
                
                print(result.WPOSInformationTime.RESULT)
                
                temperature = result.WPOSInformationTime.row[number].wTemp
                
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

