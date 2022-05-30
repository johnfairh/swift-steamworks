//
//  SteamUser.swift
//  Steamworks
//
//  Licensed under MIT (https://github.com/johnfairh/swift-steamworks/blob/main/LICENSE
//
//  This file is generated code: any edits will be overwritten.

@_implementationOnly import CSteamworks

/// Steamworks [`ISteamUser`](https://partner.steamgames.com/doc/api/ISteamUser)
///
/// Access via `SteamAPI.user`.
public struct SteamUser {
    var interface: UnsafeMutablePointer<ISteamUser> {
        SteamAPI_SteamUser_v021()
    }

    init() {
    }

    /// Steamworks `ISteamUser::AdvertiseGame()`
    public func advertiseGame(gameServer: SteamID, ipServer: Int, portServer: Int) {
        SteamAPI_ISteamUser_AdvertiseGame(interface, UInt64(gameServer), uint32(ipServer), uint16(portServer))
    }

    /// Steamworks `ISteamUser::BIsBehindNAT()`
    public func isBehindNAT() -> Bool {
        SteamAPI_ISteamUser_BIsBehindNAT(interface)
    }

    /// Steamworks `ISteamUser::BIsPhoneIdentifying()`
    public func isPhoneIdentifying() -> Bool {
        SteamAPI_ISteamUser_BIsPhoneIdentifying(interface)
    }

    /// Steamworks `ISteamUser::BIsPhoneRequiringVerification()`
    public func isPhoneRequiringVerification() -> Bool {
        SteamAPI_ISteamUser_BIsPhoneRequiringVerification(interface)
    }

    /// Steamworks `ISteamUser::BIsPhoneVerified()`
    public func isPhoneVerified() -> Bool {
        SteamAPI_ISteamUser_BIsPhoneVerified(interface)
    }

    /// Steamworks `ISteamUser::BIsTwoFactorEnabled()`
    public func isTwoFactorEnabled() -> Bool {
        SteamAPI_ISteamUser_BIsTwoFactorEnabled(interface)
    }

    /// Steamworks `ISteamUser::BLoggedOn()`
    public func loggedOn() -> Bool {
        SteamAPI_ISteamUser_BLoggedOn(interface)
    }

    /// Steamworks `ISteamUser::BSetDurationControlOnlineState()`
    public func setDurationControlOnlineState(newState: DurationControlOnlineState) -> Bool {
        SteamAPI_ISteamUser_BSetDurationControlOnlineState(interface, EDurationControlOnlineState(newState))
    }

    /// Steamworks `ISteamUser::BeginAuthSession()`
    public func beginAuthSession(authTicket: UnsafeRawPointer, authTicketSize: Int, steamID: SteamID) -> BeginAuthSessionResult {
        BeginAuthSessionResult(SteamAPI_ISteamUser_BeginAuthSession(interface, authTicket, Int32(authTicketSize), UInt64(steamID)))
    }

    /// Steamworks `ISteamUser::CancelAuthTicket()`
    public func cancelAuthTicket(authTicket: HAuthTicket) {
        SteamAPI_ISteamUser_CancelAuthTicket(interface, CSteamworks.HAuthTicket(authTicket))
    }

    /// Steamworks `ISteamUser::DecompressVoice()`
    public func decompressVoice(compressed: UnsafeRawPointer, compressedSize: Int, destBuffer: UnsafeMutableRawPointer, destBufferSize: Int, desiredSampleRate: Int) -> (rc: VoiceResult, bytesWritten: Int) {
        var tmp_bytesWritten = uint32()
        let rc = VoiceResult(SteamAPI_ISteamUser_DecompressVoice(interface, compressed, uint32(compressedSize), destBuffer, uint32(destBufferSize), &tmp_bytesWritten, uint32(desiredSampleRate)))
        return (rc: rc, bytesWritten: Int(tmp_bytesWritten))
    }

    /// Steamworks `ISteamUser::EndAuthSession()`
    public func endAuthSession(steamID: SteamID) {
        SteamAPI_ISteamUser_EndAuthSession(interface, UInt64(steamID))
    }

    /// Steamworks `ISteamUser::GetAuthSessionTicket()`
    public func getAuthSessionTicket(ticket: UnsafeMutableRawPointer, maxTicketSize: Int) -> (rc: HAuthTicket, ticketSize: Int) {
        var tmp_ticketSize = uint32()
        let rc = HAuthTicket(SteamAPI_ISteamUser_GetAuthSessionTicket(interface, ticket, Int32(maxTicketSize), &tmp_ticketSize))
        return (rc: rc, ticketSize: Int(tmp_ticketSize))
    }

