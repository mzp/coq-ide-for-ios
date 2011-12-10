(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* $Id: ideutils.ml 13751 2010-12-24 09:56:05Z letouzey $ *)
let flash_info ?delay _ = ()


(* Get back the standard coq out channels *)
let init_stdout,read_stdout,clear_stdout =
  let out_buff = Buffer.create 100 in
  let out_ft = Format.formatter_of_buffer out_buff in
  let deep_out_ft = Format.formatter_of_buffer out_buff in
  let _ = Pp_control.set_gp deep_out_ft Pp_control.deep_gp in
  (fun () ->
    Pp_control.std_ft := out_ft;
    Pp_control.err_ft := out_ft;
    Pp_control.deep_ft := deep_out_ft;
),
  (fun () -> Format.pp_print_flush out_ft ();
     let r = Buffer.contents out_buff in
     prerr_endline "Output from Coq is: "; prerr_endline r;
     Buffer.clear out_buff; r),
  (fun () ->
     Format.pp_print_flush out_ft (); Buffer.clear out_buff)


(*
  checks if two file names refer to the same (existing) file by
  comparing their device and inode.
  It seems that under Windows, inode is always 0, so we cannot
  accurately check if

*)
(* Optimised for partial application (in case many candidates must be
   compared to f1). *)
let same_file f1 =
  try
    let s1 = Unix.stat f1 in
    (fun f2 ->
      try
        let s2 = Unix.stat f2 in
        s1.Unix.st_dev = s2.Unix.st_dev &&
          if Sys.os_type = "Win32" then f1 = f2
          else s1.Unix.st_ino = s2.Unix.st_ino
      with
          Unix.Unix_error _ -> false)
  with
      Unix.Unix_error _ -> (fun _ -> false)


