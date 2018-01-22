(function () {
  "use strict";

  function showContent01() {
    event.preventDefault();
    document.getElementById("content01").style.display = "block";
    document.getElementById("content02").style.display = "none";
    document.getElementById("content03").style.display = "none";
  }

  function showContent02() {
    event.preventDefault();
    document.getElementById("content02").style.display = "block";
    document.getElementById("content01").style.display = "none";
    document.getElementById("content03").style.display = "none";
  }

  function showContent03() {
    event.preventDefault();
    document.getElementById("content03").style.display = "block";
    document.getElementById("content01").style.display = "none";
    document.getElementById("content02").style.display = "none";
  }

  function init() {
    var link01 = document.getElementById("link01");
    var link02 = document.getElementById("link02");
    var link03 = document.getElementById("link03");

    link01.addEventListener("click", showContent01, false);
    link02.addEventListener("click", showContent02, false);
    link03.addEventListener("click", showContent03, false);
  }

  window.addEventListener("load", init, false);
})();
