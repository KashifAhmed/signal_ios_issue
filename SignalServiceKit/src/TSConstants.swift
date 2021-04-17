//
//  Copyright (c) 2021 Open Whisper Systems. All rights reserved.
//

private protocol TSConstantsProtocol: class {
    var textSecureWebSocketAPI: String { get }
    var textSecureServerURL: String { get }
    var textSecureCDN0ServerURL: String { get }
    var textSecureCDN2ServerURL: String { get }
    var contactDiscoveryURL: String { get }
    var keyBackupURL: String { get }
    var storageServiceURL: String { get }
    var sfuURL: String { get }
    var kUDTrustRoot: String { get }

    var censorshipReflectorHost: String { get }

    var serviceCensorshipPrefix: String { get }
    var cdn0CensorshipPrefix: String { get }
    var cdn2CensorshipPrefix: String { get }
    var contactDiscoveryCensorshipPrefix: String { get }
    var keyBackupCensorshipPrefix: String { get }
    var storageServiceCensorshipPrefix: String { get }

    var contactDiscoveryEnclaveName: String { get }
    var contactDiscoveryMrEnclave: String { get }

    var keyBackupEnclave: KeyBackupEnclave { get }
    var keyBackupPreviousEnclaves: [KeyBackupEnclave] { get }

    var applicationGroup: String { get }

    var serverPublicParamsBase64: String { get }
}

public struct KeyBackupEnclave: Equatable {
    let name: String
    let mrenclave: String
    let serviceId: String
}

// MARK: -

@objc
public class TSConstants: NSObject {

    @objc
    public static let EnvironmentDidChange = Notification.Name("EnvironmentDidChange")

    // Never instantiate this class.
    private override init() {}

    @objc
    public static var textSecureWebSocketAPI: String { return shared.textSecureWebSocketAPI }
    @objc
    public static var textSecureServerURL: String { return shared.textSecureServerURL }
    @objc
    public static var textSecureCDN0ServerURL: String { return shared.textSecureCDN0ServerURL }
    @objc
    public static var textSecureCDN2ServerURL: String { return shared.textSecureCDN2ServerURL }
    @objc
    public static var contactDiscoveryURL: String { return shared.contactDiscoveryURL }
    @objc
    public static var keyBackupURL: String { return shared.keyBackupURL }
    @objc
    public static var storageServiceURL: String { return shared.storageServiceURL }
    @objc
    public static var sfuURL: String { return shared.sfuURL }
    @objc
    public static var kUDTrustRoot: String { return shared.kUDTrustRoot }

    @objc
    public static var censorshipReflectorHost: String { return shared.censorshipReflectorHost }

    @objc
    public static var serviceCensorshipPrefix: String { return shared.serviceCensorshipPrefix }
    @objc
    public static var cdn0CensorshipPrefix: String { return shared.cdn0CensorshipPrefix }
    @objc
    public static var cdn2CensorshipPrefix: String { return shared.cdn2CensorshipPrefix }
    @objc
    public static var contactDiscoveryCensorshipPrefix: String { return shared.contactDiscoveryCensorshipPrefix }
    @objc
    public static var keyBackupCensorshipPrefix: String { return shared.keyBackupCensorshipPrefix }
    @objc
    public static var storageServiceCensorshipPrefix: String { return shared.storageServiceCensorshipPrefix }

    @objc
    public static var contactDiscoveryEnclaveName: String { return shared.contactDiscoveryEnclaveName }
    @objc
    public static var contactDiscoveryMrEnclave: String { return shared.contactDiscoveryMrEnclave }

    static var keyBackupEnclave: KeyBackupEnclave { shared.keyBackupEnclave }
    static var keyBackupPreviousEnclaves: [KeyBackupEnclave] { shared.keyBackupPreviousEnclaves }

    @objc
    public static var applicationGroup: String { return shared.applicationGroup }

    @objc
    public static var serverPublicParamsBase64: String { return shared.serverPublicParamsBase64 }

    @objc
    public static var isUsingProductionService: Bool {
        return environment == .production
    }

    private enum Environment {
        case production, staging
    }

    private static let serialQueue = DispatchQueue(label: "TSConstants")
    private static var _forceEnvironment: Environment?
    private static var forceEnvironment: Environment? {
        get {
            return serialQueue.sync {
                return _forceEnvironment
            }
        }
        set {
            serialQueue.sync {
                _forceEnvironment = newValue
            }
        }
    }

    private static var environment: Environment {
        if let environment = forceEnvironment {
            return environment
        }
        return FeatureFlags.isUsingProductionService ? .production : .staging
    }

    @objc
    public class func forceStaging() {
        forceEnvironment = .staging
    }

    @objc
    public class func forceProduction() {
        forceEnvironment = .production
    }

    private static var shared: TSConstantsProtocol {
        switch environment {
        case .production:
            return TSConstantsProduction()
        case .staging:
            return TSConstantsStaging()
        }
    }
}

// MARK: -

private class TSConstantsProduction: TSConstantsProtocol {

    public let textSecureWebSocketAPI = "wss://54.213.247.43/v1/websocket/"
    public let textSecureServerURL = "https://54.213.247.43/"
    public let textSecureCDN0ServerURL = "https://d13div0765suhn.cloudfront.net"
    public let textSecureCDN2ServerURL = "https://d13div0765suhn.cloudfront.net"
    public let contactDiscoveryURL = "http://54.213.247.43"
    public let keyBackupURL = "http://54.213.247.43"
    public let storageServiceURL = "https://d13div0765suhn.cloudfront.net"
    public let sfuURL = "https://sfu.voip.signal.org"
    public let kUDTrustRoot = "BbbhMIlEDWAhg8SejhMOaXkFuJqOgixkWdedIKIe19YM"

