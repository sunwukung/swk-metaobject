t = require "swk-types"

methods = (host, filter = []) ->
  props = if filter.length > 0 then filter else keys host
  fns = {}
  for prop in props
    if t.is("function", host[prop]) and host.hasOwnProperty(prop) then fns[prop] = host[prop]
  fns


invert =  (obj) ->
  inverted = {}
  for prop of obj
    if obj.hasOwnProperty prop
      key = obj[prop]
      inverted[key] = prop
  inverted

values = (obj) ->
  vals = []
  for prop of obj
    if obj.hasOwnProperty prop
      vals.push obj[prop]
  vals

keys = (obj) ->
  kys = []
  for key, prop of obj
    kys.push key
  kys

module.exports =
  keys: keys
  values: values
  methods: methods
  invert: invert
