(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: typing.mli 13323 2010-07-24 15:57:30Z herbelin $ i*)

(*i*)
open Term
open Environ
open Evd
(*i*)

(* This module provides the typing machine with existential variables
   (but without universes). *)

(* Typecheck a term and return its type *)
val type_of : env -> evar_map -> constr -> types
(* Typecheck a type and return its sort *)
val sort_of : env -> evar_map -> types -> sorts
(* Typecheck a term has a given type (assuming the type is OK) *)
val check   : env -> evar_map -> constr -> types -> unit

(* Returns the instantiated type of a metavariable *)
val meta_type : evar_map -> metavariable -> types

(* Solve existential variables using typing *)
val solve_evars : env -> evar_map -> constr -> constr
