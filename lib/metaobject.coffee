###
this library provides a means to create objects that proxy other objects
this can be used as an alternative to traditional inheritance patterns
###
t = require "swk-types"
{methods, keys, values, invert} = require "./helpers"


###
returns a function partially applied to the given context
###
bindMethodContext = (method, receiver, source, context) ->
  (args...) ->
    ret = method.apply context, args
    if (source is context) and (ret is source)
      ret = receiver
    ret


###
extracts methods from source and assigns them to receiver

receiver: the object that will be returned
source  : the object that the methods are copied from
filter  : subset of methods to copy
context : the context the methods will be applied to
###
bindMethods = (receiver, source, filter, context) ->
  methodFilter = if t.is "array", filter then filter else values filter
  extractedMethods = methods source, methodFilter

  if (t.is "object", filter) and not (t.is "array", filter) then methodMap = invert filter else null

  for name, method of extractedMethods
    if t.is "object", methodMap then name = methodMap[name]
    receiver[name] = bindMethodContext method, receiver, source, context
  receiver


module.exports =

  forward: (receiver, source, filter) ->
    bindMethods receiver, source, filter, source

  delegate: (receiver, source, filter) ->
    bindMethods receiver, source, filter, receiver
