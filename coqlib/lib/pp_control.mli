(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: pp_control.mli 13323 2010-07-24 15:57:30Z herbelin $ i*)

(* Parameters of pretty-printing. *)

type pp_global_params = {
  margin : int;
  max_indent : int;
  max_depth : int;
  ellipsis : string }

val dflt_gp : pp_global_params
val deep_gp : pp_global_params
val set_gp : Format.formatter -> pp_global_params -> unit
val set_dflt_gp : Format.formatter -> unit
val get_gp : Format.formatter -> pp_global_params


(*s Output functions of pretty-printing. *)

type 'a pp_formatter_params = {
  fp_output : out_channel;
  fp_output_function : string -> int -> int -> unit;
  fp_flush_function : unit -> unit }

val std_fp : (int*string) pp_formatter_params
val err_fp : (int*string) pp_formatter_params

val with_fp : 'a pp_formatter_params -> Format.formatter
val with_output_to : out_channel -> Format.formatter

val std_ft : Format.formatter ref
val err_ft : Format.formatter ref
val deep_ft : Format.formatter ref

(*s For parametrization through vernacular. *)

val set_depth_boxes : int option -> unit
val get_depth_boxes : unit -> int option

val set_margin : int option -> unit
val get_margin : unit -> int option