    /// Steamworks `ISteamUser::GetAvailableVoice()`
    public func getAvailableVoice(uncompressedVoiceDesiredSampleRateDeprecated: Int) -> (rc: VoiceResult, compressedSize: Int, uncompressedDeprecatedSize: Int) {
        var tmp_compressedSize = uint32()
        var tmp_uncompressedDeprecatedSize = uint32()
        let rc = VoiceResult(SteamAPI_ISteamUser_GetAvailableVoice(interface, &tmp_compressedSize, &tmp_uncompressedDeprecatedSize, uint32(uncompressedVoiceDesiredSampleRateDeprecated)))
        return (rc: rc, compressedSize: Int(tmp_compressedSize), uncompressedDeprecatedSize: Int(tmp_uncompressedDeprecatedSize))
    }

    /// Steamworks `ISteamUser::GetDurationControl()`, callback
    public func getDurationControl(completion: @escaping (DurationControl?) -> Void) {
        let rc = SteamAPI_ISteamUser_GetDurationControl(interface)
        SteamBaseAPI.CallResults.shared.add(callID: rc, rawClient: SteamBaseAPI.makeRaw(completion))
    }

    /// Steamworks `ISteamUser::GetDurationControl()`, async
    public func getDurationControl() async -> DurationControl? {
        await withUnsafeContinuation {
            getDurationControl(completion: $0.resume)
        }
    }

    /// Steamworks `ISteamUser::GetEncryptedAppTicket()`
    public func getEncryptedAppTicket(ticket: UnsafeMutableRawPointer, maxTicketSize: Int) -> (rc: Bool, ticketSize: Int) {
        var tmp_ticketSize = uint32()
        let rc = SteamAPI_ISteamUser_GetEncryptedAppTicket(interface, ticket, Int32(maxTicketSize), &tmp_ticketSize)
        return (rc: rc, ticketSize: Int(tmp_ticketSize))
    }

    /// Steamworks `ISteamUser::GetGameBadgeLevel()`
    public func getGameBadgeLevel(series: Int, foil: Bool) -> Int {
        Int(SteamAPI_ISteamUser_GetGameBadgeLevel(interface, Int32(series), foil))
    }

    /// Steamworks `ISteamUser::GetHSteamUser()`
    public func getHSteamUser() -> HSteamUser {
        HSteamUser(SteamAPI_ISteamUser_GetHSteamUser(interface))
    }

    /// Steamworks `ISteamUser::GetMarketEligibility()`, callback
    public func getMarketEligibility(completion: @escaping (MarketEligibilityResponse?) -> Void) {
        let rc = SteamAPI_ISteamUser_GetMarketEligibility(interface)
        SteamBaseAPI.CallResults.shared.add(callID: rc, rawClient: SteamBaseAPI.makeRaw(completion))
    }

    /// Steamworks `ISteamUser::GetMarketEligibility()`, async
    public func getMarketEligibility() async -> MarketEligibilityResponse? {
        await withUnsafeContinuation {
            getMarketEligibility(completion: $0.resume)
        }
    }

    /// Steamworks `ISteamUser::GetPlayerSteamLevel()`
    public func getPlayerSteamLevel() -> Int {
        Int(SteamAPI_ISteamUser_GetPlayerSteamLevel(interface))
    }

    /// Steamworks `ISteamUser::GetSteamID()`
    public func getSteamID() -> SteamID {
        SteamID(SteamAPI_ISteamUser_GetSteamID(interface))
    }

    /// Steamworks `ISteamUser::GetUserDataFolder()`
    public func getUserDataFolder(bufferSize: Int) -> (rc: Bool, buffer: String) {
        let tmp_buffer = SteamString(length: bufferSize)
        let rc = SteamAPI_ISteamUser_GetUserDataFolder(interface, tmp_buffer.charBuffer, Int32(bufferSize))
        if rc {
            return (rc: rc, buffer: tmp_buffer.swiftString)
        } else {
            return (rc: rc, buffer: "")
        }
    }

    /// Steamworks `ISteamUser::GetVoice()`
    public func getVoice(wantCompressed: Bool, destBuffer: UnsafeMutableRawPointer, destBufferSize: Int, wantUncompressedDeprecated: Bool, uncompressedDestBufferDeprecated: UnsafeMutableRawPointer, uncompressedDestBufferSizeDeprecatedSize: Int, uncompressedVoiceDesiredSampleRateDeprecated: Int) -> (rc: VoiceResult, bytesWritten: Int, uncompressBytesWrittenDeprecated: Int) {
        var tmp_bytesWritten = uint32()
        var tmp_uncompressBytesWrittenDeprecated = uint32()
        let rc = VoiceResult(SteamAPI_ISteamUser_GetVoice(interface, wantCompressed, destBuffer, uint32(destBufferSize), &tmp_bytesWritten, wantUncompressedDeprecated, uncompressedDestBufferDeprecated, uint32(uncompressedDestBufferSizeDeprecatedSize), &tmp_uncompressBytesWrittenDeprecated, uint32(uncompressedVoiceDesiredSampleRateDeprecated)))
        return (rc: rc, bytesWritten: Int(tmp_bytesWritten), uncompressBytesWrittenDeprecated: Int(tmp_uncompressBytesWrittenDeprecated))
    }

