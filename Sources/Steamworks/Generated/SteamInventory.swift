//
//  SteamInventory.swift
//  Steamworks
//
//  Licensed under MIT (https://github.com/johnfairh/swift-steamworks/blob/main/LICENSE
//
//  This file is generated code: any edits will be overwritten.

@_implementationOnly import CSteamworks

/// Steamworks [`ISteamInventory`](https://partner.steamgames.com/doc/api/ISteamInventory)
///
/// Access via `SteamBaseAPI.inventory` through a `SteamAPI` or `SteamGameServerAPI` instance.
public struct SteamInventory {
    private let isServer: Bool
    var interface: UnsafeMutablePointer<ISteamInventory> {
        isServer ? SteamAPI_SteamGameServerInventory_v003() : SteamAPI_SteamInventory_v003()
    }

    init(isServer: Bool) {
        self.isServer = isServer
    }

    /// Steamworks `ISteamInventory::AddPromoItem()`
    public func addPromoItem(def: SteamItemDef) -> (rc: Bool, resultHandle: SteamInventoryResult) {
        var tmp_resultHandle = SteamInventoryResult_t()
        let rc = SteamAPI_ISteamInventory_AddPromoItem(interface, &tmp_resultHandle, SteamItemDef_t(def))
        return (rc: rc, resultHandle: SteamInventoryResult(tmp_resultHandle))
    }

    /// Steamworks `ISteamInventory::AddPromoItems()`
    public func addPromoItems(arrayItemDefs: [SteamItemDef]) -> (rc: Bool, resultHandle: SteamInventoryResult) {
        var tmp_resultHandle = SteamInventoryResult_t()
        var tmp_arrayItemDefs = arrayItemDefs.map { SteamItemDef_t($0) }
        let rc = SteamAPI_ISteamInventory_AddPromoItems(interface, &tmp_resultHandle, &tmp_arrayItemDefs, uint32(arrayItemDefs.count))
        return (rc: rc, resultHandle: SteamInventoryResult(tmp_resultHandle))
    }

    /// Steamworks `ISteamInventory::CheckResultSteamID()`
    public func checkResultSteamID(handle: SteamInventoryResult, expected: SteamID) -> Bool {
        SteamAPI_ISteamInventory_CheckResultSteamID(interface, SteamInventoryResult_t(handle), UInt64(expected))
    }

    /// Steamworks `ISteamInventory::ConsumeItem()`
    public func consumeItem(consume: SteamItemInstanceID, quantity: Int) -> (rc: Bool, resultHandle: SteamInventoryResult) {
        var tmp_resultHandle = SteamInventoryResult_t()
        let rc = SteamAPI_ISteamInventory_ConsumeItem(interface, &tmp_resultHandle, SteamItemInstanceID_t(consume), uint32(quantity))
        return (rc: rc, resultHandle: SteamInventoryResult(tmp_resultHandle))
    }

    /// Steamworks `ISteamInventory::DeserializeResult()`
    public func deserializeResult(buffer: UnsafeRawPointer, bufferSize: Int, reservedMUSTBEFALSE: Bool) -> (rc: Bool, outResultHandle: SteamInventoryResult) {
        var tmp_outResultHandle = SteamInventoryResult_t()
        let rc = SteamAPI_ISteamInventory_DeserializeResult(interface, &tmp_outResultHandle, buffer, uint32(bufferSize), reservedMUSTBEFALSE)
        return (rc: rc, outResultHandle: SteamInventoryResult(tmp_outResultHandle))
    }

    /// Steamworks `ISteamInventory::DestroyResult()`
    public func destroyResult(handle: SteamInventoryResult) {
        SteamAPI_ISteamInventory_DestroyResult(interface, SteamInventoryResult_t(handle))
    }

    /// Steamworks `ISteamInventory::ExchangeItems()`
    public func exchangeItems(arrayGenerate: [SteamItemDef], arrayGenerateQuantity: [Int], arrayDestroy: [SteamItemInstanceID], arrayDestroyQuantity: [Int]) -> (rc: Bool, resultHandle: SteamInventoryResult) {
        var tmp_resultHandle = SteamInventoryResult_t()
        var tmp_arrayGenerate = arrayGenerate.map { SteamItemDef_t($0) }
        var tmp_arrayGenerateQuantity = arrayGenerateQuantity.map { uint32($0) }
        var tmp_arrayDestroy = arrayDestroy.map { SteamItemInstanceID_t($0) }
        var tmp_arrayDestroyQuantity = arrayDestroyQuantity.map { uint32($0) }
        let rc = SteamAPI_ISteamInventory_ExchangeItems(interface, &tmp_resultHandle, &tmp_arrayGenerate, &tmp_arrayGenerateQuantity, uint32(arrayGenerateQuantity.count), &tmp_arrayDestroy, &tmp_arrayDestroyQuantity, uint32(arrayDestroyQuantity.count))
        return (rc: rc, resultHandle: SteamInventoryResult(tmp_resultHandle))
    }

