//
//  TestUtils.swift
//  SteamworksTests
//
//  Licensed under MIT (https://github.com/johnfairh/swift-steamworks/blob/main/LICENSE
//

import Foundation
import XCTest
import LibGenerate

extension FileManager {
    /// Create a new empty temporary directory.  Caller must delete.
    func createTemporaryDirectory(inDirectory directory: URL? = nil, name: String? = nil) throws -> URL {
        let directoryName = name ?? UUID().uuidString
        let parentDirectoryURL = directory ?? temporaryDirectory
        let directoryURL = parentDirectoryURL.appendingPathComponent(directoryName)
        try createDirectory(at: directoryURL, withIntermediateDirectories: false)
        return directoryURL
    }

    /// Get a new temporary filename.  Caller must delete.
    func temporaryFileURL(inDirectory directory: URL? = nil) -> URL {
        let filename     = UUID().uuidString
        let directoryURL = directory ?? temporaryDirectory
        return directoryURL.appendingPathComponent(filename)
    }

    /// A file URL for the current directory
    var currentDirectory: URL {
        URL(fileURLWithPath: currentDirectoryPath)
    }
}

extension XCTestCase {
    static var fixturesURL: URL {
        URL(fileURLWithPath: #file)
            .deletingLastPathComponent()
            .appendingPathComponent("Fixtures")
    }

    static var fixturesSdkURL: URL {
        fixturesURL.appendingPathComponent("sdk")
    }

    class Harness {
        let outputDirURL: URL
        let generator: Generator

        init() throws {
            outputDirURL = try! FileManager.default.createTemporaryDirectory()
            generator = try Generator(sdkURL: fixturesSdkURL, outputDirURL: outputDirURL)
        }

        deinit {
            try? FileManager.default.removeItem(at: outputDirURL)
        }
    }
}