//
//  Interfaces.swift
//  Steamworks
//
//  Licensed under MIT (https://github.com/johnfairh/swift-steamworks/blob/main/LICENSE
//


/// Code gen the API interfaces
///
/// The point of this is to generate reasonable Swift versions of all the methods.
///
/// Higher-level things can be hand-crafted in non-generated code, typically in awkward cases
/// of multiple returned values and buffer allocation.
struct Interfaces {
    let io: IO
    let json: JSON

    init(io: IO, json: JSON) {
        self.io = io
        self.json = json
    }

    func generate() throws {
        try json.api.interfaces.forEach { interface in
            guard interface.classname == "ISteamFriends" else {
                return
            }
            let swiftName = interface.classname.asSwiftTypeName
            try io.write(fileName: "\(swiftName)+Methods.swift",
                         contents: interface.generate(context: swiftName))
        }
    }
}

extension SteamAPI.Interface {
    func generate(context: String) -> String {
        let swiftName = classname.asSwiftTypeName

        let declaration = """
                          // MARK: Interface methods
                          public extension \(swiftName) {

                          """
        let methods = methods.map {
            $0.generate(context: classname)
        }
        return declaration + methods.joined(separator: "\n\n") + "\n}"
    }
}

// TODO - out_array_call

final class SwiftParam {
    let json: SteamAPI.Interface.Method.Param

    var swiftName: String {
        json.paramname.asSwiftParameterName
    }

    var steamTypeName: String {
        json.type
    }

    private let swiftTypeBaseName: String

    private enum Style {
        case `in` // pass by value, flat, cast at time of use
        case out  // pass inout, use a temporary to cast, copy-back
        case in_array // pass by value but a Swift array, use a temporary to cast, no copy-back
        case in_array_count(SwiftParam) // a C param for the length of an `in_array` param that is absent in Swift
        case out_array(String) // pass inout, temporary to cast, copy-back, array.  Required size given by another param.
    }
    private let style: Style

    /// How should the param appear (or not) in the Swift version of the function
    var swiftParamType: String? {
        switch style {
        case .in: return swiftTypeBaseName
        case .out: return "inout \(swiftTypeBaseName)"
        case .in_array: return "[\(swiftTypeBaseName)]"
        case .in_array_count: return nil
        case .out_array: return "inout [\(swiftTypeBaseName)]"
        }
    }

    /// The name of the local variable to store the Steam version of the type for an out param
    private var tempName: String {
        "tmp_\(swiftName)"
    }

    /// What code (if any) is required before calling the Steamworks API
    /// SW isn't a particularly good `const` citizen
    var preCallLines: [String] {
        switch style {
        case .in, .in_array_count: return []
        case .in_array: return ["var \(tempName) = \(swiftName).map { \(steamTypeName.depointered.asExplicitSwiftTypeForPassingIntoSteamworks)($0) }"]
        case .out: return ["var \(tempName) = \(steamTypeName.depointered.asExplicitSwiftInstanceForPassingIntoSteamworks)"]
        case .out_array(let sizeParam):
            let typeName = steamTypeName.depointered.asExplicitSwiftTypeForPassingIntoSteamworks
            return [
                "let \(tempName) = UnsafeMutableBufferPointer<\(typeName)>.allocate(capacity: \(sizeParam.asSwiftParameterName))",
                "defer { \(tempName).deallocate() }"
            ]
        }
    }

    /// How to refer to the param in the Steamworks API call
    var callName: String {
        switch style {
        case .in:
            return swiftName.asCast(to: steamTypeName.asSwiftTypeForPassingIntoSteamworks)
        case .out, .in_array:
            return "&\(tempName)"
        case .in_array_count(let ap):
            return "\(ap.swiftName).count".asCast(to: steamTypeName.asSwiftTypeForPassingIntoSteamworks)
        case .out_array:
            return "\(tempName).baseAddress"
        }
    }

    /// What code (if any) is required after calling the Steamworks API
    var postSuccessCallLine: String? {
        switch style {
        case .out: return "\(swiftName) = \(swiftTypeBaseName)(\(tempName))"
        case .in, .in_array, .in_array_count: return nil
        case .out_array:
            return "\(swiftName) = \(tempName).map { \(swiftTypeBaseName)($0) }"
        }
    }

    init(_ json: SteamAPI.Interface.Method.Param, inArrayParam: SwiftParam? = nil) {
        self.json = json
        let naiveSwiftTypeName = json.type.asSwiftTypeName
        if let arrayParam = inArrayParam {
            swiftTypeBaseName = "ERROR"
            style = .in_array_count(arrayParam)
        } else if let matches = naiveSwiftTypeName.re_match("^(.*) \\*$") {
            swiftTypeBaseName = matches[1].asSwiftTypeName
            if let outLength = json.out_array_length {
                style = .out_array(outLength)
            } else if json.array_count == nil {
                style = .out
            } else {
                style = .in_array
            }
        } else {
            swiftTypeBaseName = naiveSwiftTypeName
            style = .in
        }
    }
}

