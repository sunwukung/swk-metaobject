_ = require "lodash"
###
this library provides a means to create objects that proxy other objects
this can be used as an alternative to traditional inheritance patterns
###
getMethods = (host, filter = []) ->
  props = if filter.length > 0 then filter else _.keys host
  methods = {}
  _.each(props, (prop) ->
    if _.isFunction(host[prop]) and host.hasOwnProperty(prop) then methods[prop] = host[prop]
  )
  methods

###
returns a function partially applied to the given context
###
bindMethodContext = (method, context) ->
  (args...) ->
    method.apply context, args

###
extracts methods from source and assigns them to receiver

receiver: the object that will be returned
source  : the object that the methods are copied from
filter  : subset of methods to copy
context : the context the methods will be applied to
###
bindMethods = (receiver, source, filter, context) ->
  extractedMethods = getMethods source, filter
  _.each extractedMethods, (method, name) ->
    receiver[name] = bindMethodContext(method, context)
  receiver


module.exports =

  mix: (receiver, source, filter = []) ->
    _.extend receiver, getMethods(source, filter)

  forwardMethods: (receiver, source, filter = []) ->
    bindMethods receiver, source, filter, source

  delegateMethods: (receiver, source, filter = []) ->
    bindMethods receiver, source, filter, receiver
