//
//  File.swift
//  
//
//  Created by liyb on 2024/7/20.
//

import Foundation

public struct AppInfo: Codable {
    public struct Result: Codable {
        public var screenshotUrls: [String]
        public var artistViewUrl: String
        public var kind: String
        public var averageUserRating: CGFloat
        public var trackCensoredName: String
        public var fileSizeBytes: String
        public var formattedPrice: String
        public var trackViewUrl: String
        public var trackContentRating: String
        public var currentVersionReleaseDate: String   // 当前版本发布时间
        public var releaseNotes: String    // 更新信息
        public var description: String // 介绍
        public var releaseDate: String // 第一版发布时间
        public var sellerName: String  // 开发者
        public var primaryGenreName: String    // 主类别
        public var primaryGenreId: Int
        public var bundleId: String
        public var trackId: Int
        public var trackName: String
        public var minimumOsVersion: String
        public var version: String
        public var wrapperType: String
        public var genres: [String]    // 类别
        public var price: CGFloat
        public var artistId: Int
        public var artistName: String
        public var userRatingCount: Int
    }

    var resultCount: Int
    var results: [Result]
}
