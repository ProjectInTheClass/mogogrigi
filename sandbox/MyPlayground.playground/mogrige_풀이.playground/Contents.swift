import UIKit

var str = "Hello, playground"


//배열에 두배씩
var emptyArray:[Int] = []
var array:[Int] = [1, 2, 3, 4]

//for twice in array  {
//    emptyArray.append(twice * 2)
//}
//print(emptyArray)


//풀이1
//func multiple(arg: Int) -> Int{
//    return arg * 2
//}
//let ret = array.map(multiple)

//풀이2
let ret = array.map({ (arg: Int) -> Int in
    return arg * 2
})
print(ret)





//글자수 세서 다 더하기
let strArray: [String] = ["one", "two", "three"]

//var result = 0
//for sumChar in strArray {
//    result = result + sumChar.count
//}
//print(result)

//풀이1
//func countSum(result: Int, sumChar: String) -> Int {
//    return result + sumChar.count
//}
//let ret2 = strArray.reduce(0, countSum)


//풀이2(줄여쓰기)
let ret2 = strArray.reduce(0){ (result, sumChar) -> Int in
    return result + sumChar.count
}

print(ret2)
