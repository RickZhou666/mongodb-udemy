# mongodb-udemy

this is tutorial about mongodb from udemy

# 0 Tips

| Key                       | value                                                         |
| ------------------------- | ------------------------------------------------------------- |
| --fork                    | let mongo server run in deamon mode                           |
| default mongodb port      | 27017                                                         |
| $set:{}                   | $ reserve for operator                                        |
| $gt: 0                    | $ greater than                                                |
|                           | document order by \_id in ascending order                     |
| MongoDB drivers           | https://www.mongodb.com/docs/drivers/                         |
| MongoDB official tutorial | https://www.mongodb.com/docs/manual/tutorial/getting-started/ |

`mongodb shell cmds`

| Key      | value        |
| -------- | ------------ |
| cls      | clean screen |
| show dbs |              |

# 1 Intro

<br><br><br>

## 1.1 what is Mongodb?

![imgs](./imgs/image.png)

1. humongous - Because it can store lots and lots of data

2. How it works
   JSON(BSON - Binary version) Data format

```json
{
    "name": "Max",
    "age": 29,
    "address":
        {
            "city":"Minuch"
        },
    "hobbies"[
        {"name": "Cooking"},
        {"name": "Sports"}
    ]
}

```

3. BSON data structure. NoSQL

   (1) no Schema!

![imgs](./imgs/image1.png)

    (2) no/ few relations

![imgs](./imgs/image2.png)

4. MongoDB Ecosystem

![imgs](./imgs/image3.png)

<br><br><br>

## 1.2 Setup mongodb