extension Array where Element == SteamAPI.Interface.Method.Param {
    var asSwiftParams: [SwiftParam] {
        var params = [SwiftParam]()
        var lookingForCount = [String : SwiftParam]()

        forEach { p in
            let param = SwiftParam(p, inArrayParam: lookingForCount.removeValue(forKey: p.paramname))
            params.append(param)
            if let countParamName = p.array_count {
                lookingForCount[countParamName] = param
            }
        }

        if !lookingForCount.isEmpty {
            print("Couldn't match up 'array_count', leftovers: \(lookingForCount)")
            print("Method is \(self)")
            preconditionFailure()
        }
        return params
    }
}

extension Array where Element == SwiftParam {
    /// Formal parameter list
    var functionParams: String {
        compactMap { param in
            param.swiftParamType.flatMap { "\(param.swiftName): \($0)" }
        }.joined(separator: ", ")
    }

    /// Lines to add before the API call
    var preCallLines: [String] {
        flatMap { $0.preCallLines }
    }

    /// Steamworks call parameter list
    var callParams: String {
        map { $0.callName }.joined(separator: ", ")
    }

    /// Lines to add after the API call if it honoured out params
    var postSuccessCallLines: [String] {
        compactMap { $0.postSuccessCallLine }
    }
}

struct SwiftMethod {
    let json: SteamAPI.Interface.Method

    enum Style {
        case normal(String) // 0+ args, return value
        case void // 0+ args, no return value
        case callReturn(String) // 0+ args, async return value
    }

    let style: Style
    let params: [SwiftParam]

    init(_ json: SteamAPI.Interface.Method) {
        self.json = json
        if let callResult = json.callresult {
            style = .callReturn(callResult.asSwiftTypeName)
        } else if json.returntype != "void" {
            style = .normal(json.returntype.asSwiftTypeName)
        } else {
            style = .void
        }
        params = json.params.asSwiftParams
    }

    var declLine: String {
        switch (style, json.isVar) {
        case (.normal(let type), true):
            return "var \(json.varName): \(type) {"
        case (.normal(let type), false):
            return "func \(json.funcName)(\(params.functionParams)) -> \(type) {"
        case (.void, false):
            return "func \(json.funcName)(\(params.functionParams)) {"
        case (.callReturn(let type), false):
            let done = "completion: @escaping (\(type)) -> Void"
            return "func \(json.funcName)(\(params.functionParams), \(done)) {"
        default:
            preconditionFailure("Unexpected var-match: \(json)")
        }
    }

    /// Expression returning the Swift type of the API (or, er, not for callReturn)
    var callExpression: String {
        let paramList = params.isEmpty ? "" : ", \(params.callParams)"
        let steamCall = "\(json.methodname_flat)(interface\(paramList))"
        switch style {
        case .normal:
            return steamCall.asCast(to: json.returntype.asSwiftTypeForPassingOutOfSteamworks)
        case .void, .callReturn:
            return steamCall
        }
    }

    enum ReturnSyntax {
        case implicit
        case explicit
        case intermediate
    }

    var returnSyntax: ReturnSyntax {
        switch style {
        case .callReturn, .void: return .implicit
        case .normal:
            if params.postSuccessCallLines.isEmpty {
                if params.preCallLines.isEmpty {
                    return .implicit
                }
                return .explicit
            }
            return .intermediate
        }
    }

    var callLines: [String] {
        switch style {
        case .callReturn:
            return [
                "let rc = \(callExpression)",
                "SteamBaseAPI.CallResults.shared.add(callID: rc, rawClient: SteamBaseAPI.makeRaw(completion))"
            ]
        case .normal, .void:
            switch returnSyntax {
            case .implicit:
                return [callExpression]
            case .explicit:
                return ["return \(callExpression)"]
            case .intermediate:
                return ["let rc = \(callExpression)"]
            }
        }
    }

    /// Code to go following the API call.  This does copy-back of out params.
    ///
    /// Usually, steamworks says that even if the API call fails the out params are updated to some 'invalid' value,
    /// meaning we must do the copyback anyway.
    ///
    /// But infrequently this does not happen, so we must not try to copy-back for fear of out-of-range typechecks
    /// and uninitialized data UB.  Our patch json says what test to apply to `rc` - we may be able to generalize
    /// based on type later on but leave it manual for now.
    var postCallLines: [String] {
        let successLines = params.postSuccessCallLines
        guard !successLines.isEmpty,
            let test = json.out_param_iff_rc else {
            return successLines
        }
        return ["if rc \(test.count == 0 ? "" : "\(test) "){"] + successLines.indented(1) + ["}"]
    }

    var finalBodyLines: [String] {
        returnSyntax == .intermediate ? ["return rc"] : []
    }

    var bodyLines: [String] {
        params.preCallLines + callLines + postCallLines + finalBodyLines
    }

    var decl: [String] {
        [declLine] + bodyLines.indented(1) + ["}"]
    }
}

extension SteamAPI.Interface.Method {
    var isVar: Bool {
        params.count == 0 && methodname.starts(with: "Get")
    }

    var funcName: String {
        methodname.asSwiftIdentifier
    }

    var varName: String {
        String(methodname.dropFirst(3)).asSwiftIdentifier
    }

    func generate(context: String) -> String {
        let swiftMethod = SwiftMethod(self)
        let lines = ["/// Steamworks `\(context)::\(methodname)()`"] + swiftMethod.decl
        return lines.indented(1).joined(separator: "\n")
    }
}

extension String {
    func asCast(to: String?) -> String {
        to.flatMap { "\($0)(\(self))" } ?? self
    }
}
