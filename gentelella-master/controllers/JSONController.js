const express = require('express');
const fileUpload = require('express-fileupload');
const server = express();
const fs = require('fs');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const md5 = require('md5');
const addSubtractDate = require("add-subtract-date");
const async = require("async");
var mysql = require('mysql');
var connection = require('../config/db');
// ---- URL PARSER
var url = require('url');
var session = require('express-session');
var Notif = require('../controllers/NotifController')
// ---- DEFINE SESSION
server.use(session({
    secret: 'ssshhhhh',
    resave: false,
    saveUninitialized: true
}));
// ----
var sess;

module.exports = {

    AssignGroupJSON: function (req, resp) {
        sess = req.session;
        var UID = req.body.table;
        UID = JSON.parse(UID);
        async.forEachOf(UID, function (value, key, callback) {
            var gid = UID[key]["Group ID"];
            var uid = UID[key]["User ID"];
            var fn = UID[key]["First Name"]
            var ln = UID[key]["Last Name"]
            var sql = "Update capstone.users set users.Group = ? where users.User_ID = ?; INSERT INTO `capstone`.`groupdetails` (`Groupdetails_ID`, `Groupdetails_UserID`) VALUES (? , ? ); ";
            var values = [gid, uid, gid, uid];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();

                    var today = new Date();
                    var current = today.toISOString().split('T')[0];
                    var notifobject = {
                        "body": "User " + fn + " " + ln + " has been assigned to Group", //message body, cannot be null
                        "sender": sess.user[0].User_ID, //ID of sender taken from req session
                        "receiver": uid, //ID of receiver, in this case the user that was created
                        "group": sess.user[0].Group, //Group ID taken from req session
                        "range": "2", //range of notification, refer to the JSONcontroller
                        "admin": "1", // 0 if admin does not need to be notified, else 1
                        "sysadmin": "1", // same as above
                        "triggerdate": current //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                    }
                    Notif.CreateNotif(notifobject);

                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                resp.send("OK");


            }
        })
    },

    AssignTaskJSON: function (req, resp) {
        var UID = req.body.table;
        UID = JSON.parse(UID);
        console.log(UID);
        async.forEachOf(UID, function (value, key, callback) {
            var pid = UID[key]["Plan ID"];
            var uid = UID[key]["User ID"];
            var sql = "INSERT INTO `capstone`.`plandetails` (`Plan_ID`, `Member_ID`) VALUES (? , ?) ";
            var values = [pid, uid];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                resp.send("OK");
            }
        })

    },

    AddGradesJSON: function (req, resp) {
        var UID = req.body.table;
        UID = JSON.parse(UID);
        console.log(UID);
        async.forEachOf(UID, function (value, key, callback) {
            var acc = UID[key]["Accreditation"];
            var code = UID[key]["Code"];
            var rank = UID[key]["Rank"];
            var sql = "INSERT INTO `capstone`.`grades` (`Rank`, `Code`, `Accreditation_ID`) VALUES (?, ?, ?);";
            var values = [rank, code, acc];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                var acc2 = UID[0]["Accreditation"];
                var sql2 = "UPDATE `capstone`.`accreditation` SET `gradesset` = '1' WHERE (`accreditation_ID` = ?);"
                var values2 = [acc2];
                connection.query(sql2, values2, function (err2, result2) {
                    if (err2) callback(err);
                    if (result2) {
                        console.log("------Grades locked");
                    }
                });
                resp.send("OK");
            }
        })
    },

    AddActivitiesJSON: function (req, resp) {
        sess = req.session;
        var UID = req.body.table;
        var MID = req.body.mid;
        UID = JSON.parse(UID);
        console.log("Table length =" + UID.length);
        async.forEachOf(UID, function (value, key, callback) {
            var an = UID[key]["Activity Name"];
            var measureID = UID[key]["MeasurementID"];
            measureID = measureID.split(",");
            var desc = UID[key]["Description"];
            var dead = UID[key]["Deadline"];
            var mname = UID[key]["Measurement to assign"]
            console.log(an);
            var sql = "INSERT INTO `capstone`.`approved_activities` (`activity_name`, `description`, `deadline`) VALUES (?, ?, ?);";
            var values = [an, desc, dead];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
                    var trigger = new Date(dead);
                    var trigdate = trigger.toISOString().split('T')[0];
                    var notifobject = {
                        "body": "Activity: " + an + "is due today", //message body, cannot be null
                        "sender": sess.user[0].User_ID, //ID of sender taken from req session
                        "receiver": result.insertId, //ID of receiver, in this case the user that was created
                        "group": sess.user[0].Group, //Group ID taken from req session
                        "range": "2", //range of notification, refer to the JSONcontroller
                        "admin": "1", // 0 if admin does not need to be notified, else 1
                        "sysadmin": "1", // same as above
                        "triggerdate": trigdate, //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                        "isactivity": "1"
                    }
                    Notif.CreateNotif(notifobject);

                    var daybefore = addSubtractDate.subtract(trigger, 1, "day");
                    var beforetrig = daybefore.toISOString().split('T')[0];
                    console.log(beforetrig);
                    var notifobject2 = {
                        "body": "Activity: " + an + "is due tomorrow", //message body, cannot be null
                        "sender": sess.user[0].User_ID, //ID of sender taken from req session
                        "receiver": result.insertId, //ID of receiver, in this case the user that was created
                        "group": sess.user[0].Group, //Group ID taken from req session
                        "range": "2", //range of notification, refer to the JSONcontroller
                        "admin": "1", // 0 if admin does not need to be notified, else 1
                        "sysadmin": "1", // same as above
                        "triggerdate": beforetrig, //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                        "isactivity": "1"
                    }
                    Notif.CreateNotif(notifobject2);

                    var threedays = addSubtractDate.subtract(trigger, 2, "days");
                    var threetrig = threedays.toISOString().split('T')[0];
                    console.log(threetrig);
                    var notifobject3 = {
                        "body": "Activity: " + an + "is due in 3 days at:" + trigdate, //message body, cannot be null
                        "sender": sess.user[0].User_ID, //ID of sender taken from req session
                        "receiver": result.insertId, //ID of receiver, in this case the user that was created
                        "group": sess.user[0].Group, //Group ID taken from req session
                        "range": "2", //range of notification, refer to the JSONcontroller
                        "admin": "1", // 0 if admin does not need to be notified, else 1
                        "sysadmin": "1", // same as above
                        "triggerdate": threetrig, //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                        "isactivity": "1"
                    }
                    Notif.CreateNotif(notifobject3);

                    var sevendays = addSubtractDate.subtract(trigger, 4, "days");
                    var seventrig = sevendays.toISOString().split('T')[0];
                    console.log(seventrig);
                    var notifobject4 = {
                        "body": "Activity: " + an + "is due in 7 days at:" + trigdate, //message body, cannot be null
                        "sender": sess.user[0].User_ID, //ID of sender taken from req session
                        "receiver": result.insertId, //ID of receiver, in this case the user that was created
                        "group": sess.user[0].Group, //Group ID taken from req session
                        "range": "2", //range of notification, refer to the JSONcontroller
                        "admin": "1", // 0 if admin does not need to be notified, else 1
                        "sysadmin": "1", // same as above
                        "triggerdate": seventrig //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                    }
                    Notif.CreateNotif(notifobject4);


                    console.log(result);
                    var activitytolink = result.insertId;
                    async.forEachOf(measureID, function (value, key, callback) {
                        console.log("Measurement ID = " + measureID[key])
                        var sql2 = "INSERT INTO `capstone`.`measurements_activities` (`measurement_ID`, `activity_ID`) VALUES (?, ?)"
                        var values2 = [measureID[key], activitytolink]
                        connection.query(sql2, values2, function (err, result) {
                            if (err) throw err;
                            if (result) {
                                callback();
                                console.log("Activity linked to Measurement");
                            }
                        });

                    }, function (err) {
                        if (err) {
                            console.log("Failed");
                            resp.send("Not OK")
                        } else {
                            console.log("Passed");
                            var today = new Date();
                            var current = today.toISOString().split('T')[0];
                            var notifobject5 = {
                                "body": "Activities have been added to Measurement/s " + mname, //message body, cannot be null
                                "sender": sess.user[0].User_ID, //ID of sender taken from req session
                                "receiver": "0", //ID of receiver, in this case the user that was created
                                "group": sess.user[0].Group, //Group ID taken from req session
                                "range": "2", //range of notification, refer to the JSONcontroller
                                "admin": "1", // 0 if admin does not need to be notified, else 1
                                "sysadmin": "1", // same as above
                                "triggerdate": current //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                            }
                            Notif.CreateNotif(notifobject5);
                        }
                    })
                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                resp.send("OK");
            }
        })



    },

    AssignActivityJSON: function (req, resp) {
        var UID = req.body.table;
        console.log(UID);
        UID = JSON.parse(UID);

        async.forEachOf(UID, function (value, key, callback) {
            var aid = UID[key]["Activity ID"];
            var uid = UID[key]["Group ID"];
            var mid = UID[key]["Measurement ID"];
            console.log(aid);
            console.log(uid);
            console.log(mid);
            var sql = "INSERT INTO `capstone`.`activity_members` (`activity_ID`, `activity_Member`, `measurement_ID`) VALUES (? , ?, ?); ";
            var values = [aid, uid, mid];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                resp.send("OK");
            }
        })
    },

    AddOutputsJSON: function (req, resp) {
        var UID = req.body.table;
        var MID = req.body.mid;
        UID = JSON.parse(UID);
        console.log(UID);
        async.forEachOf(UID, function (value, key, callback) {
            var ai = UID[key]["Activity ID"];
            var eo = UID[key]["Output"];
            console.log(ai);
            console.log(eo);

            var sql = "INSERT INTO `capstone`.`activity_outputs` (`activity_ID`, `output`) VALUES (?, ?);";
            var values = [ai, eo];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                resp.send("OK");
            }
        })

    },


    AssignActivitiesToMeasurementJSON: function (req, resp) {
        var UID = req.body.table;
        console.log(UID);
        UID = JSON.parse(UID);

        async.forEachOf(UID, function (value, key, callback) {
            var measureID = UID[key]["MeasurementID"];
            var aid = UID[key]["ActivityID"];
            var sql = "INSERT INTO `capstone`.`measurements_activities` (`measurement_ID`, `activity_ID`) VALUES (? , ?); ";
            var values = [measureID, aid];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                resp.send("OK");
            }
        })

    },

    AddMeasurementsJSON: function (req, resp) {
        sess = req.session;
        var UID = req.body.table;
        console.log("--------");
        console.log(UID);
        var mname = req.body.mname;
        var desc = req.body.desc;
        //var group = req.body.group;
        var priority = req.body.priority;
        var gid = req.body.gid;
        var GID = req.body.GID;
        var GNAME = req.body.GName;
        console.log("Hello" + priority);
        UID = JSON.parse(UID);
        var sql2 = " INSERT INTO `capstone`.`measurement` ( `cycle_ID`, `measurement_Name`, `measurement_Description`, `priority_Level`) VALUES ( ?, ?, ?, ?)";
        var values2 = [gid, mname, desc, priority];
        connection.query(sql2, values2, function (err, result) {
            if (err) {
                console.log(err);
            };
            if (result) {
                console.log(result)
                var MID = result.insertId;
                async.forEachOf(UID, function (value, key, callback) {
                    var target = UID[key]["Targets"];
                    var targettype = UID[key]["targettype"];
                    var targetdesc = UID[key]["Target Description"];
                    var sql = " INSERT INTO `capstone`.`measurements_targets` (`measurementID`, `target`, `target_Type`, `target_Desc`) VALUES (?, ?, ?, ?)";
                    var values = [MID, target, targettype, targetdesc];
                    connection.query(sql, values, function (err, result) {
                        if (err) {
                            console.log(err);
                            callback(err);
                        };
                        if (result) {
                            console.log("Measurements = Targets")
                            callback();
                        }
                    });
                }, function (err) {
                    if (err) {
                        console.log("Failed");
                        resp.send("Not OK")
                    } else {
                        console.log("Passed");
                        resp.send("OK");
                        var today = new Date();
                        var current = today.toISOString().split('T')[0];
                        var notifobject = {
                            "body": "Measurements have been created for Goal: " + GNAME, //message body, cannot be null
                            "sender": sess.user[0].User_ID, //ID of sender taken from req session
                            "receiver": "0", //ID of receiver, in this case the user that was created
                            "group": sess.user[0].Group, //Group ID taken from req session
                            "range": "1", //range of notification, refer to the JSONcontroller
                            "admin": "1", // 0 if admin does not need to be notified, else 1
                            "sysadmin": "1", // same as above
                            "triggerdate": current //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                        }
                        Notif.CreateNotif(notifobject);
                    }
                })
            }
        });



    },

    AssignProgressJSON: function (req, resp) {
        sess = req.session;
        var UID = req.body.table;
        UID = JSON.parse(UID);
        var MID = req.body.mid;
        var mname = req.body.mname
        console.log(MID);
        async.forEachOf(UID, function (value, key, callback) {
            var prog = UID[key]["Progress"];
            var tid = UID[key]["TargetID"];
            var sql = "Update capstone.measurements_targets set measurements_targets.progress = ? where measurements_targets.target_ID = ? && measurements_targets.measurementID = ?;";
            var values = [prog, tid, MID];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                resp.send("OK");
                var today = new Date();
                var current = today.toISOString().split('T')[0];
                var notifobject = {
                    "body": "Progress has been declared for Measurement: " + mname, //message body, cannot be null
                    "sender": sess.user[0].User_ID, //ID of sender taken from req session
                    "receiver": "0", //ID of receiver, in this case the user that was created
                    "group": sess.user[0].Group, //Group ID taken from req session
                    "range": "1", //range of notification, refer to the JSONcontroller
                    "admin": "1", // 0 if admin does not need to be notified, else 1
                    "sysadmin": "1", // same as above
                    "triggerdate": current //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                }
                Notif.CreateNotif(notifobject);
            }
        })
    },

    AddCyclesJSON: function (req, resp) {
        sess = req.session;
        var UID = req.body.table;
        var MID = req.body.mid;
        var gname = req.body.GName;
        UID = JSON.parse(UID);
        console.log(UID);
        async.forEachOf(UID, function (value, key, callback) {
            var cn = UID[key]["Cycle Name"];
            var sd = UID[key]["StartDate"];
            var ed = UID[key]["EndDate"];
            var gi = UID[key]["GoalID"];
            var tr = UID[key]["Term"];
            var tt = UID[key]["TotalTerm"];
            console.log(tr);
            console.log(tt);
            console.log(cn);
            console.log(sd);
            console.log(ed);
            console.log(gi);
            var sql = "UPDATE capstone.metric SET cycle_Created = '1' WHERE (metric.metric_ID = ?); INSERT INTO `capstone`.`cycle` (`cycle_Name`, `start_Date`, `end_Date`, `goal_ID`,`termnum`, `totalterm`) VALUES (?, ?, ?, ?, ?, ?);";
            var values = [gi, cn, sd, ed, gi, tr, tt];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                resp.send("OK");
                var today = new Date();
                var current = today.toISOString().split('T')[0];
                var notifobject = {
                    "body": "Cycles have been created for Goal: " + gname, //message body, cannot be null
                    "sender": sess.user[0].User_ID, //ID of sender taken from req session
                    "receiver": "0", //ID of receiver, in this case the user that was created
                    "group": sess.user[0].Group, //Group ID taken from req session
                    "range": "1", //range of notification, refer to the JSONcontroller
                    "admin": "1", // 0 if admin does not need to be notified, else 1
                    "sysadmin": "1", // same as above
                    "triggerdate": current //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                }
                Notif.CreateNotif(notifobject);
            }
        })

    },

    CreateSourcesJSON: function (req, resp) {
        sess = req.session;
        console.log(req.body);
        var SID = req.body.table;
        SID = JSON.parse(SID);
        var sname = req.body.sname;
        var sdesc = req.body.sdesc;
        var sql = "INSERT INTO `capstone`.`source` (`source_Name`, `source_Description`) VALUES (? , ?)";
        var values = [sname, sdesc];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            if (result) {
                console.log("Record Inserted");
                insertdatatypes(result.insertId);
                var today = new Date();
                var current = today.toISOString().split('T')[0];
                var notifobject = {
                    "body": "Source has been created at name: " + sname, //message body, cannot be null
                    "sender": sess.user[0].User_ID, //ID of sender taken from req session
                    "receiver": "0", //ID of receiver, in this case the user that was created
                    "group": sess.user[0].Group, //Group ID taken from req session
                    "range": "1", //range of notification, refer to the JSONcontroller
                    "admin": "1", // 0 if admin does not need to be notified, else 1
                    "sysadmin": "1", // same as above
                    "triggerdate": current //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                }
                Notif.CreateNotif(notifobject);
            }
        });

        function insertdatatypes(id) {
            async.forEachOf(SID, function (value, key, callback) {
                var dtype = SID[key]["Data Types:"];
                var sql = "INSERT INTO capstone.sourcetype (stype_ID, SourceType) VALUES (?,?)";
                var values = [id, dtype];
                connection.query(sql, values, function (err, result) {
                    if (err) callback(err);
                    if (result) {
                        console.log("source = sourcetype")
                        callback();
                    }
                });
            }, function (err) {
                if (err) {
                    console.log("Failed");
                    resp.send("Not OK")
                } else {
                    console.log("Passed");
                    resp.send("OK");
                }
            })

        }
    },

    TestNotif: function (req, resp) {

        //        add this to actions you want to be notified to
        //        range 1 = only receiver gets notified
        //        range 2 = sender and receiver gets notified
        //        range 3 = group gets notified
        //        range 4 = group and sender gets notified
        //        range 5 = everyone gets notified        
        // sample notification creation implementation

        //
        // insert actual route stuff here, when it succeeds initialize the variables on the bottom      
        //        
        var today = new Date();
        var current = today.toISOString().split('T')[0];
        var notifobject = {
            "body": "test notify all", //message body, cannot be null
            "sender": "46", //ID of sender, can be set to null
            "receiver": "47", //ID of receiver
            "group": "1", //Group ID, cannot be null
            "range": "5", //range of notification
            "admin": "1", // 0 if admin does not need to be notified, else 1
            "sysadmin": "1", // same as above
            "triggerdate": current //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
        }

        // call this function to create a notification        
        Notif.CreateNotif(notifobject);



    },


}
