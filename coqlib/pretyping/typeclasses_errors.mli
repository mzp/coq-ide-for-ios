(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: typeclasses_errors.mli 13323 2010-07-24 15:57:30Z herbelin $ i*)

(*i*)
open Names
open Decl_kinds
open Term
open Sign
open Evd
open Environ
open Nametab
open Mod_subst
open Topconstr
open Util
open Libnames
(*i*)

type contexts = Parameters | Properties

type typeclass_error =
  | NotAClass of constr
  | UnboundMethod of global_reference * identifier located (* Class name, method *)
  | NoInstance of identifier located * constr list
  | UnsatisfiableConstraints of evar_map * (existential_key * hole_kind) option
  | MismatchedContextInstance of contexts * constr_expr list * rel_context (* found, expected *)

exception TypeClassError of env * typeclass_error

val not_a_class : env -> constr -> 'a

val unbound_method : env -> global_reference -> identifier located -> 'a

val no_instance : env -> identifier located -> constr list -> 'a

val unsatisfiable_constraints : env -> evar_map -> evar option -> 'a

val mismatched_ctx_inst : env -> contexts -> constr_expr list -> rel_context -> 'a

val unsatisfiable_exception : exn -> bool
