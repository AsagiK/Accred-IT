const express = require('express');
const fileUpload = require('express-fileupload');
const server = express();
const fs = require('fs');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const md5 = require('md5');
const async = require("async");
var mysql = require('mysql');
var connection = require('../config/db');
// ---- URL PARSER
var url = require('url');
var session = require('express-session');
var Notif = require('../controllers/NotifController');
// ---- DEFINE SESSION
server.use(session({
    secret: 'ssshhhhh',
    resave: false,
    saveUninitialized: true
}));

const bcrypt = require('bcrypt');
const saltRounds = 10;
// ----
var sess;

module.exports = {

    Viewusers: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("SELECT users.User_ID, users.User_First, users.Role, users.User_Last, users.username, users.email_address, group.Group_Name, area.Area_Name, roles.Role_Name, users.ContactNo FROM capstone.users join capstone.group on users.Group=group.Group_ID join capstone.roles on users.Role = roles.Role_ID join capstone.area on group.Area_ID = area.Area_ID; SELECT users.Role, users.User_ID, users.User_First, users.User_Last, users.username, users.email_address, users.ContactNo FROM capstone.users where users.Group IS NULL; Select users.User_ID from capstone.users", function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/Viewusers.ejs', {
                    data: results[0],
                    dataB: results[1],
                    current_user: sess.user
                });
                console.log(sess.user);
            });
            console.log("Viewusers");
        }
    },

    Createusers: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {


            connection.query("SELECT * FROM capstone.roles where Role_ID > 1; Select users.User_ID from capstone.users;", function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/CreateUser.ejs', {
                    data: results[0],
                    dataB: results[1],
                    current_user: sess.user
                });
                console.log(results)
            });
        }


    },

    ViewGroups: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var alert = req.query.passdata;
            var passData
            if (alert) {
                if (alert == 0) {
                    passData = {
                        goodStatus: 0,
                        msg: "User/s not added"
                    }
                } else if (alert == 1) {
                    passData = {
                        goodStatus: 1,
                        msg: "User/s added"
                    }
                } else if (alert == 2) {
                    passData = {
                        goodStatus: 1,
                        msg: "User/s Removed"
                    }
                }
            }
            connection.query("Select * From (Select area.Area_ID, area.Area_Name, count(group.group_ID) as GroupCount from area left join capstone.`group` on area.Area_ID = group.Area_ID group by area.Area_ID) as A Join (SELECT group.Group_ID, group.Area_ID, count(users.Group) as UserCount FROM capstone.`group` left join capstone.users on group.Group_ID = users.Group where area_ID > 0 group by area_ID ) as B on A.Area_ID = B.Area_ID; SELECT group.Group_ID, group.Area_ID, group.Group_Name, count(users.Group) as UserCount FROM capstone.`group` left join capstone.users on group.Group_ID = users.Group group by group_ID; SELECT users.User_ID, users.User_First, users.User_Last, users.email_address, users.Role, users.Group, users.ContactNo, users.username, roles.Role_Name, groupdetails.Groupdetails_Position FROM capstone.users join capstone.roles on users.Role = roles.Role_ID join capstone.groupdetails on groupdetails.Groupdetails_ID = users.Group && users.User_ID = groupdetails.Groupdetails_UserID", function (err, results, fields) {
                if (err) throw err;

                resp.render('./pages/ViewGroups.ejs', {
                    dataA: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    current_user: sess.user,
                    notif: passData
                });
                console.log(results);
            });
            console.log("ViewGroups");
        }
    },

    CreateGroup: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("SELECT * FROM capstone.area;", function (err, result, fields) {
                if (err) throw err;
                resp.render('./pages/CreateGroup.ejs', {
                    data: result,
                    current_user: sess.user
                });
            });
            console.log("CreateGroup");
        }
    },

    Comparativeanalysis: function (req, resp) {
        resp.render('./pages/ComparativeAnalysisAreaSelection.ejs');
        console.log("Comparativeanalysis");
    },

    Comparativeanalysis2: function (req, resp) {
        resp.render('./pages/Comparativeanalysis.ejs');
        console.log("Comparativeanalysis2");
    },

    addgroup: function (req, resp) {
        var gn = (req.body.GroupName);
        var sa = (req.body.SelectArea);
        var gd = (req.body.GroupDesc);
        var sql = "INSERT INTO `capstone`.`group` (`Group_Name`, `Area_ID`) VALUES (? , ?)";
        var values = [gn, sa];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");

            var today = new Date();
                var current = today.toISOString().split('T')[0];
                var notifobject = {
                    "body": "Group: " + gn + " ,has been made", //message body, cannot be null
                    "sender": sess.user[0].User_ID, //ID of sender taken from req session
                    "receiver": "0", //ID of receiver, in this case the user that was created
                    "group": sess.user[0].Group, //Group ID taken from req session
                    "range": "3", //range of notification, refer to the JSONcontroller
                    "admin": "1", // 0 if admin does not need to be notified, else 1
                    "sysadmin": "1", // same as above
                    "triggerdate": current //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                }
                Notif.CreateNotif(notifobject);


        });
        resp.redirect('/CreateGroup');
    },

    adduser: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        console.log(req.body);
        var fn = (req.body.firstname);
        var ln = (req.body.lastname);
        var pass = (req.body.password);
        var em = (req.body.email);
        var rl = (req.body.role);
        var co = (req.body.contact);
        var count = parseInt(req.body.count) + 1;
        var un = fn + ln + count;
        console.log(un);
        bcrypt.hash(pass, saltRounds, function (err, hash) {
            var sql = "INSERT INTO `capstone`.`users` (`User_First`, `User_Last`, `email_address` , `Role`, `ContactNo`, `username`, `passwd`) VALUES (?, ?, ?, ?, ?, ?, ?)";
            var values = [fn, ln, em, rl, co, un, hash];
            connection.query(sql, values, function (err, result) {
                if (err) throw err;

                //working example derived from the sample at jsoncontroller         
                var today = new Date();
                var current = today.toISOString().split('T')[0];
                var notifobject = {
                    "body": "User " + fn + " " + ln + " has been created", //message body, cannot be null
                    "sender": sess.user[0].User_ID, //ID of sender taken from req session
                    "receiver": result.insertId, //ID of receiver, in this case the user that was created
                    "group": sess.user[0].Group, //Group ID taken from req session
                    "range": "1", //range of notification, refer to the JSONcontroller
                    "admin": "1", // 0 if admin does not need to be notified, else 1
                    "sysadmin": "1", // same as above
                    "triggerdate": current //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                }
                Notif.CreateNotif(notifobject);

                console.log("Record Inserted");
            });
            resp.redirect('/Createusers');
        });
    },

    edituser: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var id = (req.query.UID);
            console.log(id);
            var values = [id];
            connection.query("SELECT * FROM capstone.users where users.User_ID = (?); SELECT * FROM capstone.roles where Role_ID > 1;", values, function (err, results) {
                if (err) throw err;
                console.log(results);
                resp.render('./pages/EditUser.ejs', {
                    data: results[0],
                    dataB: results[1],
                    current_user: sess.user
                })
            });
        }
    },

    alteruser: function (req, resp) {
        var id = (req.body.UID);
        var fn = (req.body.firstname);
        var ln = (req.body.lastname);
        var em = (req.body.email);
        var rl = (req.body.role);
        var co = (req.body.contact);
        console.log(id);
        console.log(fn);
        console.log(ln);
        console.log(em);
        console.log(rl);
        console.log(co);
        var sql = "Update capstone.users set User_First = ?, User_Last = ?, email_address = ?, Role = ?, ContactNo = ? where User_ID = ? ";
        var values = [fn, ln, em, rl, co, id];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            if (result) {
                resp.redirect('/Viewusers');
            }
        });
    },

    TestPage: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var id = (req.query.UID);
            console.log(id);
            var values = [id];
            connection.query("SELECT * FROM capstone.approved_activities where approved_activities.activity_ID=26; SELECT * FROM capstone.documents; SELECT * FROM capstone.activity_outputs;", values, function (err, results) {
                if (err) throw err;
                if (results) {
                    console.log(results);
                    resp.render('./pages/TestPage.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        current_user: sess.user
                    })
                }
            });
            console.log("TESTING PAGE FOR BRIAN");
        }
    },

    SendMeasurement: function (req, resp) {
        var qt = req.body.QualityTarget;
        var mn = req.body.MeasurementName;
        var md = req.body.MeasurementDesc;
        var gid = req.body.GoalID;
        var sql = "INSERT INTO `capstone`.`measurement` (`QualityTarget`,`measurement_Name`,`measurement_Description`, `metric_ID`) VALUES (? , ?, ?, ?)";
        var values = [qt, mn, md, gid];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            resp.redirect('/QualityMetric');
        });
        console.log("INSERTED MEASUREMENT");
    },

    Measurement: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var alert = req.query.passdata;
            var passData;
            if (alert) {
                if (alert == 0) {
                    passData = {
                        goodStatus: 0,
                        msg: "User/s not added"
                    }
                } else {
                    passData = {
                        goodStatus: 1,
                        msg: "User/s added"
                    }
                }
            }
            var MID = req.query.MID;
            console.log(MID);
            var sql = "Select measurement.measurement_ID, measurement.measurement_Name, measurement.measurement_Description, measurement.GroupAssigned, group.Group_Name, measurement.Deadline FROM capstone.measurement join capstone.group on measurement.GroupAssigned = group.Group_ID where metric_ID = ?; Select metric.metric_ID, metric.group_ID, metric.metric_Name from capstone.metric where metric_ID = ?;"
            var values = [MID, MID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    resp.render('./pages/MeasurementPage.ejs', {
                        data: results[0],
                        dataB: results[1],
                        notif: passData,
                        current_user: sess.user
                    });
                }
                console.log(results);
            });
        }
    },

    QualityMetric: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var alert = req.query.passdata;
            var passData
            if (alert) {
                if (alert == 0) {
                    passData = {
                        goodStatus: 0,
                        msg: "Measurement Not Created"
                    }
                } else if (alert == 1) {
                    passData = {
                        goodStatus: 1,
                        msg: "Measurement Created"
                    }
                } else if (alert == 2) {
                    passData = {
                        goodStatus: 1,
                        msg: "Measurement Not Edited"
                    }
                } else {
                    passData = {
                        goodStatus: 1,
                        msg: "Measurement Edited"
                    }
                }
            }
            connection.query("SELECT * FROM capstone.metric; SELECT * FROM capstone.source; SELECT * FROM capstone.group; SELECT * FROM capstone.cycle ORDER BY termnum ASC; SELECT * FROM capstone.measurement; SELECT * FROM capstone.measurements_targets; SELECT * FROM capstone.sourcetype; SELECT * FROM capstone.source; SELECT * FROM capstone.measurement_audit; SELECT * FROM capstone.measurements_targets_audit; SELECT cycle.cycle_ID, count(measurement.measurement_ID) as MeasurementCount FROM capstone.`cycle` left join capstone.`measurement` on cycle.cycle_ID = measurement.cycle_ID group by cycle.cycle_ID; SELECT measurement.measurement_ID, measurement.measurement_Name, count(measurements_activities.activity_ID) as ActivityCount FROM capstone.`measurement` left join capstone.`measurements_activities` on measurement.measurement_ID = measurements_activities.measurement_ID group by measurement.measurement_ID;", function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    resp.render('./pages/QualityMetrics.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataD: results[3],
                        dataE: results[4],
                        dataF: results[5],
                        dataG: results[6],
                        dataH: results[7],
                        dataI: results[8],
                        dataJ: results[9],
                        dataK: results[10],
                        dataL: results[11],
                        current_user: sess.user,
                        notif: passData
                    });
                }
                console.log("QUALITY METRICS NON AJAX");
            });
        }
    },

    addmetric: function (req, resp) {
        var source = (req.body.source);
        var sourceID = source.substr(0, source.indexOf('~'));
        var sourceType = source.substr(source.lastIndexOf('~') + 1);
        var metricName = (req.body.metricName);
        var metricDesc = (req.body.metricDesc);
        //var duration = (req.body.duration);
        var startStatus = "Active"
        console.log(metricName);
        console.log(metricDesc);
        console.log(source);

        console.log("SOURCE ID - " + sourceID);
        console.log("SOURCE TYPE = " + sourceType);
        var sql = "INSERT INTO `capstone`.`metric` (`metric_Name`,`metric_Desc`,`source_ID`, `cycle_Status`, `source_Type`) VALUES ( ?, ?, ?, ?, ?)";
        var values = [metricName, metricDesc, sourceID, startStatus, sourceType];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");

            var today = new Date();
                var current = today.toISOString().split('T')[0];
                var notifobject = {
                    "body": "Metric: " + metricName + " ,has been made", //message body, cannot be null
                    "sender": sess.user[0].User_ID, //ID of sender taken from req session
                    "receiver": "0", //ID of receiver, in this case the user that was created
                    "group": sess.user[0].Group, //Group ID taken from req session
                    "range": "3", //range of notification, refer to the JSONcontroller
                    "admin": "1", // 0 if admin does not need to be notified, else 1
                    "sysadmin": "1", // same as above
                    "triggerdate": current //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                }
                Notif.CreateNotif(notifobject);

            resp.redirect('/QualityMetric');
        });
    },

    addmetrictosource: function (req, resp) {
        var source = (req.body.source);
        var metricName = (req.body.metricName);
        var metricDesc = (req.body.metricDesc);
        var priority = (req.body.priority);
        var group = (req.body.group);
        var today = new Date();
        //var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        //var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
        //var dateTime = date+' '+time;
        var current = today.toISOString().split('T')[0];
        console.log(today);
        console.log(metricName);
        console.log(metricDesc);
        console.log(priority);
        console.log(group);
        console.log(current);
        var sql = "INSERT INTO `capstone`.`metric` (`metric_Name`, `metric_Desc`, `priority_Level`, `date_insert`, `group_ID`, `source_ID`) VALUES (? , ? , ? , ?, ?, ?)";
        var values = [metricName, metricDesc, priority, current, group, source];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");

            var today = new Date();
                var current = today.toISOString().split('T')[0];
                var notifobject = {
                    "body": "Metric: " + metricName + " ,has been made added to Source", //message body, cannot be null
                    "sender": sess.user[0].User_ID, //ID of sender taken from req session
                    "receiver": "0", //ID of receiver, in this case the user that was created
                    "group": sess.user[0].Group, //Group ID taken from req session
                    "range": "3", //range of notification, refer to the JSONcontroller
                    "admin": "1", // 0 if admin does not need to be notified, else 1
                    "sysadmin": "1", // same as above
                    "triggerdate": current //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                }
                Notif.CreateNotif(notifobject);

            resp.redirect('/ViewMetricofSource?SID=' + source);
        });
    },

    Viewcycle: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("Select * FROM capstone.cycle;", function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/Viewcycle.ejs', {
                    data: results,
                    current_user: sess.user
                });
                console.log("View Cycle Page");
            });
        }
    },
    addcycle: function (req, resp) {
        var cyclename = (req.body.cycleName);
        var date = (req.body.date);
        var startDate = '';
        var startYear = date.substr(6, 4);
        var startMonth = date.substr(0, 2);
        var startDay = date.substr(3, 2);
        var endDate = '';
        var endYear = date.substr(19, 4);
        var endMonth = date.substr(13, 2);
        var endDay = date.substr(16, 2);
        console.log(cyclename);
        console.log(date);
        startDate = startYear + "-" + startMonth + "-" + startDay;
        endDate = endYear + "-" + endMonth + "-" + endDay;
        console.log("Start Date: " + startDate);
        console.log("End Date: " + endDate);
        var sql = "INSERT INTO `capstone`.`cycle` (`cycle_Name`, `start_Date`, `end_Date`) VALUES (? , ?, ?)";
        var values = [cyclename, startDate, endDate];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");
            resp.redirect('/QualityMetric');
        });
    },
    //addduration: function (req, resp) {
    //      var durationname = (req.body.durationName);
    //   var date = (req.body.txtDate);
    //   console.log(durationname);
    // console.log(date);
    //var sql = "INSERT INTO `capstone`.`duration` (`duration_Name`, `duration_End`) VALUES (? , ?)";
    //var values = [durationname, date];
    //connection.query(sql, values, function (err, result) {
    //    if (err) throw err;
    //  console.log("Record Inserted");
    //    resp.redirect('/QualityMetric');
    //});
    //},

    //10/08/2019 12:00 AM - 11/28/2019 12:00 AM
    //addcycle: function (req, resp) {
    //  var cyclename = (req.body.cycleName);
    //var date = (req.body.date);
    //var startDate = '';
    //    var startTimeHour= date.substr(11,2);
    //  console.log(req.body);
    //var startTimeMin= date.substr(14,2);
    //var startTimeAPM= date.substr(17,2);
    //var startYear = date.substr(6, 4);
    //var startMonth = date.substr(0, 2);
    //var startDay = date.substr(3, 2);
    //var endDate = '';
    //var endTimeHour= date.substr(33,2);
    //var endTimeMin= date.substr(36,2);
    //var endTimeAPM= date.substr(39,2);
    //var endYear = date.substr(28, 4);
    //var endMonth = date.substr(22, 2);
    //var endDay = date.substr(25, 2);
    //console.log(cyclename);
    //console.log(date);
    //if(startTimeAPM=="PM"){
    //    var startTimeHourFin=parseInt(startTimeHour)+12;
    //  console.log("Nag plus na!");
    // }else if(endTimeAPM=="PM"){
    //   var endTimeHourFin=parseInt(endTimeHour)+12;
    // console.log("Nag plus na!!");
    //} 
    //if(startTimeAPM=="AM"){
    //  var startTimeHourFin=parseInt(startTimeHour);
    //    console.log("Walang ng yari");
    //}else if(endTimeAPM=="PM"){
    //  var endTimeHourFin=parseInt(endTimeHour);
    //    console.log("Walang ng yari!!");
    //}
    //startDate = startYear + "-" + startMonth + "-" + startDay +" "+ startTimeHourFin +":"+ startTimeMin;
    //endDate = endYear + "-" + endMonth + "-" + endDay +" "+ endTimeHourFin+":"+ endTimeMin;
    //console.log("Start Date: " + startDate);
    //console.log("End Date: " + endDate);
    //var sql = "INSERT INTO `capstone`.`cycle` (`cycle_Name`, `start_Date`, `end_Date`) VALUES (? , ?, ?)";
    //var values = [cyclename, startDate, endDate];
    //connection.query(sql, values, function (err, result) {
    //  if (err) throw err;
    //console.log("Record Inserted");
    //resp.redirect('/QualityMetric');
    //});
    // },

    editmetric: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var MID = req.query.UID;
            var sql = "Select metric.metric_ID, metric.metric_Name, metric.metric_Desc, metric.priority_Level, metric.date_insert, metric.group_ID, group.Group_ID, group.Group_Name FROM capstone.metric join capstone.group on metric.group_ID = group.Group_ID where metric.metric_ID = ?; Select group.Group_ID, group.Group_Name FROM capstone.group;"
            var values = [MID]
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/EditMetric.ejs', {
                    data: results[0],
                    dataB: results[1],
                    current_user: sess.user
                });
                console.log(results);
                console.log("EDIT METRIC PAGE");
            });
        }
    },

    altermetric: function (req, resp) {
        var id = (req.body.UID);
        var name = (req.body.metricName);
        var desc = (req.body.metricDesc);
        var priority = (req.body.priority);
        var GID = (req.body.group);
        var date = new Date();
        var current = date.toISOString().split('T')[0];
        console.log(id);
        console.log(name);
        console.log(desc);
        console.log(priority);
        var sql = "Update capstone.metric set metric_Name = ?, metric_Desc = ?, priority_Level = ?, date_insert = ?, group_ID = ? where metric_ID = ?";
        var values = [name, desc, priority, current, GID, id];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            if (result) {
                resp.redirect('/QualityMetric');
            }
        });
        console.log("updating");
    },

    assignplantomembers: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var PID = (req.query.PID);
            var GID = (req.query.GID);
            console.log(PID);
            console.log(GID);
            var values = [PID, GID];
            connection.query("SELECT * FROM capstone.plans where plans.Plan_ID = ?; SELECT groupdetails.Groupdetails_ID, groupdetails.Groupdetails_UserID, users.User_ID, users.User_First, users.User_Last, users.username FROM capstone.groupdetails join capstone.users on groupdetails.Groupdetails_ID = users.Group && groupdetails.Groupdetails_UserID = users.User_ID where groupdetails_ID = ?;", values, function (err, results) {
                if (err) throw err;
                console.log(results);
                resp.render('./pages/AssignPlanToGroupMember.ejs', {
                    data: results[0],
                    dataB: results[1],
                    current_user: sess.user
                })
                console.log(results[1]);
            });
        }
        console.log("ASSIGN MEMBER TO PLAN");

    },

    alterplan: function (req, resp) {
        var idrecommendation = (req.body.UIDRecommendation);
        var id = (req.body.UID);
        var group = (req.body.group);
        var cycle = (req.body.cycle);
        var priority = (req.body.priority);
        var basestandard = (req.body.basestandard);
        console.log(id);
        console.log(group);
        console.log(cycle);
        console.log(priority);
        console.log(basestandard);
        var sql = "UPDATE capstone.plans set GroupAssigned = ?, CycleTime = ?, PriorityLevel = ?, BaseStandard = ? where Plan_ID = ? ";
        var values = [group, cycle, priority, basestandard, id];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            resp.redirect('/PlanPage?PID=' + idrecommendation);
        });
    },

    assignmembertogroup: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var GID = req.query.GID;
            var sql = "Select users.User_ID, users.User_First, users.User_Last, users.email_address, users.Role, users.Group, users.ContactNo, users.username FROM capstone.users where users.Group is null ; SELECT group.Group_ID, group.Group_Name, area.Area_Name FROM capstone.group join capstone.area on group.Area_ID = area.Area_ID where group.Group_ID = ?;"
            var values = [GID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                console.log(results[1])
                resp.render('./pages/AssignMemberToGroup.ejs', {
                    data: results[0],
                    dataB: results[1],
                    current_user: sess.user
                });
                console.log("Assign Member to Group Page");
            });
        }
    },

    editmembertogroup: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var GID = req.query.GID;
            var sql = "Select users.User_ID, users.User_First, users.User_Last, users.email_address, users.Role, users.Group, users.ContactNo, users.username FROM capstone.users where users.Group = ? ; SELECT group.Group_ID, group.Group_Name, area.Area_Name FROM capstone.group join capstone.area on group.Area_ID = area.Area_ID where group.Group_ID = ?;"
            var values = [GID, GID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                console.log(results[1])
                resp.render('./pages/EditMemberToGroup.ejs', {
                    data: results[0],
                    dataB: results[1],
                    current_user: sess.user
                });
                console.log("Edit Member to Group Page");
            });
        }
    },

    ViewMeasurementDetails: function (req, resp) {

        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var alert = req.query.passdata;
            var passData
            if (alert) {
                if (alert == 0) {
                    passData = {
                        goodStatus: 0,
                        msg: "Activity/Activities not added"
                    }
                } else {
                    passData = {
                        goodStatus: 1,
                        msg: "Activity/Activities added"
                    }
                }
            }
            var MID = (req.query.MID);
            var CID = (req.query.CID);
            console.log(MID);
            var values = [MID, MID, CID];

            var sql = "SELECT * FROM capstone.measurement WHERE measurement_ID = ?; SELECT approved_activities.activity_ID, approved_activities.activity_name, approved_activities.target, approved_activities.code, approved_activities.description, approved_activities.measurement_ID, approved_activities.deadline FROM capstone.approved_activities; SELECT pending_activities.activity_ID,pending_activities.activity_name, pending_activities.target, pending_activities.description FROM capstone.pending_activities WHERE measurement_ID = ?;SELECT * FROM capstone.activity_outputs; SELECT * from capstone.measurement; SELECT * FROM capstone.approved_activities; SELECT * FROM capstone.measurements_activities; SELECT * FROM capstone.activity_members; SELECT * FROM capstone.measurements_targets; SELECT * FROM capstone.users; SELECT * FROM capstone.cycle WHERE cycle_ID = ?; SELECT * FROM capstone.group; SELECT * FROM capstone.activity_members_members; SELECT * FROM capstone.groupdetails;"

            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    resp.render('./pages/ViewMeasurementDetails.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataD: results[3],
                        dataE: results[4],
                        dataF: results[5],
                        dataG: results[6],
                        dataH: results[7],
                        dataI: results[8],
                        dataJ: results[9],
                        dataK: results[10],
                        dataL: results[11],
                        dataM: results[12],
                        dataN: results[13],
                        current_user: sess.user,
                        notif: passData
                    })
                    //console.log(results);
                }
            });
            console.log("VIEW MEASUREMENT DETAILS");
        }

    },

    AssignRecommendationToGroup: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var RID = req.query.UID;
            var AID = req.query.AID;
            var sql = "Select recommendation.recommendation_ID, recommendation.recommendation_Name, recommendation.recommendation_Desc, recommendation.recommendation_Grade, recommendation.priority_Level, recommendation.date_insert, recommendation.area_ID, area.Area_Name, group.Group_ID, group.Group_Name, group.Area_ID  FROM capstone.recommendation join capstone.area on recommendation.area_ID = area.Area_ID join capstone.group on recommendation.group_ID = group.Group_ID where recommendation.recommendation_ID = ?; Select group.Group_ID, group.Group_Name, group.Area_ID FROM capstone.group where group.Area_ID = ?;"
            var values = [RID, AID]
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/AssignRecommendationToGroup.ejs', {
                    data: results[0],
                    dataB: results[1],
                    current_user: sess.user
                });
                console.log(results);
                console.log("Assign Recommendation to Group");
            });
        }
    },

    makeLeader: function (req, resp) {
        var UID = req.body.UID;
        var GID = req.body.GID;
        var sql = "Update capstone.groupdetails join capstone.users on  groupdetails.Groupdetails_UserID = users.User_ID set Groupdetails_Position = 'Leader', users.isleader = '1' where Groupdetails_UserID = ? && Groupdetails_ID = ?;";
        var values = [UID, GID];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            console.log("updating");
        });
        var sql = "Update capstone.groupdetails join capstone.users on  groupdetails.Groupdetails_UserID = users.User_ID set Groupdetails_Position = 'Member', users.isleader = '0' where Groupdetails_UserID != ? && Groupdetails_ID = ?;";
        var values = [UID, GID];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            if (result) {
                resp.redirect('/ViewGroups');
            }
        });

    },

    makeMember: function (req, resp) {
        var UID = req.body.UID;
        var GID = req.body.GID;
        var sql = "Update capstone.groupdetails join capstone.users on  groupdetails.Groupdetails_UserID = users.User_ID set Groupdetails_Position = 'Member', users.isleader = '0' where Groupdetails_UserID = ? && Groupdetails_ID = ?;";
        var values = [UID, GID];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            if (result) {
                resp.redirect('/ViewGroups');
            }
            console.log(result);
        });
        console.log("updating");
    },

    CreateSources: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var alert = req.query.passdata;
            var passData
            if (alert) {
                if (alert == 0) {
                    passData = {
                        goodStatus: 0,
                        msg: "Source not added"
                    }
                } else {
                    passData = {
                        goodStatus: 1,
                        msg: "Source added"
                    }
                }
            }
            resp.render('./pages/CreateSource.ejs', {
                current_user: sess.user,
                notif: passData
            });
            console.log("CREATE SOURCE PAGE");
        }
    },

    AddSource: function (req, resp) {
        console.log(req.body);
        var an = (req.body.sourcename);
        var ad = (req.body.sourcedesc);
        var sql = "INSERT INTO `capstone`.`source` (`source_Name`, `source_Description`) VALUES (? , ?)";
        var values = [an, ad];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            if (result) {
                resp.redirect('/ViewSources');
                console.log("Record Inserted");
            }
        });

    },

    ViewSources: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var alert = req.query.passdata;
            var passData
            if (alert) {
                if (alert == 0) {
                    passData = {
                        goodStatus: 0,
                        msg: "Grading system not added"
                    }
                } else {
                    passData = {
                        goodStatus: 1,
                        msg: "Grading system added"
                    }
                }
            }
            connection.query("SELECT * FROM capstone.source;", function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/ViewSource.ejs', {
                    data: results,
                    current_user: sess.user,
                    notif: passData
                });
                console.log(results);
            });
            console.log("VIEW SOURCE PAGE");
        }
    },

    ViewMetricofSource: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var alert = req.query.passdata;
            var passData
            if (alert) {
                if (alert == 0) {
                    passData = {
                        goodStatus: 0,
                        msg: "Measurement Not Created"
                    }
                } else if (alert == 1) {
                    passData = {
                        goodStatus: 1,
                        msg: "Measurement Created"
                    }
                } else if (alert == 2) {
                    passData = {
                        goodStatus: 1,
                        msg: "Measurement Not Edited"
                    }
                } else {
                    passData = {
                        goodStatus: 1,
                        msg: "Measurement Edited"
                    }
                }
            }
            var SID = req.query.SID;
            var sql = "SELECT * FROM capstone.metric WHERE metric.source_ID = ?; SELECT * FROM capstone.source WHERE source.source_ID = ?; SELECT * FROM capstone.group; SELECT * FROM capstone.cycle; SELECT * FROM capstone.measurement; SELECT * FROM capstone.measurements_targets; SELECT * FROM capstone.sourcetype; SELECT * FROM capstone.source; SELECT * FROM capstone.measurement_audit; SELECT * FROM capstone.measurements_targets_audit; SELECT cycle.cycle_ID, count(measurement.measurement_ID) as MeasurementCount FROM capstone.`cycle` left join capstone.`measurement` on cycle.cycle_ID = measurement.cycle_ID group by cycle.cycle_ID; SELECT measurement.measurement_ID, measurement.measurement_Name, count(measurements_activities.activity_ID) as ActivityCount FROM capstone.`measurement` left join capstone.`measurements_activities` on measurement.measurement_ID = measurements_activities.measurement_ID group by measurement.measurement_ID;"
            var values = [SID, SID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    resp.render('./pages/ViewMetricofSource.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataD: results[3],
                        dataE: results[4],
                        dataF: results[5],
                        dataG: results[6],
                        dataH: results[7],
                        dataI: results[8],
                        dataJ: results[9],
                        dataK: results[10],
                        dataL: results[11],
                        current_user: sess.user,
                        notif: passData
                    });
                    console.log(results);
                    console.log("RECOMMENDATION NON AJAX");
                }
            });
        }
    },

    EditSource: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var id = (req.query.SID);
            console.log(id);
            var values = [id];
            connection.query("SELECT * FROM capstone.source where source.source_ID = (?);", values, function (err, results) {
                if (err) throw err;
                console.log(results);
                resp.render('./pages/EditSource.ejs', {
                    data: results,
                    current_user: sess.user
                })
            });
        }
    },

    AlterSource: function (req, resp) {
        var id = (req.body.SID);
        var sn = (req.body.sourcename);
        var sd = (req.body.sourcedesc);
        console.log(id);
        console.log(sn);
        console.log(sd);
        var sql = "Update capstone.source set source_Name = ?, source_Description = ? where source_ID = ? ";
        var values = [sn, sd, id];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            if (result) {
                resp.redirect('/ViewSources');
            }
        });
    },

    CreateGrades: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("SELECT * FROM capstone.accreditation ORDER BY accreditation_ID DESC LIMIT 1;", function (err, results) {
                if (err) throw err;
                console.log(results);
                resp.render('./pages/CreateGrades.ejs', {
                    data: results,
                    current_user: sess.user
                });
            });

            console.log("CREATE CUSTOM GRADES");
        }
    },

    AssignCycleandDeadline: function (req, resp) {
        var RID = (req.body.RID);
        var id = (req.body.PlanID);
        var CID = (req.body.cycle);
        var date = (req.body.date);
        var deadlineDate = '';
        var Year = date.substr(6, 4);
        var Month = date.substr(0, 2);
        var Day = date.substr(3, 2);
        deadlineDate = Year + "-" + Month + "-" + Day;
        var sql = "Update capstone.plans set CycleTime = ?, Deadline = ? where Plan_ID = ? ";
        var values = [CID, deadlineDate, id];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            if (result) {
                resp.redirect('/PlanPage?PID=' + RID);
            }
        });
    },

    planPhase: function (req, resp) {
        var CID = (req.body.CID);
        var status = "0"
        var sql = "Update capstone.cycle set status = ? where cycle_ID = ? ";
        var values = [status, CID];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            if (result) {
                resp.redirect('/QualityMetric');
            }
        });
    },

    doPhase: function (req, resp) {
        var CID = (req.body.CID);
        var status = "1"
        var sql = "Update capstone.cycle set status = ? where cycle_ID = ? ";
        var values = [status, CID];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            if (result) {
                resp.redirect('/QualityMetric');
            }
        });
    },

    checkPhase: function (req, resp) {
        var CID = (req.body.CID);
        var status = "2"
        var sql = "Update capstone.cycle set status = ? where cycle_ID = ? ";
        var values = [status, CID];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            if (result) {
                resp.redirect('/ProgressPage');
            }
        });
    },

    actPhase: function (req, resp) {
        var CID = (req.body.CID);
        var status = "3"
        var sql = "Update capstone.cycle set status = ? where cycle_ID = ? ";
        var values = [status, CID];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            if (result) {
                resp.redirect('/QualityMetric');
            }
        });
    },


    endPhase: function (req, resp) {
        var CID = (req.body.CID);
        var status = "4"
        var sql = "Update capstone.cycle set status = ? where cycle_ID = ? ";
        var values = [status, CID];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            if (result) {
                resp.redirect('/QualityMetric');
            }
        });
    },

    UploadDocument: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login');
        } else {
            resp.render('./pages/UploadDocument.ejs', {
                current_user: sess.user
            });
            console.log("kek");
        }
    },

    ViewDocument: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login');
        } else {
            connection.query("SELECT * FROM capstone.documents; SELECT * FROM capstone.users;", function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    resp.render('./pages/ViewDocument.ejs', {
                        data: results[0],
                        dataB: results[1],
                        current_user: sess.user
                    });
                    //console.log(results);
                }
            });
            console.log("ViewDocument");
        }
    },

    ActivityDetails: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var id = (req.query.UID);
            var cid = req.query.CID;
            console.log(id);
            var values = [id, id];
            connection.query("SELECT * FROM capstone.approved_activities where approved_activities.activity_ID=(?); SELECT * FROM capstone.documents left join capstone.folder_documents on folder_documents.document_id = documents.Document_ID where documents.isfolder = 0; SELECT * FROM capstone.activity_outputs; SELECT * FROM capstone.activity_outputs WHERE activity_outputs.activity_ID = ?; SELECT * FROM capstone.measurements_targets;", values, function (err, results) {
                if (err) throw err;
                if (results) {
                    console.log(results);
                    resp.render('./pages/ActivityDetails.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataD: results[3],
                        dataTargets: results[4],
                        CID: cid,
                        current_user: sess.user
                    })
                }
            });
        }
    },

    ActivityPendingDetails: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var id = (req.query.UID);
            console.log(id);
            var values = [id, id];
            connection.query("SELECT * FROM capstone.pending_activities where pending_activities.activity_ID=(?); SELECT activity_evidences.activityID, activity_evidences.documentID, documents.Document_ID, documents.Document_Name, documents.Document_Route FROM capstone.activity_evidences join capstone.documents on activity_evidences.documentID = documents.Document_ID where activity_evidences.activityID=(?);", values, function (err, results) {
                if (err) throw err;
                if (results) {
                    console.log(results);
                    resp.render('./pages/ActivityPendingDetails.ejs', {
                        data: results[0],
                        dataB: results[1],
                        current_user: sess.user
                    })
                }
            });
        }
    },

    EditUserAccount: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var id = (req.query.UID);
            console.log(id);
            var values = [id];
            connection.query("SELECT * FROM capstone.users where users.User_ID = (?);", values, function (err, results) {
                if (err) throw err;
                console.log(results);
                resp.render('./pages/EditUserbyUser.ejs', {
                    data: results,
                    current_user: sess.user
                })
            });
        }
    },

    alteruserbyuser: function (req, resp) {
        var id = (req.body.UID);
        var first = (req.body.first);
        var last = (req.body.last);
        var ea = (req.body.emailadd);
        var un = (req.body.username);
        var pw = (req.body.password);
        var co = (req.body.contact);
        console.log(id);
        console.log(ea);
        console.log(un);
        console.log(pw);
        console.log(co);
        bcrypt.hash(pw, saltRounds, function (err, hash) {
            var sql = "Update capstone.users set User_First = ?, User_Last = ?, email_address = ?, username = ?, passwd = ?, ContactNo = ? where User_ID = ? ";
            var values = [first, last, ea, un, hash, co, id];
            connection.query(sql, values, function (err, result) {
                if (err) throw err;
                console.log(result);
                if (result) {
                    resp.redirect('/EditUserbyUser?UID=' + id);
                }
            });
        });
    },

    ActionPlan: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("SELECT * FROM capstone.metric; SELECT * FROM capstone.measurement;", function (err, results, fields) {
                if (err) throw err;
                if (results) {

                    resp.render('./pages/ActionPlan.ejs', {
                        data: results[0],
                        dataB: results[1],
                        current_user: sess.user
                    });
                    console.log(results);
                    console.log("Action Plan test");

                }
            });
        }
    },

    Dashboards: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("SELECT * FROM capstone.metric; SELECT * FROM capstone.measurement; SELECT * FROM capstone.approved_activities JOIN capstone.activity_members, capstone.measurements_activities, capstone.measurement WHERE approved_activities.activity_ID = activity_members.activity_ID AND approved_activities.activity_ID = measurements_activities.activity_ID AND measurements_activities.measurement_ID = measurement.measurement_ID; SELECT * FROM capstone.activity_members; SELECT * FROM capstone.measurements_activities; SELECT pending_ID, measurements_activities.measurement_ID, measurement.cycle_ID, user_ID ,activityID, activity_name,status, active,suggested_score,dateupdated, comment, documentID, Document_Name FROM capstone.pending_activities JOIN capstone.activity_evidences, capstone.documents, capstone.measurements_activities, capstone.measurement where pending_activities.activity_ID = activity_evidences.activityID AND documents.Document_ID = activity_evidences.documentID AND pending_activities.pending_ID = activity_evidences.pendingID AND measurements_activities.activity_ID = pending_activities.activity_ID AND measurement.measurement_ID = measurements_activities.measurement_ID; SELECT * FROM capstone.measurements_targets; SELECT * FROM capstone.approved_activities;", function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    resp.render('./pages/home.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataD: results[3],
                        dataE: results[4],
                        dataF: results[5],
                        dataG: results[6],
                        dataH: results[7],
                        current_user: sess.user
                    });
                    //console.log(results);
                    //console.log(results[3]);
                    //console.log(results[2]);
                    //console.log(results[6]);

                    console.log("Dashboards Loaded");
                    console.log(sess.user[0]);

                }
            });
        }
    },

    Assignactivitytomember: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var AID = req.query.AID;
            var CID = req.query.CID;
            //var GID = req.query.GID;
            //console.log("GROUP ID-------------------" + GID)
            console.log("ACTIVITY ID-------------------" + AID)
            var sql = "SELECT * FROM capstone.group WHERE Group_ID NOT IN (SELECT MAX(0) FROM capstone.group) ORDER BY Group_ID Asc; SELECT * FROM capstone.approved_activities WHERE approved_activities.activity_ID = (?); SELECT * FROM capstone.measurements_activities WHERE measurements_activities.activity_ID=(?); SELECT * FROM capstone.cycle WHERE cycle.cycle_ID = ?;SELECT * FROM capstone.area; "
            var values = [AID, AID, CID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                //console.log(results[1])
                if (results) {
                    resp.render('./pages/AssignActivityToMember.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataD: results[3],
                        dataE: results[4],
                        current_user: sess.user
                    });
                    console.log("Assign Activity to Member Page");
                }
            });
        }
    },

    ViewUsersSubmission: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var userid = req.query.sess;
            var sql = "SELECT * FROM capstone.pending_activities WHERE user_ID = (?);";
            var values = [sess.user[0].User_ID];
            console.log(sess.user[0].User_ID);
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/ViewUsersSubmissions.ejs', {
                    data: results,
                    current_user: sess.user
                });
                console.log(results)
            });
        }


    },

    ViewUsersSubmissionDetails: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var userid = req.query.sess;
            var SID = req.query.subID;
            var sql = "SELECT * FROM capstone.pending_activities WHERE user_ID = (?) && pending_ID = (?); SELECT * FROM capstone.documents; SELECT * FROM capstone.activity_evidences WHERE pendingID = (?);";
            var values = [sess.user[0].User_ID, SID, SID];
            console.log(sess.user[0].User_ID);
            console.log(SID);
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/ViewUsersSubmissionsDetails.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    current_user: sess.user
                });
            });
        }


    },

    EditMeasurement: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var CASE = req.query.CASE;
            var MID = req.query.MID;
            var GID = req.query.GID;
            var sql = "SELECT * FROM capstone.measurement WHERE measurement_ID = (?); SELECT * FROM capstone.group; SELECT * FROM capstone.cycle where goal_ID = ? ORDER BY termnum ASC; SELECT * FROM capstone.metric"
            var values = [MID, GID]
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/EditMeasurement.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    dataD: results[3],
                    CASE: CASE,
                    GID: GID,
                    current_user: sess.user
                });
                //console.log(results);
                console.log("EDIT MEASUREMENT PAGE");
            });
        }
    },

    UpdateMeasurement: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            console.log(req.body);
            var MID = req.body.MID;
            var mname = req.body.measurementName;
            var mdesc = req.body.measurementDesc;
            var group = req.body.group;
            var priority = req.body.priority;
            var sql = "UPDATE `capstone`.`measurement` SET `GroupAssigned` = ?, `measurement_Name` = ?, `measurement_Description` = ? , `priority_Level` = ? WHERE (`measurement_ID` = ?)";
            var values = [group, mname, mdesc, priority, MID]
            connection.query(sql, values, function (err, result, fields) {
                if (err) throw err;
                if (result) {
                    resp.redirect('/QualityMetrics?passdata=3')
                }
            });

        }
    },

    AuditMeasurement: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            console.log(req.body);
            var MID = req.body.MID;
            var mname = req.body.measurementName;
            var mdesc = req.body.measurementDesc;
            var cycle = req.body.cycle;
            var priority = req.body.priority;
            getmeasurement(MID, auditmeasurement);
            console.log("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA  " + priority)

            function getmeasurement(MID, callback) {
                var sql = "SELECT * FROM capstone.measurement WHERE measurement_ID = (?);"
                var values = [MID]
                connection.query(sql, values, function (err, result, fields) {
                    if (err) throw err;
                    if (result) {
                        console.log(result)
                        var resdata = JSON.parse(JSON.stringify(result[0]))
                        console.log(resdata + "measurement to audit")
                        callback(resdata, updatemeasurement, audittargets)
                    }
                });
            }

            function auditmeasurement(resdata, callback, callback2) {
                var date = new Date();
                var current = date.toISOString().split('T')[0];
                var sql = "INSERT INTO `capstone`.`measurement_audit` (`measurement_ID`, `QualityTarget`, `Procedures`, `GroupAssigned`, `metric_ID`, `measurement_Name`, `measurement_Description`, `Deadline`, `cycle_ID`, `audit_date`, `priority_Level` ) VALUES (?,?,?,?,?,?,?,?,?,?,?);"
                var values = [resdata.measurement_ID, resdata.QualityTarget, resdata.Procedures, resdata.GroupAssigned, resdata.metric_ID, resdata.measurement_Name, resdata.measurement_Description, resdata.Deadline, resdata.cycle_ID, current, priority]
                connection.query(sql, values, function (err, result, fields) {
                    if (err) throw err;
                    if (result) {
                        console.log("Measurement Audited")
                        var MAID = result.insertId;
                        callback()
                        callback2(MAID, auditactivities, resdata)
                    }
                });
            }

            function updatemeasurement() {
                var sql = "UPDATE `capstone`.`measurement` SET `measurement_Name` = ?, `measurement_Description` = ?, `cycle_ID` = ?, `priority_Level` = ?  WHERE (`measurement_ID` = ?)";
                var values = [mname, mdesc, cycle, priority, MID]
                connection.query(sql, values, function (err, result, fields) {
                    if (err) throw err;
                    if (result) {
                        console.log("Measurement Updated")
                        resp.redirect('/QualityMetrics')
                    }
                });
            }

            function audittargets(MAID, auditactivities, resdata) { //MAID == Measurementt Audit ID
                var sql = "SELECT * FROM capstone.measurements_targets WHERE measurementID = (?)"
                var values = [MID]
                var resdatamain = resdata;
                connection.query(sql, values, function (err, result, fields) {
                    if (err) throw err;
                    if (result) {
                        var resdata = JSON.parse(JSON.stringify(result))
                        async.forEachOf(resdata, function (value, key, callback) {
                            var mi = resdata[key]["measurementID"];
                            var ta = resdata[key]["target"];
                            var pr = resdata[key]["progress"];
                            var ti = resdata[key]["target_ID"];
                            var tt = resdata[key]["target_Type"];
                            var td = resdata[key]["target_Desc"];

                            var sql = "INSERT INTO `capstone`.`measurements_targets_audit` (`measurements_auditID`, `measurementID`, `target`, `progress`, `target_ID` , `target_Type` , `target_Desc`) VALUES (?,?,?,?,?,?,?);"


                            var values = [MAID, mi, ta, pr, ti, tt, td];
                            connection.query(sql, values, function (err, result) {
                                if (err) callback(err);
                                if (result) {
                                    callback();
                                }
                            });
                        }, function (err) {
                            if (err) {
                                console.log("Failed");
                            } else {
                                console.log("Passed");
                                auditactivities(MID, MAID, auditpendingactivities, resdata, resdatamain, auditactivitydata);
                            }
                        })
                    }
                });
            }

            function auditactivities(MID, MAID, auditpendingactivities, resdata, resdatamain, auditactivitydata) {
                var sql = "SELECT * FROM capstone.measurements_activities WHERE measurement_ID = (?)"
                var values = [MID];
                var CID = resdatamain.cycle_ID;
                connection.query(sql, values, function (err, result, fields) {
                    if (err) throw err;
                    if (result) {
                        var resdata = JSON.parse(JSON.stringify(result))
                        async.forEachOf(resdata, function (value, key, callback) {
                            var mi = resdata[key]["measurement_ID"];
                            var ai = resdata[key]["activity_ID"];
                            var sql = "INSERT INTO `capstone`.`measurements_activities_audit` (`measurements_auditID`, `measurement_ID`, `activity_ID`) VALUES (?,?,?);"
                            var values = [MAID, mi, ai];
                            console.log(values + "audit values")
                            connection.query(sql, values, function (err, result) {
                                if (err) callback(err);
                                if (result) {
                                    var MAAID = result.insertId;
                                    var aii = ai;
                                    auditpendingactivities(MAID, MAAID, CID, aii);
                                    auditactivitydata(MAID, ai);
                                    callback();
                                }
                            });
                        }, function (err) {
                            if (err) {
                                console.log("Audit Activities Failed");
                                console.log(err)
                            } else {
                                console.log("Audit Activities Passed");
                            }
                        })
                    }
                });
            }

            function auditpendingactivities(MAID, MAAID, CID, ai) {
                var sql2 = "SELECT * FROM capstone.pending_activities where pending_activities.activity_ID = ? && pending_activities.cycle_ID = ?;"
                var values2 = [ai, CID];
                console.log(values2 + " pending values")
                connection.query(sql2, values2, function (err, result, fields) {
                    if (err) throw err;
                    if (result) {
                        var resdata = JSON.parse(JSON.stringify(result))
                        async.forEachOf(resdata, function (value, key, callback2) {
                            var pi = resdata[key]["pending_ID"];
                            var ai = resdata[key]["activity_ID"];
                            var an = resdata[key]["activity_name"];
                            var ta = resdata[key]["target"];
                            var co = resdata[key]["code"];
                            var de = resdata[key]["description"];
                            var mi = resdata[key]["measurement_ID"];
                            var cs = resdata[key]["current_Score"];
                            var st = resdata[key]["status"];
                            var ss = resdata[key]["suggested_Score"];
                            var du = new Date(resdata[key]["dateupdated"]).toISOString().split('T')[0];
                            var ac = resdata[key]["active"];
                            var ui = resdata[key]["user_ID"];
                            var com = resdata[key]["comment"];
                            var ci = resdata[key]["cycle_ID"];
                            var sql = "INSERT INTO `capstone`.`pending_activities_audit` (`measurement_activities_auditID`, `measurement_auditID`, `pending_ID`, `activity_ID`, `activity_name`, `target`, `code`, `description`, `measurement_ID`, `current_Score`, `status`, `suggested_Score`, `dateupdated`, `active`, `user_ID`, `comment`, `cycle_ID`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, ?, ?); UPDATE `capstone`.`pending_activities` SET `active` = 0 WHERE (`pending_ID` = ?);"

                            var values = [MAAID, MAID, pi, ai, an, ta, co, de, mi, cs, st, ss, du, ac, ui, com, ci, pi];
                            connection.query(sql, values, function (err, result) {
                                if (err) callback2(err);
                                if (result) {
                                    var CID = resdata.cycle_ID;
                                    var MAAID = result.insertId;
                                    //auditpendingactivities(MAID, MAAID, CID, ai);
                                    callback2();
                                }
                            });
                        }, function (err) {
                            if (err) {
                                console.log("Audit Pending Failed");
                                console.log(err);
                            } else {
                                console.log("Audit Pending Passed");
                            }
                        })
                    }
                });
            }

            function auditactivitydata(MAID, ai) {
                var sql = "SELECT * FROM capstone.approved_activities where approved_activities.activity_ID = ?;"
                var values = [ai]
                connection.query(sql, values, function (err, result, fields) {
                    if (err) throw err;
                    if (result) {
                        var resdata = JSON.parse(JSON.stringify(result[0]))
                        var sql2 = "INSERT INTO `capstone`.`approved_activities_audit` (`measurement_auditID`, `activity_ID`, `activity_name`, `target`, `code`, `description`, `measurement_ID`, `current_Score`, `deadline`) VALUES (?,?,?,?,?,?,?,?,?);"
                        var deadline = new Date(resdata.deadline).toISOString().split('T')[0];
                        var values2 = [MAID, resdata.activity_ID, resdata.activity_name, resdata.target, resdata.code, resdata.description, resdata.measurement_ID, resdata.current_Score, deadline]
                        connection.query(sql2, values2, function (err, result, fields) {
                            if (err) throw err;
                            if (result) {
                                console.log("activity data audited");
                            }
                        });
                    }
                });

            }

        }
    },

    ViewActivitiesUnderMeasurement: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var MID = req.query.MID;
            var sql = "SELECT * FROM capstone.approved_activities_audit WHERE approved_activities_audit.measurement_auditID = (?); SELECT * FROM capstone.activity_evidences; SELECT * FROM capstone.documents JOIN capstone.approved_activities_audit, capstone.activity_evidences WHERE capstone.activity_evidences.activityID = capstone.approved_activities_audit.activity_ID AND capstone.activity_evidences.documentID = capstone.documents.Document_ID;"
            console.log("Activity test-------------------------------------------------------------------------------" + MID);
            var values = [MID]

            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/ViewActivitiesUnderMeasurement.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    current_user: sess.user
                });
                console.log();
                console.log("activities are loaded");
            });
        }
    },

    BackToMeasurement: function (req, resp) {
        resp.redirect('./pages/QualityMetrics.ejs');
        console.log("Back To Quality Metrics");
    },

    AnnualReport: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var GID = req.query.GID;
            var Year = req.query.Year;
            var sql = "SELECT *,  SUBSTRING_INDEX(SUBSTRING_INDEX(cycle.cycle_Name ,' ', -4),' ', 1) as extractedyear FROM capstone.measurement_audit JOIN capstone.measurements_targets_audit JOIN capstone.cycle WHERE measurement_audit.measurement_auditID = measurements_targets_audit.measurements_auditID AND measurement_audit.cycle_ID = cycle.cycle_ID AND cycle.termindex <= cycle.totalterm AND cycle.goal_ID = (?) AND SUBSTRING_INDEX(SUBSTRING_INDEX(cycle.cycle_Name ,' ', -4),' ', 1) = (?); SELECT * FROM capstone.cycle; SELECT *,  SUBSTRING_INDEX(SUBSTRING_INDEX(cycle.cycle_Name ,' ', -4),' ', 1) as extractedyear FROM capstone.measurement_audit LEFT JOIN capstone.cycle on measurement_audit.cycle_ID = cycle.cycle_ID WHERE goal_ID = (?) AND SUBSTRING_INDEX(SUBSTRING_INDEX(cycle.cycle_Name ,' ', -4),' ', 1) = (?);"
            console.log("ANNUAL REPORT TEST ---------------------------------------------------------------------" + GID);
            var values = [GID,Year,GID,Year]

            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/AnnualReport.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    current_user: sess.user
                });

                console.log("reports are loaded are loaded boi");



            });

        }
    },

    ViewUserAccount: function (req, resp) {

        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var sql = "SELECT * FROM capstone.pending_activities; SELECT * FROM capstone.users; SELECT * FROM capstone.activity_outputs; SELECT * FROM capstone.pending_outputs; SELECT * FROM capstone.users JOIN capstone.groupdetails ON groupdetails.Groupdetails_UserID = users.User_ID; SELECT * FROM capstone.group; SELECT * FROM capstone.groupdetails; SELECT * FROM capstone.approved_activities; SELECT * FROM capstone.activity_members_members;"
            connection.query(sql, function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/ViewUserAccount.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    dataD: results[3],
                    dataUsers: results[4],
                    dataGroup: results[5],
                    dataGroupdetails: results[6],
                    dataActivity: results[7],
                    dataAssigneduser: results[8],
                    current_user: sess.user
                });

                console.log("VIEW USER ACCOUNT PAGE");



            });
        }
    },

    ViewSubmissionDetails: function (req, resp) {

        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var SID = req.query.subID;
            console.log(SID);
            var sql = "SELECT * FROM capstone.pending_activities WHERE pending_activities.pending_ID = ?; SELECT * FROM capstone.documents; SELECT * FROM capstone.activity_evidences WHERE pendingID = (?);";
            var values = [SID, SID]
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;

                console.log(results);
                resp.render('./pages/ViewUserSubmissionAccountDetails.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    current_user: sess.user
                });

                console.log("KEK")
            });
        }
    },

    ViewFolder: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login');
        } else {
            var FID = req.query.FolderID;
            var sql = "SELECT * FROM capstone.documents; SELECT * FROM capstone.folder_documents WHERE folder_documents.folder_ID = ?; SELECT * FROM capstone.documents WHERE documents.Document_ID = ?;";
            var values = [FID, FID]
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    resp.render('./pages/ViewFolderDocument.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        current_user: sess.user
                    });
                    //console.log(results);
                }
            });
            console.log("View Folder Documents Page");
        }
    },

    ViewPersonalFolder: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login');
        } else {
            var UID = req.query.UID;
            var sql = "SELECT * FROM capstone.documents WHERE documents.upload_id = ?;";
            var values = [UID]
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    resp.render('./pages/ViewPersonalUploads.ejs', {
                        data: results,
                        current_user: sess.user
                    });
                    //console.log(results);
                }
            });
            console.log("View Your Documents Page");
        }
    },


    EditActivities: function (req, resp) {
        sess = req.session;
                var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var AID = req.query.AID;
            var CID = req.query.CID;
            var MID = req.query.MID;
            var sql= "SELECT * FROM capstone.approved_activities WHERE activity_ID = (?); SELECT * FROM capstone.cycle WHERE cycle.cycle_ID = ?; SELECT * FROM capstone.measurement WHERE measurement.measurement_ID = ?;";
            var value = [AID, CID, MID];
            //console.log(AID);
            connection.query(sql, value, function (err, result, fields) {
                if (err) throw err;
                resp.render('./pages/EditActivity.ejs', {
                    data: result[0],
                    dataB: result[1],
                    dataC: result[2],
                    current_user: sess.user
                });
                //console.log(result)
            });
        }


    }, 

    AlterActivities: function (req, resp) { 
        sess=req.session;
                var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if(!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var id = req.body.AID;
            var an = req.body.activityName;
            var ds = req.body.activityDesc;
            var dl = req.body.deadline;
            var MID = req.body.MID;
            var CID = req.body.CID;
            console.log(id);
            console.log(an);
            console.log(ds);
            console.log(dl);
            var sql = "UPDATE capstone.approved_activities SET activity_name = ?, description = ?, deadline = ? WHERE activity_ID = ?; ";
            var values = [an, ds, dl, id];
            connection.query(sql, values, function (err, result, fields) {
                if (err) throw err;
                console.log(err);
                if (result) {
                    resp.redirect('/ViewMeasurementDetails?MID=' + MID + '&CID=' + CID);
                }
            }); 
            console.log("ACTIVITY UPDATED");
        }
        
    }, 

    CategorizeActivities: function (req, resp) { 
        sess = req.session;
                var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var CID = req.query.CID;
            console.log(CID +"----------------------------------------------------------------------------------------------------------------CID");
            var sql = "SELECT * FROM capstone.cycle WHERE cycle.cycle_ID = (?); SELECT * FROM capstone.measurement_audit; SELECT * FROM capstone.measurement_audit join capstone.measurements_targets_audit on measurement_audit.measurement_auditID = measurements_targets_audit.measurements_auditID AND measurement_audit.cycle_ID = (?);  SELECT * FROM capstone.measurements_targets;"
            var values = [CID, CID]
            console.log (CID);
            connection.query( sql,values,function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/CategorizeActivities.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    dataD: results[3],
                    current_user: sess.user
                });
                console.log(CID)
            });
        }


    },

    AssignActivityToGroupMember: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var AID = req.query.AID;
            var MID = req.query.MID;
            var GID = req.query.GID;
            var CID = req.query.CID;
            //console.log("GROUP ID-------------------" + GID)
            console.log("ACTIVITY ID-------------------" + AID)
            var sql = "SELECT * FROM capstone.users JOIN capstone.group ON users.Group = group.Group_ID WHERE group.Group_ID = ?; SELECT * FROM capstone.approved_activities WHERE approved_activities.activity_ID = ?; SELECT * FROM capstone.measurement WHERE measurement.measurement_ID = ?; SELECT * FROM capstone.cycle WHERE cycle.cycle_ID = ?;"
            var values = [GID, AID, MID, CID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                //console.log(results[1])
                if (results) {
                    resp.render('./pages/AssignActivityToGroupMember.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataD: results[3],
                        current_user: sess.user
                    });
                    console.log("Assign Activity to Group Member Page");
                }
            });
        }
    },

    AddFileToFolder: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var FID = req.query.FID;
            var sql = "SELECT * FROM capstone.documents where documents.Document_ID != ? && documents.isfolder = 0; SELECT * FROM capstone.documents where documents.Document_ID = ?;"
            var values = [FID, FID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                //console.log(results[1])
                resp.render('./pages/AddFilesToFolder.ejs', {
                    data: results[0],
                    dataB: results[1],
                    current_user: sess.user
                });
                console.log("ADD FILES TO FOLDER");
            });
        }
    },

    GroupReport: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var MAID = req.query.MAID;
            console.log(" G R O U P   R E P O R T S --------------------------" +MAID);
            var sql = "SELECT * FROM pending_activities_audit; SELECT * FROM capstone.users; SELECT * FROM capstone.documents JOIN capstone.pending_activities_audit, capstone.activity_evidences WHERE capstone.activity_evidences.activityID = capstone.pending_activities_audit.activity_ID AND capstone.activity_evidences.documentID = capstone.documents.Document_ID; SELECT * FROM capstone.activity_evidences; SELECT * FROM pending_activities_audit JOIN measurements_targets_audit WHERE pending_activities_audit.measurement_auditID = measurements_targets_audit.measurements_auditID;"
            var values = [MAID]
            
            connection.query( sql,values,function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/GroupReport.ejs', {
                    data: results[0], 
                    dataB: results[1],
                    dataC: results[2],   
                    dataD: results[3],   
                    dataE: results[4],           
                    current_user: sess.user
                });
            });
        }
    },

    EditTargetDeadline: function (req, resp) {
        sess = req.session;
                var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var GID = req.query.GID;
            var MID = req.query.MID;
            var sql= "SELECT * FROM capstone.measurement WHERE measurement.measurement_ID = ?; SELECT * FROM capstone.measurements_targets WHERE measurements_targets.measurementID = ?; SELECT * FROM capstone.cycle WHERE cycle.goal_ID = ? ORDER BY termnum ASC;";
            var value = [MID, MID, GID];
            //console.log(AID);
            connection.query(sql, value, function (err, result, fields) {
                if (err) throw err;
                resp.render('./pages/EditTargetDeadline.ejs', {
                    dataMeasurement: result[0],
                    dataTarget: result[1],
                    dataCycle: result[2],
                    current_user: sess.user
                });
                //console.log(result)
            });
        }


    }, 
}
