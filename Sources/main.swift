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
        if n <= 6666 && n >= 1000{
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

var secretBool = [Int](repeating: 0, count: 4)
var guess = [Int](repeating: 0, count: 4)
var guessBool = [Int](repeating: 0, count: 4)

print("Welcom to Mastemind")
var secret = (0..<4).map { _ in Int.random(in: 1...6) }
var secretNumber = 0
for i in 0..<4{
    secretNumber += secret[i]
    secretNumber *= 10 
}
secretNumber /= 10
//print(secret)
print("Guess 4 digits between 1 to 6")
print("You can exit the game using end")
var attempts = 0
outer: while true{
    guard let input = readLine() else { break }
    switch parseInput(input) {
    case .end:
        print("You Lose!")
        print("Total attemps: \(attempts)")
        print("secret code was: \(secretNumber)")
        break outer
    case .number(let n):
        //print("number: \(n)")
        var temp = n
        attempts += 1
        var black = 0
        var white = 0
        for i in 0..<4{
            guess[3-i] = temp % 10
            temp /=  10
            secretBool[i] = 0
            guessBool[i] = 0
        }
        //print(guess)
        //print(secret)
        for i in 0..<4{
            if secret[i] == guess[i]{
                black+=1
                secretBool[i] = 1
                guessBool[i] = 1
            }
        }
        if(black == 4){
            print("You WIN!")
            print("Total attemtps: \(attempts)")
            print("Secret code was: \(secretNumber)")
            break outer
        }
        for i in 0..<4{
            for j in 0..<4{
                if guess[i] == secret[j] && guessBool[i] == 0 && secretBool[j] == 0{
                    white+=1
                    guessBool[i] = 1
                    secretBool[j] = 1
                }
            }
        }
        //print(secretBool)
        //print(guessBool)
        //print(black)
        //print(white)
        var output = ""
        for _ in 1...4{
            if(black != 0){
                output = output + "B"
                black-=1
            }
        }
        for _ in 1...4{
            if(white != 0){
                output = output + "W"
                white-=1
            }
        }
        print(output)
    case .badInput:
        print("Wrong instruction or bad number")
    }
}
