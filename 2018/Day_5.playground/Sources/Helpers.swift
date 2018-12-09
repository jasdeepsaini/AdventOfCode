import Foundation

public func readInputFile() -> String {
    let fileUrl = Bundle.main.url(forResource: "Input", withExtension: "txt") ?? URL(fileURLWithPath: "")

    var input = ""
    do {
        input = try String(contentsOf: fileUrl)
        return input
    } catch {
        print("Error reading file: \(error)")
    }

    return input
}
