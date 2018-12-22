open Commandpost

(*
node lib/js/example/usage.js -r -c a.json b.txt --config=c.json remote -v d add e.txt -- f.txt
*)

type root_options = {
  replace: bool;
  config: string array;
}

type root_args = RootArgs

let root: (root_options, root_args) Command.t =
  create "usg"
  |. Command.version ~version:"100.0.0" ~flags:"-v, --version"
  |. Command.description "foo bar"
  |. Command.option ~flags:"-r, replace" ~description:"replace files" ()
  |. Command.option ~flags:"--no-output" ~description:"silent mode" ()
  |. Command.option ~flags:"-c, --config <file>" ~description:"specified config file" ()
  |. Command.action (fun opts args rest ->
    Js.log "root action";
    Js.log opts;
    Js.log args;
    Js.log rest
  )

type remote_options = {
  verbose: bool;
}

type remote_args = {
  remote_url: string;
}

let remote: (remote_options, remote_args) Command.t =
  root
  |. Command.sub_command "remote <remoteUrl>"
  |. Command.description "about remote repos"
  |. Command.option ~flags:"-v, --verbose" ()
  |. Command.action (fun opts args rest ->
    Js.log "remote action";
    Js.log opts;
    Js.log args;
    Js.log rest
  )

type remote_add_options = RemoteAddOptions

type remote_add_args = {
  remote_urls: string array;
}

let add: (remote_add_options, remote_add_args) Command.t =
  let rec inner = lazy (
    remote
    |. Command.sub_command "add <remoteUrls...>"
    |. Command.help "-p, --pleh" "HELP MEEEEEEEEEE!!!!"
    |. Command.allow_unknown
    |. Command.action (fun opts args rest ->
      Command.exec remote
      |> Js.Promise.then_ (fun () ->
        Js.log "remote add action";
        Js.log opts;
        Js.log args;
        Js.log rest;
        Js.log3 "!root" (root |. Command.parsed_opts) (root |. Command.parsed_args);
        Js.log3 "!remote" (remote |. Command.parsed_opts) (remote |. Command.parsed_args);
        Js.log4 "!remote add" opts args rest;
        Js.log2 "!remote add unknown options" (Lazy.force inner |. Command.unknown_options);
        Js.Promise.resolve ()
      )
    )
  ) in
  Lazy.force inner;;

root
|. exec Sys.argv
|> Js.Promise.catch (fun e ->
  Js.log(e);
  Node.Process.exit 1;
  Js.Promise.resolve ()
);;
