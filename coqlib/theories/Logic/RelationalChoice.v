(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: RelationalChoice.v 13323 2010-07-24 15:57:30Z herbelin $ i*)

(** This file axiomatizes the relational form of the axiom of choice *)

Axiom relational_choice :
  forall (A B : Type) (R : A->B->Prop),
   (forall x : A, exists y : B, R x y) ->
     exists R' : A->B->Prop,
       subrelation R' R /\ forall x : A, exists! y : B, R' x y.