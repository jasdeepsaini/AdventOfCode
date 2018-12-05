import Foundation
import XCTest

struct Claim {
    let claimant: String;
    let x: NSInteger;
    let y: NSInteger;
    let width: NSInteger;
    let height: NSInteger;
}

func findOverlappingClaimsArea(for claimStrings: [String]) -> Int {
    var claims = [String: [String]]()

    for claimString in claimStrings {
        guard let claim = parseClaim(claimString) else {
            continue
        }

        for x in claim.x..<(claim.x + claim.width) {
            for y in claim.y..<(claim.y + claim.height) {
                let key = "\(x)-\(y)"
                if let _ = claims[key] {
                    claims[key]?.append(claim.claimant)
                } else {
                    claims[key] = [claim.claimant]
                }
            }
        }
    }

    let multipleClaims = claims.filter { (_, value) -> Bool in
        return value.count > 1
    }

    return multipleClaims.count
}

func parseClaim(_ claim: String) -> Claim? {
    if claim.count == 0 {
        return nil
    }

    guard let regex = try? NSRegularExpression(pattern: "^#([0-9]+) @ ([0-9]+),([0-9]+): ([0-9]+)x([0-9]+)", options: .caseInsensitive) else {
        fatalError("Invalid Regex")
    }

    let results = regex.matches(in: claim, options: [], range: NSRange(location: 0, length: claim.count))

    let claimString = claim as NSString
    let result = results[0]

    guard let x = Int(claimString.substring(with: result.range(at: 2))),
        let y = Int(claimString.substring(with: result.range(at: 3))),
        let width = Int(claimString.substring(with: result.range(at: 4))),
        let height = Int(claimString.substring(with: result.range(at: 5))) else {
            fatalError("Parsing Failed")
    }

    let claimant = claimString.substring(with: result.range(at: 1))
    return Claim(claimant: claimant, x: x, y: y, width: width, height: height)
}

class CodeTests: XCTestCase {
    func testParsing() {
        let claimString = "#1273 @ 172,117: 23x20"
        let claim = parseClaim(claimString)!

        XCTAssertEqual(claim.claimant, "1273")
        XCTAssertEqual(claim.x, 172)
        XCTAssertEqual(claim.y, 117)
        XCTAssertEqual(claim.width, 23)
        XCTAssertEqual(claim.height, 20)
    }

    func testExample1() {
        let claimStrings = ["#1 @ 1,3: 4x4",
                            "#2 @ 3,1: 4x4",
                            "#3 @ 5,5: 2x2"]

        XCTAssertEqual(findOverlappingClaimsArea(for: claimStrings), 4)
    }

    func testFindMultipleClaimArea() {
        let claims = input()
        XCTAssertEqual(findOverlappingClaimsArea(for: claims), 110195)
    }

    private func input() -> [String] {
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

}

CodeTests.defaultTestSuite.run()
