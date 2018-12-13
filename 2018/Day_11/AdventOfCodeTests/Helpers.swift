import Foundation

extension AdventOfCodeTests {
    func readInputFileAsString() -> String {
        let fileUrl = Bundle(for: type(of: self)).url(forResource: "Input", withExtension: "txt") ?? URL(fileURLWithPath: "")

        var input = ""
        do {
            input = try String(contentsOf: fileUrl)
        } catch {
            print("Error reading file: \(error)")
        }

        return input
    }

    func readInputFileAsArrayOfStrings() -> [String] {
        let fileUrl = Bundle(for: type(of: self)).url(forResource: "Input", withExtension: "txt") ?? URL(fileURLWithPath: "")

        var components: [String] = []
        do {
            let input = try String(contentsOf: fileUrl)
            components = input.components(separatedBy: "\n")
        } catch {
            print("Error reading file: \(error)")
        }

        return components
    }
}
