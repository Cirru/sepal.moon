
parse = require "moonscript.parse"
compile = require "moonscript.compile"
inspect = require "inspect"
JSON = require 'JSON'

file = io.open 'code.moon', 'rb'
content = file\read '*all'
file\close!

tree, err = parse.string content

pure = (tree) ->
  if (type tree) == 'table'
    result = {}
    for key, value in pairs tree
      if key > 0
        result[key] = pure value
    result
  else
    tree

tree = pure tree

print (JSON\encode tree)

lua_code, err, pos = compile.tree tree

print lua_code
