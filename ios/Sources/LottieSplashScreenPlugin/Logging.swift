import Capacitor

/**
 * Utility function for logging messages with a custom prefix.
 *
 * This function is designed to format log messages for the LottieSplashScreen plugin. It prepends the log output
 * with a custom prefix (`⚡️  LottieSplashScreen -`) to easily identify logs associated with this plugin.
 *
 * @param items - A variadic parameter accepting a list of items to log. Each item will be converted to a string and logged sequentially.
 * @param separator - A string used to separate the logged items. Defaults to a single space (`" "`).
 * @param terminator - A string appended to the end of the log message. Defaults to a newline (`"\n"`).
 *
 * Example Usage:
 * ```
 * log("This is a message", "with multiple parts", separator: ", ")
 * // Output: ⚡️  LottieSplashScreen - This is a message, with multiple parts
 * ```
 *
 * Note:
 * - This function uses Capacitor's `CAPLog.print` for outputting log messages.
 * - If multiple items are logged, they will be separated by the specified `separator` and terminated by the `terminator`.
 */
func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    // Prefix the log with "⚡️  LottieSplashScreen -"
    CAPLog.print("⚡️  LottieSplashScreen -", terminator: separator)

    // Iterate over the provided items and print each one
    for (itemIndex, item) in items.enumerated() {
        // Use the specified separator between items, and the terminator for the final item
        CAPLog.print(item, terminator: itemIndex == items.count - 1 ? terminator : separator)
    }
}