    /// Steamworks `ISteamInventory::GenerateItems()`
    public func generateItems(arrayItemDefs: [SteamItemDef], arrayQuantity: [Int]) -> (rc: Bool, resultHandle: SteamInventoryResult) {
        var tmp_resultHandle = SteamInventoryResult_t()
        var tmp_arrayItemDefs = arrayItemDefs.map { SteamItemDef_t($0) }
        var tmp_arrayQuantity = arrayQuantity.map { uint32($0) }
        let rc = SteamAPI_ISteamInventory_GenerateItems(interface, &tmp_resultHandle, &tmp_arrayItemDefs, &tmp_arrayQuantity, uint32(arrayQuantity.count))
        return (rc: rc, resultHandle: SteamInventoryResult(tmp_resultHandle))
    }

    /// Steamworks `ISteamInventory::GetAllItems()`
    public func getAllItems() -> (rc: Bool, resultHandle: SteamInventoryResult) {
        var tmp_resultHandle = SteamInventoryResult_t()
        let rc = SteamAPI_ISteamInventory_GetAllItems(interface, &tmp_resultHandle)
        return (rc: rc, resultHandle: SteamInventoryResult(tmp_resultHandle))
    }

    /// Steamworks `ISteamInventory::GetEligiblePromoItemDefinitionIDs()`
    public func getEligiblePromoItemDefinitionIDs(steamID: SteamID, itemDefIDs: inout [SteamItemDef], itemDefIDsArraySize: inout Int) -> Bool {
        let tmp_itemDefIDs = UnsafeMutableBufferPointer<SteamItemDef_t>.allocate(capacity: itemDefIDsArraySize)
        defer { tmp_itemDefIDs.deallocate() }
        var tmp_itemDefIDsArraySize = uint32(itemDefIDsArraySize)
        let rc = SteamAPI_ISteamInventory_GetEligiblePromoItemDefinitionIDs(interface, UInt64(steamID), tmp_itemDefIDs.baseAddress, &tmp_itemDefIDsArraySize)
        itemDefIDs = tmp_itemDefIDs.map { SteamItemDef($0) }
        itemDefIDsArraySize = Int(tmp_itemDefIDsArraySize)
        return rc
    }

    /// Steamworks `ISteamInventory::GetItemDefinitionIDs()`
    public func getItemDefinitionIDs(itemDefIDs: inout [SteamItemDef]?, itemDefIDsArraySize: inout Int) -> Bool {
        let tmp_itemDefIDs = itemDefIDs.map { _ in UnsafeMutableBufferPointer<SteamItemDef_t>.allocate(capacity: itemDefIDsArraySize) }
        defer { tmp_itemDefIDs?.deallocate() }
        var tmp_itemDefIDsArraySize = uint32(itemDefIDsArraySize)
        let rc = SteamAPI_ISteamInventory_GetItemDefinitionIDs(interface, tmp_itemDefIDs.flatMap { $0.baseAddress }, &tmp_itemDefIDsArraySize)
        tmp_itemDefIDs.map { itemDefIDs = $0.map { SteamItemDef($0) } }
        itemDefIDsArraySize = Int(tmp_itemDefIDsArraySize)
        return rc
    }

    /// Steamworks `ISteamInventory::GetItemDefinitionProperty()`
    public func getItemDefinitionProperty(definitionIndex: SteamItemDef, propertyName: String?, valueBuffer: inout String?, valueBufferSizeOut: inout Int) -> Bool {
        let tmp_valueBuffer = valueBuffer.map { _ in UnsafeMutableBufferPointer<CChar>.allocate(capacity: valueBufferSizeOut) }
        defer { tmp_valueBuffer?.deallocate() }
        var tmp_valueBufferSizeOut = uint32(valueBufferSizeOut)
        let rc = SteamAPI_ISteamInventory_GetItemDefinitionProperty(interface, SteamItemDef_t(definitionIndex), propertyName, tmp_valueBuffer.flatMap { $0.baseAddress }, &tmp_valueBufferSizeOut)
        tmp_valueBuffer.map { valueBuffer = String($0) }
        valueBufferSizeOut = Int(tmp_valueBufferSizeOut)
        return rc
    }

