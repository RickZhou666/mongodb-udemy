

# 1. one to one - Embedded
$ use hospital
$ db.patients.insertOne({name: "Rick", age: 29, diseaseSummary: "summary-rick-1"})


$ db.diseaseSummaries.insertOne({_id: "summary-rick-1", diseases: ["cold", "borken leg"]})

$ var dsid = db.patients.findOne().diseaseSummary

$ db.diseaseSummaries.findOne({_id: dsid})

$ db.diseaseSummaries.findOne({_id: db.patients.findOne().diseaseSummary})

$ db.patients.deleteMany({})

$ db.patients.insertOne({name: "Rick", age: 29, diseaseSummary: {diseases: ["cold", "borken leg"]}})


# 2. one to one - using reference
$ use carData

$ db.persons.insertOne({name: "Rick", car: {model: "BMW", price: 40000}})

$ db.persons.deleteMany({})

$ db.persons.insertOne({name: "Rick", age: 29, salary: 3000})

$ db.cars.insertOne({model: "BMW", price: 40000, owner: ObjectId("63c2c34a05122ca3240abd9b")})

# 3. one to many - embedded
$ use support
$ db.questionThreads.insertOne({creator: "Max", question: "How does that all work?", answers: ["q1a1", "q1a2"]})
$ db.answers.insertMany([{_id: "q1a1", text: "It works like that"}, {_id: "q1a2", text: "Thanks!"}])


$ db.questionThreads.deleteMany({})
$ db.questionThreads.insertOne({creator: "Rick", question: "How does that work?", answers: [{text: "Like that."}, {text: "Thanks!" }]})


# 4. one to many - using reference
$ use cityData
$ db.cities.insertOne({name: "New York City", coordinates: {lat: 21, log: 55}})

$ db.citizens.insertMany([{name: "Rick Zhou", cityId: ObjectId("63c2c86505122ca3240abd9f")}, {name: "Eve Baby", cityId: ObjectId("63c2c86505122ca3240abd9f")}])


# many to many - embedded
$ use shop
$ db. products.insertOne({title: "A book", price: 10.99})
$ db.customers.insertOne({name: "Rick", age: 25})
$ db.orders.insertOne({productId: ObjectId("63c2c9eb05122ca3240abda2"), customerId: ObjectId("63c2ca1e05122ca3240abda3")})


$ db.orders.drop()                                      # not real data but  metadata
$ db.customers.updateOne({}, {$set: {orders: [{productId: ObjectId("63c2c9eb05122ca3240abda2"), quatity: 2}]}})


$ db.customers.updateOne({}, {$set: {orders: [{title: "A book", price: 10.99, quantity: 2}]}})


# many to many - using reference
$ use bookRegistry
$ db.books.insertOne({name: "My favorite book", authors: [{name: "Rick Zhou", age: 25}, {name: "Eve Baby", age: 18}]})
$ db.authors.insertMany([{name: "Rick Zhou", age: 29, address: {street: "Main"}}, {name: "Eve Baby", age: 18, address: {street: "Forest"}}])


$ db.books.updateOne({}, {$set: {authors: [ObjectId("63c2cfc205122ca3240abda6"), ObjectId("63c2cfc205122ca3240abda7")]}})




# $lookUp()

## remvoe a field
$ db.books.updateOne({}, {$unset: {author: ""}})


db.books.aggregate([{$lookup: {from: "authors", localField: "authors", foreignField: "_id", as: "creators"}}])


# Example Exercise
$ db. users.insertMany([{name: "Rick Zhou", age: 25, email: "rickzhou@email.com"},{name: "Eve Baby", age: 18, email: "evebaby@email.com"}])

$ db.posts.insertOne({title: "My first Post!", description: "This is my first post, hope u like it!", tags: ["new", "tech"], creator: ObjectId("63c2d9e005122ca3240abda8"), comments: [{text: "I like this!", author: ObjectId("63c2d9e005122ca3240abda9")}] })