[mongodb](https://www.mongodb.com/)

```bash
# (1) download community sever
https://www.mongodb.com/try/download/community

# (2) unzip
$ tar -zxvf mongodb-macos-x86_64-6.0.3.tgz

# (3) copy binaries into /usr/local/bin
$ sudo cp /Users/runzhou/git/mongodb-udemy/mongodb-macos-x86_64-6.0.3/bin/* /usr/local/bin

# (4) create symbolic linkx
$ sudo ln -s /Users/runzhou/git/mongodb-udemy/mongodb-macos-x86_64-6.0.3/bin/* /usr/local/bin

# (5) create data and logs folder
$ cd /Users/runzhou/git/mongodb-udemy
$ mkdir -p mongodb/data
$ mkdir -p mongodb/logs

# (6) link data and logs folder with mongod
$ mongod --dbpath /Users/runzhou/git/mongodb-udemy/mongodb/data --logpath /Users/runzhou/git/mongodb-udemy/mongodb/logs/mongo.log --fork

# (6) valid mongod server status
$ ps aux | grep -v grep | grep mongod

# (7) install mongosh
# https://www.mongodb.com/docs/mongodb-shell/install/#std-label-mdb-shell-install
$ brew install mongosh
# check mongodb port
$ netstat -nap tcp | grep -i "listen"

# (8) start mongo shell
$ mongosh
>> show dbs

# (9) you can connect with a non-default port
$ mongosh "mongodb://localhost:28015"
# OR
$ mongosh --port 28015

# (10) install mongodb-database-tools
# https://www.mongodb.com/docs/database-tools/installation/installation-macos/

# Tap the MongoDB formula
$ brew tap mongodb/brew
# install tools
$ brew install mongodb-database-tools
# upgrade tools
$ brew upgrade mongodb-database-tools
```

<br><br><br>

## 1.3 Get start with mongodb

```bash
# 1. switch db
$  use shop
>> switched to db shop

# 2. add new row
# for key you don't need add "", but you can keep it also
$ db.products.insertOne({name:"A Book", price: 12.99})
>>{
  acknowledged: true,
  insertedId: ObjectId("63c1001afb19689e8d76eeb3")
}


# 3. find row
# return all data in this collection
$ db.products.find()
>>[
  {
    _id: ObjectId("63c1001afb19689e8d76eeb3"),
    name: 'A Book',
    price: 12.99
  }
]

# 4. prettier
$ db.products.find().pretty()
>>[
  {
    _id: ObjectId("63c1001afb19689e8d76eeb3"),
    name: 'A Book',
    price: 12.99
  }
]


# 5. add another row
$ db.products.insertOne({
    "name": "Max",
    "age": 29,
    "address":
        {
            "city":"Minuch"
        },
    "hobbies":[
        {"name": "Cooking"},
        {"name": "Sports"}
    ]
})

```

## 1.4 mongodb drivers to different languages

[drivers](https://www.mongodb.com/docs/drivers/java-drivers/)

## 1.5 mongodb big picture

1. mongodb workflow

engine: WiredTiger
![imgs](./imgs/image4.png)

2. data layer

![imgs](./imgs/image5.png)

<br><br><br>

## 1.6 mongodb course outline

![imgs](./imgs/image6.png)

![imgs](./imgs/image7.png)

<br><br><br>

# 2. Basic & CRUD

1. Basics about collections & Documents
2. Basic Data types
3. Performing CRUD operations

<br><br><br>

## 2.1 Basic

![imgs](./imgs/image8.png)

### 2.1.1 Json data types

1. json type:
   array, object, string, number, boolean

2. JSON vs BSON

![imgs](./imgs/image9.png)

### 2.1.2 Interaction with mongodb

```bash
# 1. start mongodb
$ sudo mongod --fork
# start in different port
$ sudo mongod --port 27018 --fork

# 2. start mongo shell (if port is not default)
$ mongo --port 27018

# 3. mongodb CRUD offical doc
# https://www.mongodb.com/docs/manual/tutorial/insert-documents/

# 4. switch/creat db by `use`
# but no displayed if u dont insert data
$ use flights

# 5. insert document with collection name(equal to table in mysql)
$ db.flightData.insertOne({
    "departureAirport": "MUC",
    "arrivalAirport": "SFO",
    "aircraft": "Airbus A380",
    "distance": 12000,
    "intercontinental": true
    })

# 6. find data for this collections
$ db.flightData.find()

# 7. you can key without "", you can also add own _id but must be unique
$ db.flightData.insertOne({departureAirport: "TXL", arrivalAirport: "LHR"})

$ db.flightData.insertOne({departureAirport: "TXL", arrivalAirport: "LHR", _id:"xyz-001-k5n"})
# but you cannot add row with same _id
# MongoServerError: E11000 duplicate key error collection: flights.flightData index: _id_ dup key: { _id: "xyz-001-k5n" }

```

## 2.2 CRUD

<br><br><br>

### 2.2.1 CRUD operations & MongoDB

![imgs](./imgs/image10.png)
<br><br><br>

### 2.2.2 CRUD Operations

![imgs](./imgs/image11.png)

1. Create

```bash
insertOne(data, options)
insertMany(data, options)
```

2. Read

```bash
find(filter, options)
findOne(filter, options)
# get first data
```

3. Update

```bash
updateOne(filter, data, options)
updateMany(filter, data, options)
replaceOne(filter, data, options)
```

4. Delete

```bash
deleteOne(filter, options)
deleteMany(filter, options)
```

<br><br><br>

### 2.2.3 Finding, Inserting, Deleting & Updating Elements

![imgs](./imgs/image12.png)

```bash
# 1. insert Many
db.flightData.insertMany([
    {
        "departureAirport": "MUC",
        "arrivalAirport": "SFO",
        "aircraft": "Airbus A380",
        "distance": 12000,
        "intercontinental": true
    },
    {
        "departureAirport": "LHR",
        "arrivalAirport": "TXL",
        "aircraft": "Airbus A320",
        "distance": 950,
        "intercontinental": false
    }
])

# id will be in order
>>{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId("63c16d05bac11b5d1bfac792"),
    '1': ObjectId("63c16d05bac11b5d1bfac793")
  }
}

# 2. update one/ many
$ db.flightData.updateOne({distance: 12000}, {$set: {marker: "delete"}})
>>{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}

$ db.flightData.updateMany({}, {$set: {maker: "toDelete"}})
# this will change all data in flightData collection (the table)
>>{
  acknowledged: true,
  insertedId: null,
  matchedCount: 2,
  modifiedCount: 2,
}

# 3. delete one
$ db.flightData.deleteOne({departureAirport: "TXL"})
# delete the first data satisfy the condition


# 4. delete all
$ db.flightData.deleteMany({})
# filter is None, then every document matches, all will be deleted

# delete by filter(condition)
$ db.flightData.deleteMany({maker: "toDelete"})



# 5. Find data
# find document with filter
$ db.flightData.find({arrivalAirport: "SFO"})

# $gt greater than
$ db.flightData.find({distance: {$gt: 0}})


$ db.flightData.findOne({distance: {$gt: 900}})
# return the first matching element
>>{
  _id: ObjectId("63c16f2ebac11b5d1bfac794"),
  departureAirport: 'MUC',
  arrivalAirport: 'SFO',
  aircraft: 'Airbus A380',
  distance: 12000,
  intercontinental: true
}

# 6. update vs updateMany()
# update/ insert (if not exist) column delayed into _id =xxxx document
$ db.flightData.updateOne({_id: ObjectId("63c16f2ebac11b5d1bfac794")}, {$set: {delayed: true}})

# if no `$SET`, updateOne or updateMany  or update will fail. MUST ADD $set
flights> db.flightData.updateOne({_id: ObjectId("63c16f2ebac11b5d1bfac794")}, {delayed: true})
>> MongoInvalidArgumentError: Update document requires atomic operators
flights> db.flightData.updateMany({_id: ObjectId("63c16f2ebac11b5d1bfac794")}, {delayed: true})
>> MongoInvalidArgumentError: Update document requires atomic operators
flights> db.flightData.update({_id: ObjectId("63c16f2ebac11b5d1bfac794")}, {delayed: true})
MongoInvalidArgumentError: Update document requires atomic operators


# use replaceOne() to override document
$ db.flightData.replaceOne({_id: ObjectId("63c16f2ebac11b5d1bfac794")}, {delayed: true})

# before
  {
    _id: ObjectId("63c16f2ebac11b5d1bfac794"),
    departureAirport: 'MUC',
    arrivalAirport: 'SFO',
    aircraft: 'Airbus A380',
    distance: 12000,
    intercontinental: true,
    delayed: true
  }
# after
{ _id: ObjectId("63c16f2ebac11b5d1bfac794"), delayed: true }


# 7. find()
# return you a cusor when beyond 20 documents
$ db.passengers.find()


# return all your documents
$ db.passengers.find().toArray()

# forEach cmd. find each data one by one, not load them all
$ db.passengers.find().forEach((passengerData) => {printjson(passengerData)})
```

<br><br><br>

### 2.2.4 Projection

![imgs](./imgs/image13.png)

help filter some unecessary column

`0` excluded
`1` included

```bash
# included it in the data when u're returning to me
# _id is always included
$ db.passengers.find({}, {name: 1}).pretty()

# we can remove _id as well
$ db.passengers.find({}, {name: 1, _id: 0}).pretty()
```

<br><br><br>

### 2.2.5 Embedded Documents

![imgs](./imgs/image14.png)

<br><br><br>

#### 2.2.5.1 embeded documents

![imgs](./imgs/image15.png)

```bash
# embedded documents
$ db.flightData.updateMany({}, {$set: {status: {description: "on-time", lastUpdated: "1 hour ago"}}})
>>
[
  {
    _id: ObjectId("63c16f2ebac11b5d1bfac794"),
    departureAirport: 'MUC',
    arrivalAirport: 'SFO',
    aircraft: 'Airbus A380',
    distance: 12000,
    intercontinental: true,
    status: { description: 'on-time', lastUpdated: '1 hour ago' }
  },
  {
    _id: ObjectId("63c16f2ebac11b5d1bfac795"),
    departureAirport: 'LHR',
    arrivalAirport: 'TXL',
    aircraft: 'Airbus A320',
    distance: 950,
    intercontinental: false,
    status: { description: 'on-time', lastUpdated: '1 hour ago' }
  }
]

# easily to do update
$ db.flightData.updateMany({}, {$set: {status: {description: "on-time", lastUpdated: "1 hour ago", details: {responsible: "Rick Zhou"}}}})
>> [
  {
    _id: ObjectId("63c16f2ebac11b5d1bfac794"),
    departureAirport: 'MUC',
    arrivalAirport: 'SFO',
    aircraft: 'Airbus A380',
    distance: 12000,
    intercontinental: true,
    status: {
      description: 'on-time',
      lastUpdated: '1 hour ago',
      details: { responsible: 'Rick Zhou' }
    }
  },
  {
    _id: ObjectId("63c16f2ebac11b5d1bfac795"),
    departureAirport: 'LHR',
    arrivalAirport: 'TXL',
    aircraft: 'Airbus A320',
    distance: 950,
    intercontinental: false,
    status: {
      description: 'on-time',
      lastUpdated: '1 hour ago',
      details: { responsible: 'Rick Zhou' }
    }
  }
]
```

<br><br><br>

#### 2.2.5.2 array

```bash
$ db.passengers.updateOne({name: "Albert Twostone"}, {$set: {hobbies: ["sports", "cooking"]}})
>>
[
  {
    _id: ObjectId("63c174a2bac11b5d1bfac7a8"),
    name: 'Klaus Arber',
    age: 53
  },
  {
    _id: ObjectId("63c174a2bac11b5d1bfac7a9"),
    name: 'Albert Twostone',
    age: 68,
    hobbies: [ 'sports', 'cooking' ]
  }
]
```

<br><br><br>

#### 2.2.5.3 Accessing Structured Data

```bash
# findOne() to retrieve specific data
$ db.passengers.findOne({name: "Albert Twostone"}).hobbies

# find entire documents
$ db.passengers.find({hobbies: "sports"})


# if it's nested key
$ db.flightData.find({"status.description": "on-time"})
>>   {
    _id: ObjectId("63c16f2ebac11b5d1bfac795"),
    departureAirport: 'LHR',
    arrivalAirport: 'TXL',
    aircraft: 'Airbus A320',
    distance: 950,
    intercontinental: false,
    status: {
      description: 'on-time',
      lastUpdated: '1 hour ago',
      details: { responsible: 'Rick Zhou' }
    }
  }


$ db.flightData.find({"status.details.responsible": "Rick Zhou"})
```

<br><br><br>

## 2.3 Summary

![imgs](./imgs/)

<br><br><br>