    /// Steamworks `ISteamUser::GetVoiceOptimalSampleRate()`
    public func getVoiceOptimalSampleRate() -> Int {
        Int(SteamAPI_ISteamUser_GetVoiceOptimalSampleRate(interface))
    }

    /// Steamworks `ISteamUser::InitiateGameConnection_DEPRECATED()`
    public func initiateGameConnectionDEPRECATED(authBlob: UnsafeMutableRawPointer, maxAuthBlobSize: Int, gameServer: SteamID, ipServer: Int, portServer: Int, secure: Bool) -> Int {
        Int(SteamAPI_ISteamUser_InitiateGameConnection_DEPRECATED(interface, authBlob, Int32(maxAuthBlobSize), UInt64(gameServer), uint32(ipServer), uint16(portServer), secure))
    }

    /// Steamworks `ISteamUser::RequestEncryptedAppTicket()`, callback
    public func requestEncryptedAppTicket(dataToInclude: UnsafeMutableRawPointer, dataToIncludeSize: Int, completion: @escaping (EncryptedAppTicketResponse?) -> Void) {
        let rc = SteamAPI_ISteamUser_RequestEncryptedAppTicket(interface, dataToInclude, Int32(dataToIncludeSize))
        SteamBaseAPI.CallResults.shared.add(callID: rc, rawClient: SteamBaseAPI.makeRaw(completion))
    }

    /// Steamworks `ISteamUser::RequestEncryptedAppTicket()`, async
    public func requestEncryptedAppTicket(dataToInclude: UnsafeMutableRawPointer, dataToIncludeSize: Int) async -> EncryptedAppTicketResponse? {
        await withUnsafeContinuation {
            requestEncryptedAppTicket(dataToInclude: dataToInclude, dataToIncludeSize: dataToIncludeSize, completion: $0.resume)
        }
    }

    /// Steamworks `ISteamUser::RequestStoreAuthURL()`, callback
    public func requestStoreAuthURL(redirectURL: String, completion: @escaping (StoreAuthURLResponse?) -> Void) {
        let rc = SteamAPI_ISteamUser_RequestStoreAuthURL(interface, redirectURL)
        SteamBaseAPI.CallResults.shared.add(callID: rc, rawClient: SteamBaseAPI.makeRaw(completion))
    }

    /// Steamworks `ISteamUser::RequestStoreAuthURL()`, async
    public func requestStoreAuthURL(redirectURL: String) async -> StoreAuthURLResponse? {
        await withUnsafeContinuation {
            requestStoreAuthURL(redirectURL: redirectURL, completion: $0.resume)
        }
    }

    /// Steamworks `ISteamUser::StartVoiceRecording()`
    public func startVoiceRecording() {
        SteamAPI_ISteamUser_StartVoiceRecording(interface)
    }

    /// Steamworks `ISteamUser::StopVoiceRecording()`
    public func stopVoiceRecording() {
        SteamAPI_ISteamUser_StopVoiceRecording(interface)
    }

    /// Steamworks `ISteamUser::TerminateGameConnection_DEPRECATED()`
    public func terminateGameConnectionDEPRECATED(ipServer: Int, portServer: Int) {
        SteamAPI_ISteamUser_TerminateGameConnection_DEPRECATED(interface, uint32(ipServer), uint16(portServer))
    }

    /// Steamworks `ISteamUser::TrackAppUsageEvent()`
    public func trackAppUsageEvent(id: GameID, appUsageEvent: Int, extraInfo: String) {
        SteamAPI_ISteamUser_TrackAppUsageEvent(interface, UInt64(id), Int32(appUsageEvent), extraInfo)
    }

    /// Steamworks `ISteamUser::UserHasLicenseForApp()`
    public func userHasLicenseForApp(steamID: SteamID, id: AppID) -> UserHasLicenseForAppResult {
        UserHasLicenseForAppResult(SteamAPI_ISteamUser_UserHasLicenseForApp(interface, UInt64(steamID), AppId_t(id)))
    }
}
