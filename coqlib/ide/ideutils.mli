(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)


val read_stdout : unit -> string
val flash_info : ?delay:int -> string -> unit

(*
  checks if two file names refer to the same (existing) file
*)

val same_file : string -> string -> bool