    /// Steamworks `ISteamInventory::GetItemPrice()`
    public func getItemPrice(definitionIndex: SteamItemDef) -> (rc: Bool, currentPrice: UInt64, basePrice: UInt64) {
        var tmp_currentPrice = uint64()
        var tmp_basePrice = uint64()
        let rc = SteamAPI_ISteamInventory_GetItemPrice(interface, SteamItemDef_t(definitionIndex), &tmp_currentPrice, &tmp_basePrice)
        return (rc: rc, currentPrice: tmp_currentPrice, basePrice: tmp_basePrice)
    }

    /// Steamworks `ISteamInventory::GetItemsByID()`
    public func getItemsByID(instanceIDs: [SteamItemInstanceID]) -> (rc: Bool, resultHandle: SteamInventoryResult) {
        var tmp_resultHandle = SteamInventoryResult_t()
        var tmp_instanceIDs = instanceIDs.map { SteamItemInstanceID_t($0) }
        let rc = SteamAPI_ISteamInventory_GetItemsByID(interface, &tmp_resultHandle, &tmp_instanceIDs, uint32(instanceIDs.count))
        return (rc: rc, resultHandle: SteamInventoryResult(tmp_resultHandle))
    }

    /// Steamworks `ISteamInventory::GetItemsWithPrices()`
    public func getItemsWithPrices(arrayItemDefs: inout [SteamItemDef], currentPrices: inout [UInt64], basePrices: inout [UInt64], arrayLength: Int) -> Bool {
        let tmp_arrayItemDefs = UnsafeMutableBufferPointer<SteamItemDef_t>.allocate(capacity: arrayLength)
        defer { tmp_arrayItemDefs.deallocate() }
        let rc = SteamAPI_ISteamInventory_GetItemsWithPrices(interface, tmp_arrayItemDefs.baseAddress, &currentPrices, &basePrices, uint32(arrayLength))
        if rc {
            arrayItemDefs = tmp_arrayItemDefs.map { SteamItemDef($0) }
        }
        if rc {
            return rc
        } else {
            return rc
        }
    }

    /// Steamworks `ISteamInventory::GetNumItemsWithPrices()`
    public func getNumItemsWithPrices() -> Int {
        Int(SteamAPI_ISteamInventory_GetNumItemsWithPrices(interface))
    }

    /// Steamworks `ISteamInventory::GetResultItemProperty()`
    public func getResultItemProperty(handle: SteamInventoryResult, itemIndex: Int, propertyName: String?, valueBuffer: inout String, valueBufferSizeOut: inout Int) -> Bool {
        let tmp_valueBuffer = UnsafeMutableBufferPointer<CChar>.allocate(capacity: valueBufferSizeOut)
        defer { tmp_valueBuffer.deallocate() }
        var tmp_valueBufferSizeOut = uint32(valueBufferSizeOut)
        let rc = SteamAPI_ISteamInventory_GetResultItemProperty(interface, SteamInventoryResult_t(handle), uint32(itemIndex), propertyName, tmp_valueBuffer.baseAddress, &tmp_valueBufferSizeOut)
        valueBuffer = String(tmp_valueBuffer)
        valueBufferSizeOut = Int(tmp_valueBufferSizeOut)
        return rc
    }

    /// Steamworks `ISteamInventory::GetResultItems()`
    public func getResultItems(handle: SteamInventoryResult, outItemsArray: inout [SteamItemDetails]?, outItemsArraySize: inout Int) -> Bool {
        let tmp_outItemsArray = outItemsArray.map { _ in UnsafeMutableBufferPointer<SteamItemDetails_t>.allocate(capacity: outItemsArraySize) }
        defer { tmp_outItemsArray?.deallocate() }
        var tmp_outItemsArraySize = uint32(outItemsArraySize)
        let rc = SteamAPI_ISteamInventory_GetResultItems(interface, SteamInventoryResult_t(handle), tmp_outItemsArray.flatMap { $0.baseAddress }, &tmp_outItemsArraySize)
        tmp_outItemsArray.map { outItemsArray = $0.map { SteamItemDetails($0) } }
        outItemsArraySize = Int(tmp_outItemsArraySize)
        return rc
    }

    /// Steamworks `ISteamInventory::GetResultStatus()`
    public func getResultStatus(handle: SteamInventoryResult) -> Result {
        Result(SteamAPI_ISteamInventory_GetResultStatus(interface, SteamInventoryResult_t(handle)))
    }

