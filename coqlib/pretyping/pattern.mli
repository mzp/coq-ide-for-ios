(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: pattern.mli 13323 2010-07-24 15:57:30Z herbelin $ i*)

(*i*)
open Pp
open Names
open Sign
open Term
open Environ
open Libnames
open Nametab
open Rawterm
open Mod_subst
(*i*)

(* Types of substitutions with or w/o bound variables *)

type constr_under_binders = identifier list * constr
type patvar_map = (patvar * constr) list
type extended_patvar_map = (patvar * constr_under_binders) list

(* Patterns *)

type constr_pattern =
  | PRef of global_reference
  | PVar of identifier
  | PEvar of existential_key * constr_pattern array
  | PRel of int
  | PApp of constr_pattern * constr_pattern array
  | PSoApp of patvar * constr_pattern list
  | PLambda of name * constr_pattern * constr_pattern
  | PProd of name * constr_pattern * constr_pattern
  | PLetIn of name * constr_pattern * constr_pattern
  | PSort of rawsort
  | PMeta of patvar option
  | PIf of constr_pattern * constr_pattern * constr_pattern
  | PCase of (case_style * int array * inductive option * (int * int) option)
      * constr_pattern * constr_pattern * constr_pattern array
  | PFix of fixpoint
  | PCoFix of cofixpoint

(** {5 Functions on patterns} *)

val occur_meta_pattern : constr_pattern -> bool

val subst_pattern : substitution -> constr_pattern -> constr_pattern

exception BoundPattern

(* [head_pattern_bound t] extracts the head variable/constant of the
   type [t] or raises [BoundPattern] (even if a sort); it raises an anomaly
   if [t] is an abstraction *)

val head_pattern_bound : constr_pattern -> global_reference

(* [head_of_constr_reference c] assumes [r] denotes a reference and
   returns its label; raises an anomaly otherwise *)

val head_of_constr_reference : Term.constr -> global_reference

(* [pattern_of_constr c] translates a term [c] with metavariables into
   a pattern; currently, no destructor (Cases, Fix, Cofix) and no
   existential variable are allowed in [c] *)

val pattern_of_constr : Evd.evar_map -> constr -> named_context * constr_pattern

(* [pattern_of_rawconstr l c] translates a term [c] with metavariables into
   a pattern; variables bound in [l] are replaced by the pattern to which they
    are bound *)

val pattern_of_rawconstr : rawconstr ->
      patvar list * constr_pattern

val instantiate_pattern :
  Evd.evar_map -> (identifier * (identifier list * constr)) list ->
  constr_pattern -> constr_pattern

val lift_pattern : int -> constr_pattern -> constr_pattern
