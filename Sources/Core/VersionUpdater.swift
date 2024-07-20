// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class VersionUpdater {
    public typealias Completion = (AppInfo.Result) -> Void
    private var bundleId: String?
    private var version: String?
    private var bundleInfo: [String: Any]?
    private var completion: Completion?

    public static func startMonitoring(_ completion: Completion? = nil) {
        let updater = VersionUpdater.shared
        updater.completion = completion
        updater.bundleInfo = Bundle.main.infoDictionary
        updater.bundleId = updater.bundleInfo?[Keys.id] as? String
        updater.version = updater.bundleInfo?[Keys.version] as? String
        updater.startRequest()
    }
}

private extension VersionUpdater {
    struct Keys {
        static let version = "CFBundleShortVersionString"
        static let id = "CFBundleIdentifier"
    }
    
    static let shared = VersionUpdater()
    
    func startRequest() {
        guard let bundleId = bundleId else { return }
        Network.request(bundleId: bundleId) { [weak self] info in
            guard let info = info else { return }
            self?.checkAppVersion(info)
        }
    }

    func checkAppVersion(_ info: AppInfo) {
        guard let version = version, let app = info.results.first else { return }
        DispatchQueue.global().async { [weak self] in
            let versions = version.components(separatedBy: ".").compactMap { NSInteger($0) }
            let onlineVersions = app.version.components(separatedBy: ".").compactMap { NSInteger($0) }
            for version in versions {
                for onlineVersion in onlineVersions {
                    if onlineVersion > version {
                        DispatchQueue.main.async {
                            self?.completion?(app)
                        }
                        return
                    } else if onlineVersion < version {
                        print("当前版本太高")
                        return
                    }
                }
            }
        }
    }
}
