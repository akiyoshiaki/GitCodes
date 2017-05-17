var text = "text";
var target_dom = document.getElementById("draw_target");
var config = {
  step: 6,
  width: 30,
  ascender: 20,
  descender: 20,
  h_stroke_width: 6,
  v_stroke_width: 6,
  kerning: 10,
  line_space: 20,
  h_fillcolor: "black",
  v_fillcolor: "black",
  sl_fillcolor: "black"
}

$(function () {
  //$("#svg2").attr({"width":200, "height":150});

  $("#test").click(function () {
    $("#svg2").attr({"width":300, "height":200});
  })
});
// $(document).ready(function(){
//     console.log("BBB");
// });
