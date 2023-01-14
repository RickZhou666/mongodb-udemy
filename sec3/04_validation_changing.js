db.runCommand({
    collMod: "posts",
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["title", "description", "creator", "comments"],
            properties: {
                title: {
                    bsonType: "string",
                    description: "must be a string and is required"
                },
                description: {
                    bsonType: "string",
                    description: "must be a string and is required"
                },
                creator: {
                    bsonType: "objectId",
                    description: "must be a objectId and is required"
                },
                comments: {
                    bsonType: "array",
                    description: "must be a array and is required",
                    items: {
                        bsonType: "object",
                        required: ["text", "author"],
                        properties: {
                            text: {
                                bsonType: "string",
                                description: "must be a string and is required"
                            },
                            author: {
                                bsonType: "objectId",
                                description: "must be a objectId and is required"
                            }
                        }
                    }
                }
            }
        }
    },
    validationAction: "warn"
});

db.posts.insertOne({ title: "My first Post!", description: "This is my first post, hope u like it!", tags: ["new", "tech"], creator: ObjectId("63c2d9e005122ca3240abda8"), comments: [{ text: "I like this!", author: 12 }] })