//
//  Typedefs.swift
//  Steamworks
//
//  Licensed under MIT (https://github.com/johnfairh/swift-steamworks/blob/main/LICENSE
//
//  This file is generated code: any edits will be overwritten.

@_implementationOnly import CSteamworks

/// Steamworks `AppId_t`
public struct AppId: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension AppId: SteamTypeAlias {}

/// Steamworks `DepotId_t`
public struct DepotId: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension DepotId: SteamTypeAlias {}

/// Steamworks `RTime32`
public struct RTime32: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension RTime32: SteamTypeAlias {}

/// Steamworks `SteamAPICall_t`
public struct SteamAPICall: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension SteamAPICall: SteamTypeAlias {}

/// Steamworks `AccountID_t`
public struct AccountID: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension AccountID: SteamTypeAlias {}

/// Steamworks `PartyBeaconID_t`
public struct PartyBeaconID: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension PartyBeaconID: SteamTypeAlias {}

/// Steamworks `HAuthTicket`
public struct HAuthTicket: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension HAuthTicket: SteamTypeAlias {}

/// Steamworks `PFNPreMinidumpCallback`
public typealias PFNPreMinidumpCallback = (UnsafeMutableRawPointer) -> Void

/// Steamworks `HSteamPipe`
public struct HSteamPipe: Hashable {
    public let value: Int32
    public init(_ value: Int32) { self.value = value }
}

extension HSteamPipe: SteamTypeAlias {}

/// Steamworks `HSteamUser`
public struct HSteamUser: Hashable {
    public let value: Int32
    public init(_ value: Int32) { self.value = value }
}

extension HSteamUser: SteamTypeAlias {}

/// Steamworks `FriendsGroupID_t`
public struct FriendsGroupID: Hashable {
    public let value: Int16
    public init(_ value: Int16) { self.value = value }
}

extension FriendsGroupID: SteamTypeAlias {}

/// Steamworks `HServerListRequest`
public struct HServerListRequest: Hashable {
    public let value: UnsafeMutableRawPointer
    public init(_ value: UnsafeMutableRawPointer) { self.value = value }
}

extension HServerListRequest: SteamTypeAlias {}

/// Steamworks `HServerQuery`
public struct HServerQuery: Hashable {
    public let value: Int32
    public init(_ value: Int32) { self.value = value }
}

extension HServerQuery: SteamTypeAlias {}

/// Steamworks `UGCHandle_t`
public struct UGCHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension UGCHandle: SteamTypeAlias {}

/// Steamworks `PublishedFileUpdateHandle_t`
public struct PublishedFileUpdateHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension PublishedFileUpdateHandle: SteamTypeAlias {}

/// Steamworks `PublishedFileId_t`
public struct PublishedFileId: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension PublishedFileId: SteamTypeAlias {}

/// Steamworks `UGCFileWriteStreamHandle_t`
public struct UGCFileWriteStreamHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension UGCFileWriteStreamHandle: SteamTypeAlias {}

/// Steamworks `SteamLeaderboard_t`
public struct SteamLeaderboard: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension SteamLeaderboard: SteamTypeAlias {}

/// Steamworks `SteamLeaderboardEntries_t`
public struct SteamLeaderboardEntries: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension SteamLeaderboardEntries: SteamTypeAlias {}

/// Steamworks `SNetSocket_t`
public struct SNetSocket: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension SNetSocket: SteamTypeAlias {}

/// Steamworks `SNetListenSocket_t`
public struct SNetListenSocket: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension SNetListenSocket: SteamTypeAlias {}

/// Steamworks `ScreenshotHandle`
public struct ScreenshotHandle: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension ScreenshotHandle: SteamTypeAlias {}

/// Steamworks `HTTPRequestHandle`
public struct HTTPRequestHandle: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension HTTPRequestHandle: SteamTypeAlias {}

/// Steamworks `HTTPCookieContainerHandle`
public struct HTTPCookieContainerHandle: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension HTTPCookieContainerHandle: SteamTypeAlias {}

/// Steamworks `InputHandle_t`
public struct InputHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension InputHandle: SteamTypeAlias {}

/// Steamworks `InputActionSetHandle_t`
public struct InputActionSetHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension InputActionSetHandle: SteamTypeAlias {}

/// Steamworks `InputDigitalActionHandle_t`
public struct InputDigitalActionHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension InputDigitalActionHandle: SteamTypeAlias {}

/// Steamworks `InputAnalogActionHandle_t`
public struct InputAnalogActionHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension InputAnalogActionHandle: SteamTypeAlias {}