    public let censorshipReflectorHost = "europe-west1-signal-cdn-reflector.cloudfunctions.net"

    public let serviceCensorshipPrefix = "service"
    public let cdn0CensorshipPrefix = "cdn"
    public let cdn2CensorshipPrefix = "cdn2"
    public let contactDiscoveryCensorshipPrefix = "directory"
    public let keyBackupCensorshipPrefix = "backup"
    public let storageServiceCensorshipPrefix = "storage"

    public let contactDiscoveryEnclaveName = "c98e00a4e3ff977a56afefe7362a27e4961e4f19e211febfbb19b897e6b80b15"
    public var contactDiscoveryMrEnclave: String {
        return contactDiscoveryEnclaveName
    }

    public let keyBackupEnclave = KeyBackupEnclave(
        name: "fe7c1bfae98f9b073d220366ea31163ee82f6d04bead774f71ca8e5c40847bfe",
        mrenclave: "a3baab19ef6ce6f34ab9ebb25ba722725ae44a8872dc0ff08ad6d83a9489de87",
        serviceId: "fe7c1bfae98f9b073d220366ea31163ee82f6d04bead774f71ca8e5c40847bfe"
    )

    // An array of previously used enclaves that we should try and restore
    // key material from during registration. These must be ordered from
    // newest to oldest, so we check the latest enclaves for backups before
    // checking earlier enclaves.
    public let keyBackupPreviousEnclaves = [KeyBackupEnclave]()

    public let applicationGroup = "group.org.whispersystems.signal.group"

    // We need to discard all profile key credentials if these values ever change.
    // See: GroupsV2Impl.verifyServerPublicParams(...)
    public let serverPublicParamsBase64 = "7H4BZ8fOx2btM/78tw+OT2oaSlnwZdp7McpR3OZcSAN0lbmc8imiiW6FCJzEJg2RuQhLfkmHHj+nQAA87gylC8BpSD3b3XUM4ZF3QFAHugHJ1QIzxKzKMr10w0R2yPN2eI0mHjygTq8ABLAPWmhaKTGHJKHH1WlqAEiN9EZipgJwCJMeMtyBEJDrcWu8HFp4SFYAsMIUXNTybT5YkFuCCw"
}

// MARK: -

private class TSConstantsStaging: TSConstantsProtocol {


    public let textSecureWebSocketAPI = "wss://54.213.247.43/v1/websocket/"
    public let textSecureServerURL = "https://54.213.247.43/"
    public let textSecureCDN0ServerURL = "https://d13div0765suhn.cloudfront.net"
    public let textSecureCDN2ServerURL = "https://d13div0765suhn.cloudfront.net"
    public let contactDiscoveryURL = "http://54.213.247.43"
    public let keyBackupURL = "http://54.213.247.43"
    public let storageServiceURL = "https://d13div0765suhn.cloudfront.net"
    public let sfuURL = "https://sfu.voip.signal.org"
    public let kUDTrustRoot = "BbbhMIlEDWAhg8SejhMOaXkFuJqOgixkWdedIKIe19YM"

    public let censorshipReflectorHost = "europe-west1-signal-cdn-reflector.cloudfunctions.net"

    public let serviceCensorshipPrefix = "service"
    public let cdn0CensorshipPrefix = "cdn"
    public let cdn2CensorshipPrefix = "cdn2"
    public let contactDiscoveryCensorshipPrefix = "directory"
    public let keyBackupCensorshipPrefix = "backup"
    public let storageServiceCensorshipPrefix = "storage"

    public let contactDiscoveryEnclaveName = "c98e00a4e3ff977a56afefe7362a27e4961e4f19e211febfbb19b897e6b80b15"
    public var contactDiscoveryMrEnclave: String {
        return contactDiscoveryEnclaveName
    }

    public let keyBackupEnclave = KeyBackupEnclave(
        name: "dcd2f0b7b581068569f19e9ccb6a7ab1a96912d09dde12ed1464e832c63fa948",
        mrenclave: "9db0568656c53ad65bb1c4e1b54ee09198828699419ec0f63cf326e79827ab23",
        serviceId: "1f182fbdbf4c996e4629c72166df1da1713e2f0a88afb1010e46eeac887228b6"
    )

    // An array of previously used enclaves that we should try and restore
    // key material from during registration. These must be ordered from
    // newest to oldest, so we check the latest enclaves for backups before
    // checking earlier enclaves.
    public let keyBackupPreviousEnclaves = [
        KeyBackupEnclave(
            name: "823a3b2c037ff0cbe305cc48928cfcc97c9ed4a8ca6d49af6f7d6981fb60a4e9",
            mrenclave: "a3baab19ef6ce6f34ab9ebb25ba722725ae44a8872dc0ff08ad6d83a9489de87",
            serviceId: "51a56084c0b21c6b8f62b1bc792ec9bedac4c7c3964bb08ddcab868158c09982"
        )
    ]

    public let applicationGroup = "group.org.whispersystems.signal.group.staging"

    // We need to discard all profile key credentials if these values ever change.
    // See: GroupsV2Impl.verifyServerPublicParams(...)
    public let serverPublicParamsBase64 = "ABSY21VckQcbSXVNCGRYJcfWHiAMZmpTtTELcDmxgdFbtp/bWsSxZdMKzfCp8rvIs8ocCU3B37fT3r4Mi5qAemeGeR2X+/YmOGR5ofui7tD5mDQfstAI9i+4WpMtIe8KC3wU5w3Inq3uNWVmoGtpKndsNfwJrCg0Hd9zmObhypUnSkfYn2ooMOOnBpfdanRtrvetZUayDMSC5iSRcXKpdls=="
}
