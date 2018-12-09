import Foundation

extension CodeTest {
    func readInputFile() -> String {
        let fileUrl = Bundle(for: type(of: self)).url(forResource: "Input", withExtension: "txt") ?? URL(fileURLWithPath: "")

        var input = ""
        do {
            input = try String(contentsOf: fileUrl)
        } catch {
            print("Error reading file: \(error)")
        }

        return input
    }
}