/// Steamworks `SteamInputActionEventCallbackPointer`
public typealias SteamInputActionEventCallbackPointer = (SteamInputActionEvent) -> Void

/// Steamworks `ControllerHandle_t`
public struct ControllerHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension ControllerHandle: SteamTypeAlias {}

/// Steamworks `ControllerActionSetHandle_t`
public struct ControllerActionSetHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension ControllerActionSetHandle: SteamTypeAlias {}

/// Steamworks `ControllerDigitalActionHandle_t`
public struct ControllerDigitalActionHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension ControllerDigitalActionHandle: SteamTypeAlias {}

/// Steamworks `ControllerAnalogActionHandle_t`
public struct ControllerAnalogActionHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension ControllerAnalogActionHandle: SteamTypeAlias {}

/// Steamworks `UGCQueryHandle_t`
public struct UGCQueryHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension UGCQueryHandle: SteamTypeAlias {}

/// Steamworks `UGCUpdateHandle_t`
public struct UGCUpdateHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension UGCUpdateHandle: SteamTypeAlias {}

/// Steamworks `HHTMLBrowser`
public struct HHTMLBrowser: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension HHTMLBrowser: SteamTypeAlias {}

/// Steamworks `SteamItemInstanceID_t`
public struct SteamItemInstanceID: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension SteamItemInstanceID: SteamTypeAlias {}

/// Steamworks `SteamItemDef_t`
public struct SteamItemDef: Hashable {
    public let value: Int32
    public init(_ value: Int32) { self.value = value }
}

extension SteamItemDef: SteamTypeAlias {}

/// Steamworks `SteamInventoryResult_t`
public struct SteamInventoryResult: Hashable {
    public let value: Int32
    public init(_ value: Int32) { self.value = value }
}

extension SteamInventoryResult: SteamTypeAlias {}

/// Steamworks `SteamInventoryUpdateHandle_t`
public struct SteamInventoryUpdateHandle: Hashable {
    public let value: UInt64
    public init(_ value: UInt64) { self.value = value }
}

extension SteamInventoryUpdateHandle: SteamTypeAlias {}

/// Steamworks `RemotePlaySessionID_t`
public struct RemotePlaySessionID: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension RemotePlaySessionID: SteamTypeAlias {}

/// Steamworks `FnSteamNetConnectionStatusChanged`
public typealias FnSteamNetConnectionStatusChanged = (SteamNetConnectionStatusChangedCallback) -> Void

/// Steamworks `FnSteamNetAuthenticationStatusChanged`
public typealias FnSteamNetAuthenticationStatusChanged = (SteamNetAuthenticationStatus) -> Void

/// Steamworks `FnSteamRelayNetworkStatusChanged`
public typealias FnSteamRelayNetworkStatusChanged = (SteamRelayNetworkStatus) -> Void

/// Steamworks `FnSteamNetworkingMessagesSessionRequest`
public typealias FnSteamNetworkingMessagesSessionRequest = (SteamNetworkingMessagesSessionRequest) -> Void

/// Steamworks `FnSteamNetworkingMessagesSessionFailed`
public typealias FnSteamNetworkingMessagesSessionFailed = (SteamNetworkingMessagesSessionFailed) -> Void

/// Steamworks `HSteamNetConnection`
public struct HSteamNetConnection: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension HSteamNetConnection: SteamTypeAlias {}

/// Steamworks `HSteamListenSocket`
public struct HSteamListenSocket: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension HSteamListenSocket: SteamTypeAlias {}

/// Steamworks `HSteamNetPollGroup`
public struct HSteamNetPollGroup: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension HSteamNetPollGroup: SteamTypeAlias {}

/// Steamworks `SteamNetworkingErrMsg`
public struct SteamNetworkingErrMsg: Hashable {
    public let value: String
    public init(_ value: String) { self.value = value }
}

extension SteamNetworkingErrMsg: SteamTypeAlias {}

/// Steamworks `SteamNetworkingPOPID`
public struct SteamNetworkingPOPID: Hashable {
    public let value: UInt32
    public init(_ value: UInt32) { self.value = value }
}

extension SteamNetworkingPOPID: SteamTypeAlias {}

/// Steamworks `SteamNetworkingMicroseconds`
public struct SteamNetworkingMicroseconds: Hashable {
    public let value: Int64
    public init(_ value: Int64) { self.value = value }
}

extension SteamNetworkingMicroseconds: SteamTypeAlias {}

/// Steamworks `FSteamNetworkingSocketsDebugOutput`
public typealias FSteamNetworkingSocketsDebugOutput = (SteamNetworkingSocketsDebugOutputType, String) -> Void