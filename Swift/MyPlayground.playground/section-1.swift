var chap: String?

//変数 var
//定数 let

//var msg: String
/*
var msg = "hello world!"
let s = "hey!"


println("msg: \(msg), s: \(s)")
*/

chap = "基本データ型"

//let a: Float = 4.0 % 1.5

//conversion
/*
let b = "aaa"
let c = 50
let d = b + String(c)
*/

chap = "タプル"
/*
let error = (code:404, msg:"not found")
error.0
error.code
let (num, _) = error
*/

chap = "配列"
/*
var colors: [String] = ["blue", "pink"]
colors[0]
colors.count
colors.isEmpty
colors.append("green")
colors.insert("white", atIndex: 1)
colors.removeLast()
colors
var empty = [String]()
*/

chap = "辞書"
//key: value
/*
var users: [String: Int]=[
    "me": 1,
    "TAG": 500
]
users["TAG"]
users["ARIGA"] = 334
users
users.removeValueForKey("ARIGA")
users

users.updateValue(1000, forKey: "TAG")
users["TAG"]

let keys = Array(users.keys)

var empDic = [String: Int]()
*/

chap = "if"
/*
let score = 82
var result = ""

if score > 80 {
    result = "great"
}else if score > 60 {
    result = "not bad"
}else {
    result = "bad"
}

result = score > 80 ? "great" : "not bad"
*/

chap = "switch"
/*
let num = 0

switch num {
case 0:
    println("zero")
    fallthrough
case 1,2,3:
    println("small")
case 4...6: //4,5,6
    println("4,5,6")
case 7..<9:
    println("7/8")
default:
    break
}
*/

chap = "while"
/*
var n = 0
while n < 10 {
    println(n)
    n++
}
do{
    println(n)
    n++
} while n < 10
*/

chap = "for"
/*
for var i = 0; i < 10; i++ {
    if i == 3 {
        continue
    }
    println(i)

}
for i in 0...9 {
    println(i)
}
let a = [5, 3, 19]
for i in a {
    println(i)
}

let d = ["me":1, "you":20]
for(k, v) in d{
    println("key: \(k), val: \(v)")
}
*/

chap = "Optional"
/*
var s: String?
s = nil

let name: String? = "me"
let msg = "hello " + name!

if let s = name {
    let msg = "hello " + s
}
//暗黙的にunwrap
var label: String!
label = "score"
println(label)
*/


chap = "関数"
/*
func sayHi1(myname name: String) {
    println("Hi," + name)
}
sayHi1(myname: "Tom")

func sayHi2(#name: String) {
    println("Hi," + name)
}
sayHi2(name: "Tom")

func sayHi3(#name: String = "anonymus") {
    println("Hi," + name)
}
sayHi3()
sayHi3(name: "Bob")
*/

/*
func sum(a:Int, b:Int) -> Int {
    return a + b
}
println(sum(2, 3))

//タプルで
func swap(a:Int, b:Int) -> (Int, Int) {
    return (b, a)
}
println(swap(2, 5))

func f(var a:Int) {
    a = 20
}
var a = 5
f(a) //値渡し
a

func f(inout a:Int) {
    a = 20
}
var b = 5
f(&a) //参照渡し
a
*/


chap = "列挙型"
/*
enum Result: Int { //1文字目大文字
    case Success = 0
    case Error // = 1
    //メソッドも作れる
    func getMessage() -> String {
        switch self {
        case .Success:
            return "OK"
        case .Error:
            return "NG"
        }
    }
}
var r: Result
r = Result.Success
r = .Success
Result.Success.rawValue
Result.Error.getMessage()
r.getMessage()
*/

chap = "クラス"
/*
クラス(User) -> インスタンス(Tom, Bob)
- 変数 name, score: プロパティ
  -プロパティは必ずoptionalか初期化する必要がある(Initializer)
- 関数 sayHi(): メソッド
*/
/*
class User{
    var name: String
    var score: Int = 0
    init(name: String){ //イニシャライザ
        self.name = name
    }
    //override禁止：final
    func upgrade(){
        score++
    }
}
var tom = User(name: "Tom")
tom.upgrade()
tom.score
*/

