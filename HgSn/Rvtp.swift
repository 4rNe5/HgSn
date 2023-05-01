//
//  Rvtp.swift
//  HgSn
//
//  Created by 4rNe5 on 2023/05/01.
//

struct RiverTemperature: Codable {
    let listTotalCount: Int
    let result: Result
    let wposInformationTime: WposInformationTime

    enum CodingKeys: String, CodingKey {
        case listTotalCount = "list_total_count"
        case result
        case wposInformationTime = "WPOSInformationTime"
    }
}

struct Result: Codable {
    let code, message: String
}

struct WposInformationTime: Codable {
    let row: [Row]
}

struct Row: Codable {
    let msrDate, msrTime, siteID, wTemp: String
    let wPH, wDO, wTN, wTP: String
    let wTOC, wPHEN, wCN: String

    enum CodingKeys: String, CodingKey {
        case msrDate = "MSR_DATE"
        case msrTime = "MSR_TIME"
        case siteID = "SITE_ID"
        case wTemp = "W_TEMP"
        case wPH = "W_PH"
        case wDO = "W_DO"
        case wTN = "W_TN"
        case wTP = "W_TP"
        case wTOC = "W_TOC"
        case wPHEN = "W_PHEN"
        case wCN = "W_CN"
    }
}
