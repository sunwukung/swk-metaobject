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
  methodFilter = if _.isArray filter then filter else _.values filter
  extractedMethods = getMethods source, methodFilter

  if (_.isObject filter) and not (_.isArray filter) then methodMap = _.invert filter else null

  _.each extractedMethods, (method, name) ->
    if _.isObject methodMap then name = methodMap[name]
    receiver[name] = bindMethodContext(method, context)
  receiver


module.exports =

  mix: (receiver, source, filter) ->
    _.extend receiver, getMethods(source, filter)

  forward: (receiver, source, filter) ->
    bindMethods receiver, source, filter, source

  delegate: (receiver, source, filter) ->
    bindMethods receiver, source, filter, receiver
