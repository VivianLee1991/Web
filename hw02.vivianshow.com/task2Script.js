(function () {
  "use strict";

  function popup() {
    var num = document.getElementById("heading").innerHTML;
    alert(num);
  }

  function increment() {
    var num = document.getElementById("heading").innerHTML;
    document.getElementById("heading").innerHTML = parseInt(num) + 1;
  }

  function append () {
    var num = document.getElementById("heading").innerHTML;
    document.getElementById("demo").innerHTML += num + "<br>";
  }

  function init() {
    var btn01 = document.getElementById("btn01");
    var btn02 = document.getElementById("btn02");
    var btn03 = document.getElementById("btn03");
    btn01.addEventListener("click", popup);
    btn02.addEventListener("click", increment);
    btn03.addEventListener("click", append);
  }

  window.addEventListener("load", init, false);
})();
