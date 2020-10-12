import UIKit

var str = "Hello, playground"


//배열에 두배씩
var emptyArray:[Int] = []
var array:[Int] = [1, 2, 3, 4]

for twice in array  {
    emptyArray.append(twice * 2)
}
print(emptyArray)



//글자수 세서 다 더하기
let strArray: [String] = ["one", "two", "three"]

var result = 0
 
for sumChar in strArray {
    result = result + sumChar.count
}

print(result)


