# 1. insert 3 patient records with at least 1 history entry per patient
$ switch hospital

$ db.patient.insertMany(
[
    {
        firstName: "Max",
        lastName: "Schwaz",
        age: 29,
        history: 
        [
            {
                disease: "cold",
                treatment: "Acetaminophen"
            },
            {
                disease: "diarrhea",
                treatment: "Loperamide"
            },
                        {
                disease: "diabetes",
                treatment: "insulin"
            },
        ]
    },
    {
        firstName: "Curry",
        lastName: "Downen",
        age: 45,
        history: 
        [
            {
                disease: "diarrhea",
                treatment: "Loperamide"
            },
                        {
                disease: "diabetes",
                treatment: "insulin"
            },
        ]
    },
    {
        firstName: "Hilary",
        lastName: "Jesus",
        age: 13,
        history: 
        [
            {
                disease: "cold",
                treatment: "Ibuprofen"
            },
            {
                disease: "diabetes",
                treatment: "insulin"
            },
        ]
    }
])


# 2. Update patient data of 1 patient with new age, name and history entry
$ db.patient.updateOne({_id: ObjectId("63c182bebac11b5d1bfac7ab")}, {$set: {age: 22}})

# 3. Find all patients who are older than 20
$ db.patient.find({age: {$gt: 20}})

# 4. Delete all patients who got a cold as a disease
$ db.patient.deleteMany({"history.disease": "cold"})