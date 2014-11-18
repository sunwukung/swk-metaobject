###
helper functions to assist main library
###
t = require "swk-types"


###
extract methods from host
if a filter array is supplied then it extracts the listed methods
###
methods = (host, filter = []) ->
  props = if filter.length > 0 then filter else keys host
  fns = {}
  for prop in props
    if t.is("function", host[prop]) and host.hasOwnProperty(prop) then fns[prop] = host[prop]
  fns


# returns a new object generated from inverting the key:value pairs of the original
invert =  (obj) ->
  inverted = {}
  for prop of obj
    if obj.hasOwnProperty prop
      key = obj[prop]
      inverted[key] = prop
  inverted


# return an array of all the values in an object
values = (obj) ->
  vals = []
  for prop of obj
    if obj.hasOwnProperty prop
      vals.push obj[prop]
  vals


# return an array of all the keys in the object
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
