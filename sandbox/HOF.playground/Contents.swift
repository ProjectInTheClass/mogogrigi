import UIKit


var retArray: [Int] = []
var array = [1, 2, 3]


// 1. 아래 함수와 동일한 함수 작성
for i in array {
    retArray.append(i * 2)
}
print(array)


// 2
let strArray: [String] = ["one", "two", "three"]

var resultInt = 0

for item in strArray {
    resultInt += item.count
}
print(resultInt)

