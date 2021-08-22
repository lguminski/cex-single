defmodule MyTypes do
  use CyberOS.DSL, version: 1.0
  type MySQL, implements: VersionedType
  type HTTP
end
