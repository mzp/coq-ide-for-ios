let answer _ =
  print_endline "callback test";
  42


let _ =
  Callback.register "answer" answer;
  print_endline "(!!)"
