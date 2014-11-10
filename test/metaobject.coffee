expect = require("chai").expect
sinon = require "sinon"
metaobject = require "../lib/metaobject"

describe.only "metaobject", ->

  it "is an object", ->

    expect(metaobject).to.be.an "object"

  describe "methods", ->

    describe "forwardMethods", ->
      it "is a function", ->
        expect(metaobject.forwardMethods).to.be.a "function"

    describe "delegateMethods", ->
      it "is a function", ->
        expect(metaobject.delegateMethods).to.be.a "function"

