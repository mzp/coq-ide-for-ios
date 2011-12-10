(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: btermdn.mli 13323 2010-07-24 15:57:30Z herbelin $ i*)

(*i*)
open Term
open Pattern
open Names
(*i*)

(* Discrimination nets with bounded depth. *)
module Make :
  functor (Z : Map.OrderedType) ->
sig
  type t

  val create : unit ->  t

  val add : transparent_state option -> t -> (constr_pattern * Z.t) -> t
  val rmv : transparent_state option -> t -> (constr_pattern * Z.t) -> t

  val lookup : transparent_state option -> t -> constr -> (constr_pattern * Z.t) list
  val app : ((constr_pattern * Z.t) -> unit) -> t -> unit
end
    
val dnet_depth : int ref

