//
//  Map.swift
//  EnergiseTestApp
//


import Foundation

struct Map: Codable {
    let status, country, countryCode, region: String?
    let regionName, city, zip: String?
    let lat, lon: Double?
    let timezone, isp, org, mapAs: String?
    let query: String?

    enum CodingKeys: String, CodingKey {
        case status, country, countryCode, region, regionName, city, zip, lat, lon, timezone, isp, org
        case mapAs = "as"
        case query
    }
}
