//
//  File.swift
//  
//
//  Created by xxs on 2024/7/19.
//

import Foundation

struct Network {
    typealias Completion = (AppInfo?) -> Void
    
    static let baseURL = "https://itunes.apple.com/lookup"

    static var regionCode: String {
        var code: String = ""
        if #available(iOS 16, *) {
            code = Locale.current.region?.identifier ?? ""
        } else {
            code = Locale.current.regionCode ?? ""
        }
        return code.lowercased()
    }

    static func request(bundleId: String, completion: @escaping Completion) {
        let date = Int(Date().timeIntervalSince1970)
        guard let url = URL(string: baseURL.appendingFormat("?bundleId=%@&country=%@&date=%zi", bundleId, regionCode, date)) else {
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                let info = try? JSONDecoder().decode(AppInfo.self, from: data)
                DispatchQueue.main.async {
                    completion(info)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
