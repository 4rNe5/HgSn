struct WPOSInformationTime: Decodable {
    let WPOSInformationTime: Data
}

struct Data: Decodable {
    let list_total_count: Int
    let RESULT: Result
    let row: [Row]
}

struct Result: Decodable {
    let CODE, MESSAGE: String
}

struct Row: Decodable {
    let msrDate, msrTime, siteID, wTemp, wPH, wDO, wTN, wTP, wTOC, wPHEN, wCN: String

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
