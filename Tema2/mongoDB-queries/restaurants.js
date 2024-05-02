use ('restaurants');
//1
db.getCollection('restaurants').find();
//2
db.getCollection('restaurants').find({},{restaurant_id: 1,name: 1, borough: 1, cuisine: 1});
//3
db.getCollection('restaurants').find({},{restaurant_id: 1,name: 1,  _id: 0, borough: 1, cuisine: 1});
//4
db.getCollection('restaurants').find({},{restaurant_id: 1, name:1, borough: 1, 'address.zipcode': 1, _id: 0 });
//5
db.getCollection('restaurants').find({borough: 'Bronx'});
//6
db.getCollection('restaurants').find({borough: 'Bronx'}).limit(5);
//7
db.getCollection('restaurants').find({borough: 'Bronx'}).limit(5).skip(5);
//8
db.getCollection('restaurants').find({'grades.score': {$gt: 90 }});
//9
db.getCollection('restaurants').find({'grades.score': {$gt: 80, $lt: 100 }});
//10
db.getCollection('restaurants').find({'address.coord.0': {$gt: -95.754168 }});
//11
db.getCollection('restaurants').find({$and: [{cuisine: {$ne:'American '} }, {'grades.score': { $gt: 70 } },{ 'address.coord.1': { $lt: -65.754168 }}]});
//12
db.getCollection('restaurants').find({cuisine: { $ne:'American '},'grades.score': {$gt: 70 },'address.coord.0': { $lt: -65.754168 }});
//13
db.getCollection('restaurants').find({cuisine: { $ne:'American '},'grades.grade': 'A', borough: {$ne: 'Brooklyn' }}).sort({ cuisine: -1 });
//14
db.getCollection('restaurants').find({name: {$regex: RegExp('^Wil') } },{restaurant_id: 1, name: 1, borough: 1, cuisine: 1});
//15
db.getCollection('restaurants').find({name: {$regex: /ces$/ }}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1});
//16
db.getCollection('restaurants').find({name: {$regex: /Reg/ }}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
//17
db.getCollection('restaurants').find({borough: 'Bronx', cuisine: { $in:['American ', 'Chinese'] }});
//18
db.getCollection('restaurants').find({borough: {$in: [ 'Staten Island', 'Queens', 'Bronx', 'Brooklyn' ] } }, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1});
