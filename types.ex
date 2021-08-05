defmodule MyTypes do
  use CyberOS.DSL, version: 1.0
  type MySQL, kind: VersionedType
  type HTTP
end
