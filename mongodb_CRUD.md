## Create And Use database

### Create

create database if not exists johnDB;
use johnDB;

use johnDB
If a database does not exist, MongoDB creates the database when you first store data for that database

### show a database with a specific name

```
show databases like 'johndb';
db.adminCommand({listDatabases: 1, nameOnly: true, filter: {name: 'dongguoDB'}}).databases
```

## Create a Collection (Table)

If a collection does not exist, MongoDB creates the collection when you first store data for that collection.

## List Collections

db.getCollectionInfos()
db.adminCommand( { listCollections: 1.0, nameOnly: true } )

## Query Filter Documents

db.map07.find({})
db.getCollection("listingsAndReviews").find({})

## Insert Multiple Documents

```
db.map07.insertOne({students : [{"name": "dongguo WU"}]})
```
