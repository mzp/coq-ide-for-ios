let (@@) f g = f g

type ide_info = unit
let cmd_stack : (ide_info * Coq.reset_info) Stack.t =
  Stack.create ()

let mode () =
  match Decl_mode.get_current_mode () with
      Decl_mode.Mode_none -> "none"
    | Decl_mode.Mode_tactic -> "tactic"
    | Decl_mode.Mode_proof -> "proof"

let string_of_assoc xs =
  List.map (fun (name, value) -> Printf.sprintf "%s: %s" name value) xs

let goal (hyps, concl) =
  List.iter
    (fun ((_,_,_,(s,_))) -> Printf.printf "[hyp] %s\n" s) hyps;
  let (_,_,_,s) = concl in
    Printf.printf "[goal] %s" s

let show_goal () =
  try
    if mode() <> "none" then
      goal @@ Coq.get_current_pm_goal ()
  with Not_found ->
    match Decl_mode.get_end_command (Pfedit.get_pftreestate ()) with
        Some endc ->
          print_endline ("Subproof completed, now type "^endc^".")
      | None ->
          print_endline "Proof completed."

let eval s =
  match s with
    | "$undo" ->
        let _,coq =
          Stack.pop cmd_stack in
          Coq.rewind [coq] cmd_stack
    | "$undo2" ->
        let _,x =
          Stack.pop cmd_stack in
        let _,y =
          Stack.pop cmd_stack in
          Coq.rewind [x;y] cmd_stack
    | _ ->
        let reset_info =
          Coq.interp true s in
          Coq.push_phrase cmd_stack reset_info ()

let eval s =
  print_endline s;
  print_endline "=== mode";
  print_endline @@ mode ();
  print_endline "=== interp";
  eval s;
  print_endline "=== goal:";
  print_endline @@ mode ();
  show_goal ();
  print_endline "------------------------------\n"

let start () =
  ignore @@ Coq.init ();
  Callback.register "eval" eval
