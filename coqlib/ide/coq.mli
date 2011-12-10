(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: coq.mli 13323 2010-07-24 15:57:30Z herbelin $ i*)

open Names
open Term
open Environ
open Evd

val short_version : unit -> string
val version : unit -> string

type printing_state = {
  mutable printing_implicit : bool;
  mutable printing_coercions : bool;
  mutable printing_raw_matching : bool;
  mutable printing_no_notation : bool;
  mutable printing_all : bool;
  mutable printing_evar_instances : bool;
  mutable printing_universes : bool;
  mutable printing_full_all : bool
}

val printing_state : printing_state

type reset_info

val reset_initial : unit -> unit

val init : unit -> string list
val interp : bool -> string -> reset_info
val interp_last : Util.loc * Vernacexpr.vernac_expr -> unit
val interp_and_replace : string ->
      reset_info * string

val push_phrase : ('a * reset_info) Stack.t -> reset_info -> 'a -> unit

val rewind : reset_info list -> ('a * reset_info) Stack.t -> unit

val is_vernac_tactic_command : Vernacexpr.vernac_expr -> bool
val is_vernac_state_preserving_command : Vernacexpr.vernac_expr -> bool
val is_vernac_goal_starting_command : Vernacexpr.vernac_expr -> bool
val is_vernac_proof_ending_command : Vernacexpr.vernac_expr -> bool

(* type hyp = (identifier * constr option * constr) * string *)

type hyp = env * evar_map *
           ((identifier*string) * constr option * constr) * (string * string)
type meta = env * evar_map * string
type concl = env * evar_map * constr * string
type goal = hyp list * concl

val get_current_goals : unit -> goal list

val get_current_pm_goal : unit -> goal

val print_no_goal : unit -> string

val process_exn : exn -> string*(Util.loc option)

val hyp_menu : hyp -> (string * string) list
val concl_menu : concl -> (string * string) list

val is_in_coq_lib : string -> bool
val is_in_coq_path : string -> bool
val is_in_loadpath : string -> bool

val make_cases : string -> string list list


type tried_tactic =
  | Interrupted
  | Success of int (* nb of goals after *)
  | Failed

(* Message to display in lower status bar. *)

val current_status : unit -> string
