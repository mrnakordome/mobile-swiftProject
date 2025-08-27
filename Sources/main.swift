// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

enum InputResult {
    case end
    case number(Int)
    case badInput
}

func parseInput(_ input: String) -> InputResult {
    if input == "end" { return .end }
    if let n = Int(input) {
        if n <= 6666 && n >= 0000{
            var temp = n
            for _ in 1...4{
                if(temp % 10) == 0 || (temp % 10) > 6{
                    return .badInput
                }
                temp /= 10
            }
            return .number(n)
        } 
    }
    return .badInput
}


print("start")
var secret = (0..<4).map { _ in Int.random(in: 1...6) }
var secretNumber = 0
for i in 0..<4{
    secretNumber += secret[i]
    secretNumber *= 10 
}
secretNumber /= 10
print(secret)

var attempts = 0
outer: while true{
    guard let input = readLine() else { break }
    switch parseInput(input) {
    case .end:
        print("ending")
        print("your total attemps where: \(attempts)")
        print("secret number was : \(secretNumber)")
        break outer
    case .number(let n):
        print("number: \(n)")
        attempts += 1
    case .badInput:
        print("bad input")
    }
}