chap = "クラス継承"
/*
class AdminUser: User{
    func reset(){
        score = 0
    }
    override func upgrade() {
        super.upgrade() //親クラス
        score += 3
    }
}
var bob = AdminUser(name: "Bob")
bob.name
bob.upgrade()
bob.reset()
*/

chap = "プロトコル" //(抽象クラス?)
//継承関係がないような複数クラスに似た機能をもたせられる
/*
protocol Student {
    var studentId: String { get set }
    func study()
}
class User: Student{
    var name: String
    var score: Int = 0 {
        willSet {
            println("will \(score) -> \(newValue)")
        }
        didSet {
            println("did \(oldValue) -> \(score)")
        }

    }

    var level: Int {
        get {
            return Int(score / 10)
        }
        set {
            score = Int(newValue * 10)
        }
    }
    var studentId: String = "111"
    func study() {
        println("I'm studying...")
    }
    init(name: String){ //イニシャライザ
        self.name = name
    }
    //override禁止：final
    func upgrade(){
        score++
    }
}
var tom = User(name: "Tom")
tom.level
tom.score = 52
tom.level
tom.level = 8
tom.score
//おもしろい
*/

chap = "optional chaining"
//クラスのプロパティやメソッドが存在するか確認するためのもの
//「!」を「?」にすることでnilの時点で評価を止めて安全に終了かつnilを返す
/*
class User {
    var blog: Blog? //Blog型optional
}

class Blog {
    var title = "My Blog"
}

var tom = User()
tom.blog = Blog()
//tom.blog!.title
tom.blog?.title

//よく書くやりかた
if let t = tom.blog?.title {
    println(t)
}
*/

chap = "Type Casting"
/*
class User{
    var name: String
    init(name: String){
        self.name = name
    }
}
class AdminUser: User {}
class SomeUser {}

let tom = User(name: "Tom")
let bob = AdminUser(name: "Bob")
let steve = SomeUser()

let users: [User] = [tom, bob]
let ex_users: [AnyObject] = [tom, bob, steve]
for user in users {
//    if user is AdminUser {
//        let u = user as AdminUser //ダウンキャスト(子クラスに変換)
//    }
//よく書くやり方
    if let u = user as? AdminUser {
        println(u.name) //adminのbobのみが表示される
    }
}
*/

chap = "構造体"
/*
struct UserStruct{ //継承不可. シンプルな場合は構造体でいいのかも
    var name: String
    var score: Int = 0
    init(name: String){
        self.name = name
    }
    mutating func update() {
        score++ //明示しないとプロパティ書き換え不可
    }
}
class User{
    var name: String
    var score: Int = 0
    init(name: String){
        self.name = name
    }
    func update() {
        score++
    }
}

var tom = User(name: "Tom")
var tom2 = tom
tom2.name = "tom2"
tom.name //参照渡し

var bob = UserStruct(name: "Bob")
var bob2 = bob
bob2.name = "bob2"
bob.name //値渡し
*/

chap = "拡張" //どんなクラスとかにも使える
/*
extension String {
    var size: Int{ //プロパティ
        return countElements(self)
    }
    func dummy() -> String{
        return "dummy!"
    }
}
var s: String = "hoge"
s.size
s.dummy()
*/

chap = "ジェネリクス" //抽象化
/*
func getIntArray(item: Int, count: Int) -> [Int] {
    var result = [Int]()
    for _ in 0..<count { //安全に破棄するアンダーバー
        result.append(item)
    }
    return result
}


func getArray<T>(item: T, count: Int) -> [T] {
    var result = [T]()
    for _ in 0..<count { //安全に破棄するアンダーバー
        result.append(item)
    }
    return result
}
getIntArray(4,3)
getArray("hello", 2)
*/
