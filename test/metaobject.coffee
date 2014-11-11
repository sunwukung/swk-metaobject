expect = require("chai").expect
sinon = require "sinon"
metaobject = require "../lib/metaobject"
source =
  property: "foo"
  doThis: -> @property
  doThat: -> @property

doThisSpy = sinon.spy source, 'doThis'
doThatSpy = sinon.spy source, 'doThat'

describe.only "metaobject", ->

  it "is an object", ->

    expect(metaobject).to.be.an "object"

  describe "methods", ->

    describe "forward", ->
      it "is a function", ->
        expect(metaobject.forward).to.be.a "function"

      it "returns the receiver object", ->
        receiver = {}
        forwarded = metaobject.forward receiver, source
        expect(forwarded).to.be.an "object"
        expect(forwarded).to.equal receiver

      it "with all the methods of the source object", ->
        receiver = {}
        forwarded = metaobject.forward receiver, source
        expect(forwarded.doThis).to.be.a "function"
        expect(forwarded.doThat).to.be.a "function"

      it "calls the methods in the source scope", ->
        receiver = {}
        forwarded = metaobject.forward receiver, source
        expect(forwarded.doThis()).to.equal "foo"
        expect(forwarded.doThat()).to.equal "foo"

      it "if given an array of method names, will only copy those methods", ->
        receiver = {}
        forwarded = metaobject.forward receiver, source, ['doThis']
        expect(forwarded.doThis).to.be.a "function"
        expect(forwarded.doThat).to.equal undefined

      it "if given an object will use the keys as aliases for the methods described by the values", ->
        receiver = {}
        forwarded = metaobject.forward receiver, source, { executeThis: 'doThis' }
        expect(forwarded.executeThis).to.be.a "function"


    describe "delegate", ->
      it "is a function", ->
        expect(metaobject.delegate).to.be.a "function"

      it "returns the receiver object", ->
        receiver = {}
        delegated = metaobject.delegate receiver, source
        expect(delegated).to.be.an "object"
        expect(delegated).to.equal receiver


      it "with all the methods of the source object", ->
        receiver = {}
        delegated = metaobject.delegate receiver, source
        expect(delegated.doThis).to.be.a "function"
        expect(delegated.doThat).to.be.a "function"

      it "calls the methods in the source scope", ->
        receiver = { property: "bar" }
        delegated = metaobject.delegate receiver, source
        expect(delegated.doThis()).to.equal "bar"
        expect(delegated.doThat()).to.equal "bar"

      it "if given an array of method names, will only copy those methods", ->
        receiver = {}
        delegated = metaobject.delegate receiver, source, ['doThis']
        expect(delegated.doThis).to.be.a "function"
        expect(delegated.doThat).to.equal undefined

      it "if given an object will use the keys as aliases for the methods described by the values", ->
        receiver = {}
        delegated = metaobject.delegate receiver, source, { executeThis: 'doThis' }
        expect(delegated.executeThis).to.be.a "function"
