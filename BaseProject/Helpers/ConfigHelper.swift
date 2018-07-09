//
// Created by Nguyen Quoc Huy on 7/8/18.
// Copyright (c) 2018 Nguyen Quoc Huy. All rights reserved.
//

import UIKit

public enum ConfigStyle: String {
    case Development = "Development"
    case Production = "Production"
    case Testing = "Testing"
    case Debug = "Debug"
}

public enum ConfigTarget: String {
    case Live = "Browzzin"
    case Beta = "BrowzzinBeta"
}

protocol ConfigHelperProtocol {
    func getEndPoint() -> String;
}

protocol InstagramHelperProtocol {
    func getClientKey() -> String;
    func getClientSecret() -> String;
    func getRedirectURI() -> String;
}

protocol AmazonHelperProtocol {
    func getSNSARN() -> String;
    func getCongitoPoolId() -> String;
}

public class ConfigHelper {
    public static let shared: ConfigHelper = ConfigHelper()
    private var configs: [String: Any]?

    private init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Config") as? String ?? "Production"
        let path = Bundle.main.path(forResource: "Config", ofType: "plist")
        let fileUrl = URL.init(fileURLWithPath: path!)
        let plist = readConfiguration(fileUrl)
        let configuration = plist?[currentConfiguration]

        configs = configuration as? [String: Any]
    }

    private func readConfiguration(_ url: URL) -> [String: Any]? {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        guard let result = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            return nil
        }

        return result
    }
}

extension ConfigHelper: InstagramHelperProtocol {
    func getClientKey() -> String {
        fatalError("getClientKey() has not been implemented")
    }

    func getClientSecret() -> String {
        fatalError("getClientSecret() has not been implemented")
    }

    func getRedirectURI() -> String {
        fatalError("getRedirectURI() has not been implemented")
    }
}

extension ConfigHelper: ConfigHelperProtocol {
    func getEndPoint() -> String {
        return (configs?["APIEndpointURL"] as? String) ?? "https://api.browzzin.com/v1"
    }
}

extension ConfigHelper: AmazonHelperProtocol {
    func getSNSARN() -> String {
        fatalError("getSNSARN() has not been implemented")
    }

    func getCongitoPoolId() -> String {
        fatalError("getCongitoPoolId() has not been implemented")
    }
}
