![macOS](https://shields.io/badge/platform-macOS%20|%20%3F%3F-lightgrey)
![Steamworks 1.53a](https://shields.io/badge/steamworks-1.53a-lightgrey)
![MIT](https://shields.io/badge/license-MIT-black)

# steamworks-swift

Experiment with Steamworks SDK and Swift C++ importer.

Current state:
* Code gen creates Swift versions of Steam types; callbacks and call-returns work
* First pass all interfaces complete - see [early docs](https://johnfairh.github.io/swift-steamworks/index.html)
* Missing some utility type properties for clients
* Interface types and patterns need reviewing and refactoring
* `make` builds and runs a demo Swift program that accesses the C++
  Steam API to initialize, do various sync and async queries, then shut it down.
* Separate demo showing encrypted app-ticket stuff.
* The Xcode project basically works, assumes `sdk` exists.  SourceKit can manage
  tab completion even if module interface gen is beyond it.

### Concept

* Offer a pure Swift module covering all of the current Steamworks API.
* Leave out the deprecated and WIN32-only stuff.
* Do not diverge too far from the 'real' API names to aid docs / searching / porting:
  I think this is a better starting point than doing a complete OO analysis to carve
  out function.  Can go to build `SteamworksPatterns` or something if worthwhile.  Name
  etc. changes planned though at least:
   * _Don't_ use Swift properties for 0-arg getters: diverges too far from Steamworks
     naming
   * Drop the intermittent Hungarian notation (argh the 1990s are calling)
   * Use Swift closures for callbacks as well as async-await sugar
   * Map unions onto enums with associated values
* Provide custom API-lifetime and message dispatch classes.
* Provide strongly typed handles.
* Access interfaces via central types.
* Use code gen to deal with the ~900 APIs and their ~400 types, taking advantage of the
  handy JSON file.  This code-gen piece is the actual main work in this project.

### Swift C++ Bugs

Tech limitations, on 5.6:
* Have to manually tell Swift to link with `libc++`.  Verify by commenting from
  Makefile.  When resolved tidy Makefile.
* Importing `Dispatch` and `-enable-cxx-interop` makes `DispatchSemaphore` disappear
  but not the rest of the module?? Work around.  When resolved rewrite mutex.
* Some structures/classes aren't imported -- the common factor seems to be a `protected`
  destructor.  Verify by trying to use `SteamNetworkingMessage_t`.
* Something goes wrong storing pointers to base classes and they get nobbled by
  something.  Verify by making `SteamIPAddress` a struct, changing interfaces to cache
  the interface pointers.
* C++ types with `operator ==` don't have `Equatable` generated.  Verify with
  `SteamNetworkingIPAddr`.
* Importing `Foundation` and `-enable-cxx-interop` and a C++ module goes wrong.  Swift
  5.6 doesn't crash; worse the compiler goes slow, spits out warnings, then the binary
  runs like treacle.  Will aim to not depend on Foundation, see how that goes.

To review, spring 2022:
* Calls to (?pure) virtual functions aren't generated properly: Swift generates a ref
  to a symbol instead of doing the vtable call.  So the actual C++ interfaces are not
  usable in practice.  Will use the flat API.
* Anonymous enums are not imported at all.  Affects callback etc. ID constants.
  Will work around.
* sourcekit won't give me a module interface for `CSteamworks` to see what else the
  importer is doing.  Probably Xcode's fault, still not passing the user's flags to
  sourcekit and still doing insultingly bad error-reporting.

### Non-Swift Problems

* Some [Steamworks SDK issues](#json-notes), nothing too serious.
* How do I CI this stuff?  SDK license doesn't seem to allow non-local redistribution,
  with that could build the thing; don't really fancy installing the steam client but
  maybe that's doable.

### Requirements

* Needs Swift 5.6 (Xcode 13.3)
* Needs Steam client installed
* I'm using macOS 12; should work on macOS 11, Linux; might work on Windows

To run the generator / build:
* Needs Steamworks SDK downloaded as `sdk` at the top level of the package, or
  set `STEAM_SDK`

### Interface plan

✅ ISteamAppList, ISteamApps, ISteamFriends, ISteamGameSearch, ISteamGameServer,
ISteamGameServerStats, ISteamHTMLSruface, ISteamHTTP, ISteamInput, ISteamInventory,
ISteamMatchMaking, ISteamMatchmakingServers, ISteamMusic, ISteamMusicRemote,
ISteamNetworkingMessages, ISteamNetworkingSockets, ISteamNetworkingUtils,
ISteamParentalSettings, ISteamParties, ISteamRemotePlay, ISteamRemoteStorage,
ISteamScreenshots, ISteamUGC, ISteamUser, ISteamUserStats, ISteamUtils, ISteamVideo,
SteamEncryptedAppTicket

Left to do:
* Public initializers for types
* Pondering of int types etc.
* Array and String management improvements
* Review all the random customizations

Skip:
* ISteamAppTicket - er not actually a thing?
* ISteamClient - internal stuff, very C++y, looks ignorable
* ISteamController - deprecated, need to review for stuff that's been generated and
  can actually be deleted after working through ISteamInput
* ISteamGameCoordinator - "largely" deprecated
* ISteamNetworking - this is the pre-modern interface
* ISteamPS3... - will leave Swift-on-PS3 for another day

### JSON notes

Capture some notes on troubles reflecting the json into the module.

* The 'modern' `isteamnetworking` stuff is incomplete somehow - Json describes
  `SteamDatagramGameCoordinatorServerLogin`, `SteamDatagramHostedAddress` are missing
  from the header files.  The online API docs are hilariously broken here, scads of
  broken links.  Have to wait for Valve to fix this.

* `SteamNetworkingMessage_t` doesn't import into Swift.  Probably stumbling into a hole
  of C++ struct with function pointer fields.  Trust Apple will get to this eventually,
  can write a zero-cost inline shim if necessary.

* Json (and all non-C languages) struggles with unions.  Thankfully rare:
  `SteamIPAddress_t`, `SteamInputAction_t`, `SteamNetworkingConfigValue_t`.
  `SteamNetworkingConfigValue_t`.  Rare enough to deal with manually.

* Loads of missing `out_string_count` etc. annotations and a few wrong, see patchfile.
