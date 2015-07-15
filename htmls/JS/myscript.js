
/* アラートとか
console.log("hello world!");
answer = confirm("ok?")
console.log(answer);
var name = prompt("what is your name?", "aaa");
console.log(name);
*/

/* 関数とか */
/*
function hello(name){
  console.log("wei!!!" + name);
}
hello("Men!");
*/

// 匿名関数
/*
var hello = function(name){
    var msg = "hello " + name;
    return msg
};
console.log(hello("Tom"));
*/

//即時関数
/*
(function (name){
  console.log("wei!!!" + name);
})("John");

(function(){
  var x = 10,
      y = 20;
  console.log(x + y);
})();
*/

//タイマー処理
/*
var i = 0;
function show(){
  console.log(i++);
}
//次々に処理を行う
setInterval(function(){
  show();
}, 1000);
//1回だけ?
setTimeout(function(){
  show();
}, 1000);
*/
//これで繰り返し処理になる
/*
var i = 0;
function show(){
  console.log(i++);
  var tid = setTimeout(function(){
    show();
  }, 1000);
  if (i>3){
    clearTimeout(tid);
  }
}
show();
*/

//配列
/*
var m = [
  [1,2,3],
  [4,5,6]
];
console.log(m[1][1]);
*/

//オブジェクト
/*
var user = {
  email : "sample@hoge.com", //プロパティ
  score : 80,
  greet : function(name){ //メソッド
      console.log("hello," + name + " from " + this.email);
  }
};

console.log(user.email);
user.greet("Tom")
*/

//組み込みオブジェクト(ふつうはリテラル)
/*
var s = new String("namazu");
console.log(s.length);
console.log(s.substr(1,4));
*/

/*
var a = new Array(1, 2, 3);
a.push(300);
console.log(a);
a.splice(1, 2, 100, 200); //削除
console.log(a);
*/
//console.log(Math.random());

//DOMとは何か : Document Object Model
/*
console.dir(window);
console.log(window.outerHeight);
window.location.href = "http://dotinstall.com" ;
*/
//document...今見ているページ
