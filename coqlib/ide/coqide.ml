let (@@) f g = f g

type ide_info = unit
let cmd_stack : (ide_info * Coq.reset_info) Stack.t =
  Stack.create ()

let mode () =
  match Decl_mode.get_current_mode () with
      Decl_mode.Mode_none -> "none"
    | Decl_mode.Mode_tactic -> "tactic"
    | Decl_mode.Mode_proof -> "proof"

let is_proof_mode () =
  mode() <> "none"

let string_of_assoc xs =
  List.map (fun (name, value) -> Printf.sprintf "%s: %s" name value) xs

let string_of_goal (hyps, concl) =
  let hs =
    List.map (fun ((_,_,_,(s,_))) -> s) hyps in
  let (_,_,_,s) =
    concl in
    List.fold_left (Printf.sprintf "%s\n%s") "" @@ hs @ ["============================"; " " ^ s]

let get_goal () =
    try
      string_of_goal @@ Coq.get_current_pm_goal ()
    with Not_found ->
      match Decl_mode.get_end_command (Pfedit.get_pftreestate ()) with
        | Some endc ->
            "Subproof completed, now type "^endc^"."
        | None ->
            "Proof completed."

let eval s =
  let reset_info =
    Coq.interp true s in
    Coq.push_phrase cmd_stack reset_info ()

let start () =
  ignore @@ Coq.init ();
  Callback.register "is_proof_mode" is_proof_mode;
  Callback.register "get_goal" get_goal;
  Callback.register "eval" eval
