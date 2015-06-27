
-- array utils

each = (list, fn) ->
  for key, value in pairs list
    fn value, key

map = (list, fn) ->
  result = {}
  each list, (value, key) ->
    result[key] = fn value, key
  result

size = (list) ->
  count = 0
  each list, -> count += 1
  count

isEmpty = (list) ->
  (size list) == 0

tail = (list) ->
  result = {}
  each list, (value, key) ->
    if key > 1 then result[key - 1] = value
  result

prepend = (item, list) ->
  result = {item}
  each list, (value, key) ->
    result[key + 1] = value
  result

-- transformer

operations = nil

transform = (expr) ->
  if (type expr) == 'string'
    if string.match expr, '^[0-9\\.]+$'
      return {'number', expr}
    if (string.sub expr, 1, 1) == ':'
      return {'string', '"', (string.sub expr, 2)}
    if expr == 'nil'
      return {'ref', 'nil'}
    if expr == 'true'
      return {'ref', 'true'}
    if expr == 'false'
      return {'ref', 'false'}
    if expr == '+'
      return '+'
    return {'ref', expr}
  else
    op = expr[1]
    args = tail expr
    fn = operations[op]
    if fn
      fn args
    else
      error ('found no op: ' .. op)

operations = {
  ['=']: (args) ->
    name = args[1]
    value = args[2]
    {'assign', {{'ref', name}}, {(transform value)}}

  ['table']: (args) ->
    {'table', (map args, transform)}

  ['#pair']: (args) ->
    map args, transform

  ['#value']: (args) ->
    single = args[1]
    {transform single}

  ['exp']: (args) ->
    prepend 'exp', (map args, transform)

  ['fn']: (args) ->
    params = map args[1], (x) -> {x}
    body = map (tail args), transform
    {'fndef', params, {}, 'slim', body}
}

-- export function

transformPorgram = (program) ->
  map program, transform

return transformPorgram
