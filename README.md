# metaobject

This library is a lightweight implementation of the technique describe by Reginald Braithwaite in his book (Javascript Spessore)[https://leanpub.com/javascript-spessore]

## Overview
Metaobjects are an object creation pattern that allow the user to generate objects that either forward or delegate their methods to other objects

### forward(receiver={}, source={}, filter=[]/{})
This method will create methods on the receiver with the same name as the method on the source, but using the source as the context.
You can select a subset of the methods by providing an array of strings denoting the methods to be referenced.
You can alias the methods by providing an object, where the keys are the new names for the methods denoted by the values


### delegate(receiver={}, source={}, filter=[]/{})
This method will create methods on the receiver with the same name as the methods on the source, but using the receiver as the context.
You can select a subset of the methods by providing an array of strings denoting the methods to be referenced.
You can alias the methods by providing an object, where the keys are the new names for the methods denoted by the values
