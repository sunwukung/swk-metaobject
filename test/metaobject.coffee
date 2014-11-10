expect = require("chai").expect
sinon = require "sinon"
metaobject = require "../lib/metaobject"
source =
  doThis: ->
  doThat: ->

doThisSpy = sinon.spy source, 'doThis'
doThatSpy = sinon.spy source, 'doThat'

describe.only "metaobject", ->

  it "is an object", ->

    expect(metaobject).to.be.an "object"

  describe "methods", ->

    describe "forwardMethods", ->
      it "is a function", ->
        expect(metaobject.forwardMethods).to.be.a "function"

      it "creates an object", ->
        expect(metaobject.forwardMethods()).to.be.an "object"

    describe "delegateMethods", ->
      it "is a function", ->
        v = metaobject.delegateMethods({}, source)
        console.log v
        expect(metaobject.delegateMethods({}, source)).to.be.a "function"

