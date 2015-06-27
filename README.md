
Sepal in MoonScript
----

> Lua code in Cirru syntax.

### Development

Generate Lua code from Cirru:

```
moon test.moon
```

See how MoonScript AST looks:

```
cd moon-ast-viewer
moon parse.moon
```

### Example

Currently, given Cirru code:

```cirru
= a 1
= a true
= a false
= a nil
= a :str

= a $ table
  #value 1
  #pair :a 2

exp 1 + 2 + 3

fn (x y)
  exp x + 1
  exp y + 2
```

produces MoonScript AST and Lua code:

```
➤➤ moon test.moon
[["assign",[["ref","a"]],[["number","1"]]],["assign",[["ref","a"]],[["ref","true"]]],["assign",[["ref","a"]],[["ref","false"]]],["assign",[["ref","a"]],[["ref","nil"]]],["assign",[["ref","a"]],[["string","\"","str"]]],["assign",[["ref","a"]],[["table",[[["number","1"]],[["string","\"","a"],["number","2"]]]]]],["exp",["number","1"],"+",["number","2"],"+",["number","3"]],["fndef",[["x"],["y"]],[],"slim",[["exp",["ref","x"],"+",["number","1"]],["exp",["ref","y"],"+",["number","2"]]]]]

local a = 1
a = true
a = false
a = nil
a = "str"
a = {
  1,
  ["a"] = 2
}
local _ = 1 + 2 + 3
return function(x, y)
  _ = x + 1
  return y + 2
end
```

### License

MIT
