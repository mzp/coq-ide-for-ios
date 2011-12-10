(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: dhyp.mli 13323 2010-07-24 15:57:30Z herbelin $ i*)

(*i*)
open Names
open Tacmach
open Tacexpr
(*i*)

(* Programmable destruction of hypotheses and conclusions. *)

val set_extern_interp : (glob_tactic_expr -> tactic) -> unit

(*
val dHyp : identifier -> tactic
val dConcl : tactic
*)
val h_destructHyp : bool -> identifier -> tactic
val h_destructConcl : tactic
val h_auto_tdb : int option -> tactic

val add_destructor_hint :
  Vernacexpr.locality_flag -> identifier -> (bool,unit) Tacexpr.location ->
    Rawterm.patvar list * Pattern.constr_pattern -> int ->
      glob_tactic_expr -> unit
