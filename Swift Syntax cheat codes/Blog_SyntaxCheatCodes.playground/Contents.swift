//: Playground - noun: a place where people can play

import UIKit


// MARK: - Closure

UIView.animateWithDuration(3, animations: {
    // This is a closure in an argument
})

// MARK: - Trailing Closure

UIView.animateWithDuration(3) {
    // This is a trailing closure
    // 尾部闭包
    // It's the same API call as the one above
    // 调用相同的API
    // 尾部闭包允许我们省略参数名，并且能放置在参数表括号以外
}


// MARK: More closure stuff
// 更多的闭包形式


let closure: () -> Void

func doSomething(something: () -> Void) {
    something()
}

//let usedClosure = closure()
//doSomething(usedClosure)


// MARK: - Type Alias
// 类型别名

typealias TripleThreat = (Int, String, Double) -> (Int, String, Double)

// Without typealias

func _dance(dance: (Int, String, Double) -> (Int, String, Double)) { }
func _sing(sing: (Int, String, Double) -> (Int, String, Double)) { }
func _act(act: (Int, String, Double) -> (Int, String, Double)) { }

// With typealias
// 使用别名来构造闭包参数方法

func dance(dance: TripleThreat) { }

func act(act: TripleThreat) { }

func sing(sing: TripleThreat) { }


// MARK: - Shorthand Argument Names
// 使用参数名缩写

func say(message: String, completion: (goodbye: String) -> Void) {
    print(message)
    completion(goodbye: "Goodbye")
}
    
say("Hi") { (goodbye: String) -> Void in
        print(goodbye)
}

// prints: "Hi"
// prints: "Goodbye"

say("Hi") { print($0) }

// prints: "Hi"
// prints: "Goodbye"
