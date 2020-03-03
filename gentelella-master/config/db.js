const fs = require('fs');
var mysql = require('mysql');
const dbconfig = JSON.parse(fs.readFileSync('./config/dbconfig.json', 'utf8'));
var connection = mysql.createPool({
    host: dbconfig.host,
    user: dbconfig.user,
    password: dbconfig.password,
    database: dbconfig.schema,
    multipleStatements: true,
    connectionLimit: 30
});


module.exports = connection;
