
parser = require 'cirru-parser'
compile = require 'moonscript.compile'
transform = require 'src/transform'
inspect = require 'inspect'
JSON = require "JSON"

file = io.open 'examples/demo.cirru', 'rb'
content = file\read '*all'
file\close()

tree = parser.pare content

expandedTree = transform tree
print JSON\encode expandedTree

print ''

print (compile.tree expandedTree)
