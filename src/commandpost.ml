module Command = struct
  type ('a, 'b) t

  external description: ('a, 'b) t -> string -> ('a, 'b) t = "" [@@bs.send]
  external usage: ('a, 'b) t -> string -> ('a, 'b) t = "" [@@bs.send]
  external option: ('a, 'b) t -> flags:string -> ?description:string -> ?default_value:'c -> unit -> ('a, 'b) t = "option" [@@bs.send]
  external allow_unknown_option: ('a, 'b) t -> flag:bool -> ('a, 'b) t = "allowUnknownOption" [@@bs.send]
  external allow_unknown: ('a, 'b) t -> ('a, 'b) t = "allowUnknownOption" [@@bs.send]
  external action: ('a, 'b) t -> ('a -> 'b -> string array -> 'c) -> ('a, 'b) t = "" [@@bs.send]
  external is: ('a, 'b) t -> string -> bool = "" [@@bs.send]
  external help: ('a, 'b) t -> string -> string -> ('a, 'b) t = "" [@@bs.send]
  external version: ('a, 'b) t -> version:string -> flags:string -> ('a, 'b) t = "" [@@bs.send]
  external version_with_description: ('a, 'b) t -> version:string -> flags:string -> description:string -> ('a, 'b) t = "version" [@@bs.send]
  external exec: ('a, 'b) t -> unit Js.Promise.t = "" [@@bs.send]
  external parse: ('a, 'b) t -> string array -> unit Js.Promise.t = "" [@@bs.send]
  external sub_command: ('a, 'b) t -> string -> ('c, 'd) t = "subCommand" [@@bs.send]

  external parsed_opts: ('a, 'b) t -> 'a = "parsedOpts" [@@bs.get]
  external parsed_args: ('a, 'b) t -> 'b = "parsedArgs" [@@bs.get]
  external unknown_options: ('a, 'b) t -> string array = "unknownOptions" [@@bs.get]
end

external create: string -> ('a, 'b) Command.t = "Command" [@@bs.new] [@@bs.module "commandpost"]
external exec: ('a, 'b) Command.t -> string array -> unit Js.Promise.t = "" [@@bs.val] [@@bs.module "commandpost"]