    /// Steamworks `ISteamInventory::GetResultTimestamp()`
    public func getResultTimestamp(handle: SteamInventoryResult) -> RTime32 {
        RTime32(SteamAPI_ISteamInventory_GetResultTimestamp(interface, SteamInventoryResult_t(handle)))
    }

    /// Steamworks `ISteamInventory::GrantPromoItems()`
    public func grantPromoItems() -> (rc: Bool, resultHandle: SteamInventoryResult) {
        var tmp_resultHandle = SteamInventoryResult_t()
        let rc = SteamAPI_ISteamInventory_GrantPromoItems(interface, &tmp_resultHandle)
        return (rc: rc, resultHandle: SteamInventoryResult(tmp_resultHandle))
    }

    /// Steamworks `ISteamInventory::InspectItem()`
    public func inspectItem(itemToken: String) -> (rc: Bool, resultHandle: SteamInventoryResult) {
        var tmp_resultHandle = SteamInventoryResult_t()
        let rc = SteamAPI_ISteamInventory_InspectItem(interface, &tmp_resultHandle, itemToken)
        return (rc: rc, resultHandle: SteamInventoryResult(tmp_resultHandle))
    }

    /// Steamworks `ISteamInventory::LoadItemDefinitions()`
    @discardableResult
    public func loadItemDefinitions() -> Bool {
        SteamAPI_ISteamInventory_LoadItemDefinitions(interface)
    }

    /// Steamworks `ISteamInventory::RemoveProperty()`
    public func removeProperty(handle: SteamInventoryUpdateHandle, itemID: SteamItemInstanceID, propertyName: String) -> Bool {
        SteamAPI_ISteamInventory_RemoveProperty(interface, SteamInventoryUpdateHandle_t(handle), SteamItemInstanceID_t(itemID), propertyName)
    }

    /// Steamworks `ISteamInventory::RequestEligiblePromoItemDefinitionsIDs()`, callback
    public func requestEligiblePromoItemDefinitionsIDs(steamID: SteamID, completion: @escaping (SteamInventoryEligiblePromoItemDefIDs?) -> Void) {
        let rc = SteamAPI_ISteamInventory_RequestEligiblePromoItemDefinitionsIDs(interface, UInt64(steamID))
        SteamBaseAPI.CallResults.shared.add(callID: rc, rawClient: SteamBaseAPI.makeRaw(completion))
    }

    /// Steamworks `ISteamInventory::RequestEligiblePromoItemDefinitionsIDs()`, async
    public func requestEligiblePromoItemDefinitionsIDs(steamID: SteamID) async -> SteamInventoryEligiblePromoItemDefIDs? {
        await withUnsafeContinuation {
            requestEligiblePromoItemDefinitionsIDs(steamID: steamID, completion: $0.resume)
        }
    }

    /// Steamworks `ISteamInventory::RequestPrices()`, callback
    public func requestPrices(completion: @escaping (SteamInventoryRequestPricesResult?) -> Void) {
        let rc = SteamAPI_ISteamInventory_RequestPrices(interface)
        SteamBaseAPI.CallResults.shared.add(callID: rc, rawClient: SteamBaseAPI.makeRaw(completion))
    }

    /// Steamworks `ISteamInventory::RequestPrices()`, async
    public func requestPrices() async -> SteamInventoryRequestPricesResult? {
        await withUnsafeContinuation {
            requestPrices(completion: $0.resume)
        }
    }

    /// Steamworks `ISteamInventory::SendItemDropHeartbeat()`
    public func sendItemDropHeartbeat() {
        SteamAPI_ISteamInventory_SendItemDropHeartbeat(interface)
    }

    /// Steamworks `ISteamInventory::SerializeResult()`
    public func serializeResult(handle: SteamInventoryResult, outBuffer: UnsafeMutableRawPointer?, outBufferSize: inout Int) -> Bool {
        var tmp_outBufferSize = uint32(outBufferSize)
        let rc = SteamAPI_ISteamInventory_SerializeResult(interface, SteamInventoryResult_t(handle), outBuffer, &tmp_outBufferSize)
        outBufferSize = Int(tmp_outBufferSize)
        return rc
    }

    /// Steamworks `ISteamInventory::SetProperty()`
    public func setProperty(handle: SteamInventoryUpdateHandle, itemID: SteamItemInstanceID, propertyName: String, value: Bool) -> Bool {
        SteamAPI_ISteamInventory_SetPropertyBool(interface, SteamInventoryUpdateHandle_t(handle), SteamItemInstanceID_t(itemID), propertyName, value)
    }

