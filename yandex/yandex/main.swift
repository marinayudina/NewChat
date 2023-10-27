//
//  main.swift
//  yandex
//
//  Created by Марина on 24.10.2023.
//

import Foundation

print("Hello, World!")

func getnumber() {
    guard let str = readLine() else {return }

    let stringArray = str.components(separatedBy: CharacterSet.decimalDigits.inverted)
    print(stringArray)
    let stringArray1 = str.components(separatedBy: CharacterSet.alphanumerics).filter({ $0 != ""})
    print(stringArray1)
    var res = Int(stringArray[0])!
    let count = stringArray.count
    for (i,_) in stringArray.enumerated() {
//        for (i1, value) in stringArray1.enumerated() {
            if (i < count - 1) {
                if (stringArray1[i]) == "+" {
                    res = res + Int(stringArray[i + 1])!
                } else {
                    res = res - Int(stringArray[i + 1])!
                }
//            }
        }
    
        
    }
    print(res)
}
getnumber()

extension Int {
    static func parse(from string: String) -> Int? {
        Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
//func getAlphaNumericValue() {
//
//    var yourString  = "123456789!@#$%^&*()AnyThingYouWant"
//
//    let unsafeChars = CharacterSet.alphanumerics  // Remove the .inverted to get the opposite result.
//
//    let cleanChars  = yourString.components(separatedBy: unsafeChars).joined(separator: "")
//
//
//    print(cleanChars)  // 123456789AnyThingYouWant
//
//}
//getAlphaNumericValue()
