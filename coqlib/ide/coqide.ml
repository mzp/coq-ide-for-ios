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
  let reset_info =
    Coq.interp true s in
    Coq.push_phrase cmd_stack reset_info ()

let start () =
  ignore @@ Coq.init ();
  Callback.register "eval" eval