    /// Steamworks `ISteamInventory::SetProperty()`
    public func setProperty(handle: SteamInventoryUpdateHandle, itemID: SteamItemInstanceID, propertyName: String, value: Float) -> Bool {
        SteamAPI_ISteamInventory_SetPropertyFloat(interface, SteamInventoryUpdateHandle_t(handle), SteamItemInstanceID_t(itemID), propertyName, value)
    }

    /// Steamworks `ISteamInventory::SetProperty()`
    public func setProperty(handle: SteamInventoryUpdateHandle, itemID: SteamItemInstanceID, propertyName: String, value: Int) -> Bool {
        SteamAPI_ISteamInventory_SetPropertyInt64(interface, SteamInventoryUpdateHandle_t(handle), SteamItemInstanceID_t(itemID), propertyName, int64(value))
    }

    /// Steamworks `ISteamInventory::SetProperty()`
    public func setProperty(handle: SteamInventoryUpdateHandle, itemID: SteamItemInstanceID, propertyName: String, propertyValue: String) -> Bool {
        SteamAPI_ISteamInventory_SetPropertyString(interface, SteamInventoryUpdateHandle_t(handle), SteamItemInstanceID_t(itemID), propertyName, propertyValue)
    }

    /// Steamworks `ISteamInventory::StartPurchase()`, callback
    public func startPurchase(arrayItemDefs: [SteamItemDef], arrayQuantity: [Int], completion: @escaping (SteamInventoryStartPurchaseResult?) -> Void) {
        var tmp_arrayItemDefs = arrayItemDefs.map { SteamItemDef_t($0) }
        var tmp_arrayQuantity = arrayQuantity.map { uint32($0) }
        let rc = SteamAPI_ISteamInventory_StartPurchase(interface, &tmp_arrayItemDefs, &tmp_arrayQuantity, uint32(arrayQuantity.count))
        SteamBaseAPI.CallResults.shared.add(callID: rc, rawClient: SteamBaseAPI.makeRaw(completion))
    }

    /// Steamworks `ISteamInventory::StartPurchase()`, async
    public func startPurchase(arrayItemDefs: [SteamItemDef], arrayQuantity: [Int]) async -> SteamInventoryStartPurchaseResult? {
        await withUnsafeContinuation {
            startPurchase(arrayItemDefs: arrayItemDefs, arrayQuantity: arrayQuantity, completion: $0.resume)
        }
    }

    /// Steamworks `ISteamInventory::StartUpdateProperties()`
    public func startUpdateProperties() -> SteamInventoryUpdateHandle {
        SteamInventoryUpdateHandle(SteamAPI_ISteamInventory_StartUpdateProperties(interface))
    }

    /// Steamworks `ISteamInventory::SubmitUpdateProperties()`
    public func submitUpdateProperties(handle: SteamInventoryUpdateHandle) -> (rc: Bool, resultHandle: SteamInventoryResult) {
        var tmp_resultHandle = SteamInventoryResult_t()
        let rc = SteamAPI_ISteamInventory_SubmitUpdateProperties(interface, SteamInventoryUpdateHandle_t(handle), &tmp_resultHandle)
        return (rc: rc, resultHandle: SteamInventoryResult(tmp_resultHandle))
    }

    /// Steamworks `ISteamInventory::TransferItemQuantity()`
    public func transferItemQuantity(idSource: SteamItemInstanceID, quantity: Int, idDest: SteamItemInstanceID) -> (rc: Bool, resultHandle: SteamInventoryResult) {
        var tmp_resultHandle = SteamInventoryResult_t()
        let rc = SteamAPI_ISteamInventory_TransferItemQuantity(interface, &tmp_resultHandle, SteamItemInstanceID_t(idSource), uint32(quantity), SteamItemInstanceID_t(idDest))
        return (rc: rc, resultHandle: SteamInventoryResult(tmp_resultHandle))
    }

    /// Steamworks `ISteamInventory::TriggerItemDrop()`
    public func triggerItemDrop(listDefinition: SteamItemDef) -> (rc: Bool, resultHandle: SteamInventoryResult) {
        var tmp_resultHandle = SteamInventoryResult_t()
        let rc = SteamAPI_ISteamInventory_TriggerItemDrop(interface, &tmp_resultHandle, SteamItemDef_t(listDefinition))
        return (rc: rc, resultHandle: SteamInventoryResult(tmp_resultHandle))
    }
}
