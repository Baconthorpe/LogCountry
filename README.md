![logo](LogCountryLogo-01.png)

LogCountry is a simple iOS logging framework written in Swift.

## Usage

### Logging and Levels
LogCountry's basic function is simple. Just call the `log()` function anywhere and pass in something you'd like to be printed.
```swift
log("This framework is great!")
```
You can also set the log level, to filter out messages that aren't relevant.

Set the level to `silent` to deactivate all your calls to `log()`. This will make for a nice, clean console.
```swift
setLogLevel(to: .silent)
log("Is this thing on?")  // This message will not appear in the logs.
```
Set the level to `error` to print only the most important messages. You can specify `error` as a message's level, but `log()` messages print at that level by default, anyway.
```swift
setLogLevel(to: .error)
log(.error, "Do you concur, doctor?")  // This will print.
log("Yes, doctor, I concur.")          // So will this.
```
Set the level to `debug` if you want to see messages that describe the normal operation of a program, as well as error messages.
```swift
setLogLevel(.debug)
log(.debug, "Loading files...")     // This will print.
log(.error, "Aaand they're gone.")  // So will this.
```
Set the level to `verbose` if you want all log messages printed.
```swift
setLogLevel(.verbose)
log(.debug, "API client initialized.")
log(.verbose, "API status normal. Access token = XXXXX")
log(.error, "Uh-oh. Something might be broken.")
log("Yeah, definitely broken. You didn't use the XXXXX placeholder token, did you?")
// These messages will all print.
```
Specifying log levels for your messages can help you more effectively debug. And LogCountry makes it easy!

### Prefixes

Long logs can be hard to read - which message was logged at which level? LogCountry helps you straighten things out by supporting prefixes for each log level.

A log level prefix is a message that precedes every log made at a particular level. By default, the `error` level has no prefix, but `debug` has "DEBUG: " and `verbose` has "VERBOSE ".

You can set these levels to whatever you prefer.
```swift
setLogLevelPrefix(for: .error, to: "ERROR DETECTED - ")
setLogLevelPrefix(for: .debug, to: "D - ")

log(.error, "No internet.")               // This will print as 'ERROR DETECTED - No internet.'
log(.debug, "Searching for internet...")  // This will print as 'D - Searching for internet...'
```

### Modular Logging

What's that? You don't like global functions? Paranoid about singletons? Compulsive about modularity?

No problem! You can instantiate a `LogCabin` that will keep all your level and prefix settings localized.
```swift
let uiCabin = LogCabin()
uiCabin.setLogLevelPrefix(for: .debug, to: "UI Debug: ")
uiCabin.setLogLevel(to: .debug)
uiCabin.log(.debug, "The login screen has appeared.")  // Will print as 'UI Debug: The login screen has appeared.'
```
Setting up instances of `LogCabin` can help you make logs specific to each part of an app. They're also handy if you're making a framework and want to keep everything in-house.

## License
All rights - Zeke Abuhoff 2016
