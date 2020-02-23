var mysql = require('mysql');
var dbconfig = require('./dbconfig.json')

var connection = mysql.createPool({
    host: dbconfig.host,
    user: dbconfig.user,
    password: dbconfig.password,
    database: dbconfig.schema,
    multipleStatements: true,
    connectionLimit: 30
});


module.exports = connection;
