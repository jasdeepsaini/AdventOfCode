import Foundation

public func readInputFile() -> [String] {
    let fileUrl = Bundle.main.url(forResource: "Input", withExtension: "txt") ?? URL(fileURLWithPath: "")

    var components: [String] = []
    do {
        let input = try String(contentsOf: fileUrl)
        components = input.components(separatedBy: "\n")
    } catch {
        print("Error reading file: \(error)")
    }

    return components
}
