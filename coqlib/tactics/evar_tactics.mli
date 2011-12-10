(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: evar_tactics.mli 13323 2010-07-24 15:57:30Z herbelin $ i*)

open Tacmach
open Names
open Tacexpr
open Termops

val instantiate : int -> Tacinterp.interp_sign * Rawterm.rawconstr ->
  (identifier * hyp_location_flag, unit) location -> tactic

(*i
val instantiate_tac : tactic_arg list -> tactic
i*)

val let_evar : name -> Term.types -> tactic
