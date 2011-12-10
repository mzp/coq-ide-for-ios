(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: matching.mli 13323 2010-07-24 15:57:30Z herbelin $ i*)

(*i*)
open Names
open Term
open Environ
open Pattern
open Termops
(*i*)

(*s This modules implements pattern-matching on terms *)

exception PatternMatchingFailure

val special_meta : metavariable

type bound_ident_map = (identifier * identifier) list

(* [matches pat c] matches [c] against [pat] and returns the resulting
   assignment of metavariables; it raises [PatternMatchingFailure] if
   not matchable; bindings are given in increasing order based on the
   numbers given in the pattern *)
val matches : constr_pattern -> constr -> patvar_map

(* [extended_matches pat c] also returns the names of bound variables
   in [c] that matches the bound variables in [pat]; if several bound
   variables or metavariables have the same name, the metavariable,
   or else the rightmost bound variable, takes precedence *)
val extended_matches :
  constr_pattern -> constr -> bound_ident_map * extended_patvar_map

(* [is_matching pat c] just tells if [c] matches against [pat] *)
val is_matching : constr_pattern -> constr -> bool

(* [matches_conv env sigma] matches up to conversion in environment
   [(env,sigma)] when constants in pattern are concerned; it raises
   [PatternMatchingFailure] if not matchable; bindings are given in
   increasing order based on the numbers given in the pattern *)
val matches_conv :env -> Evd.evar_map -> constr_pattern -> constr -> patvar_map

(* The type of subterm matching results: a substitution + a context
   (whose hole is denoted with [special_meta]) + a continuation that
   either returns the next matching subterm or raise PatternMatchingFailure *)
type subterm_matching_result =
    (bound_ident_map * patvar_map) * constr * (unit -> subterm_matching_result)

(* [match_subterm n pat c] returns the substitution and the context
   corresponding to the first **closed** subterm of [c] matching [pat], and
   a continuation that looks for the next matching subterm.
   It raises PatternMatchingFailure if no subterm matches the pattern *)
val match_subterm : constr_pattern -> constr -> subterm_matching_result

(* [match_appsubterm pat c] returns the substitution and the context
   corresponding to the first **closed** subterm of [c] matching [pat],
   considering application contexts as well. It also returns a
   continuation that looks for the next matching subterm.
   It raises PatternMatchingFailure if no subterm matches the pattern *)
val match_appsubterm : constr_pattern -> constr -> subterm_matching_result

(* [match_subterm_gen] calls either [match_subterm] or [match_appsubterm] *)
val match_subterm_gen : bool (* true = with app context *) ->
   constr_pattern -> constr -> subterm_matching_result

(* [is_matching_appsubterm pat c] tells if a subterm of [c] matches
   against [pat] taking partial subterms into consideration *)
val is_matching_appsubterm : ?closed:bool -> constr_pattern -> constr -> bool

(* [is_matching_conv env sigma pat c] tells if [c] matches against [pat]
   up to conversion for constants in patterns *)
val is_matching_conv :
  env -> Evd.evar_map -> constr_pattern -> constr -> bool
