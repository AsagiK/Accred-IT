const express = require('express');
const fileUpload = require('express-fileupload');
const server = express();
const fs = require('fs');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const md5 = require('md5');
const async = require("async");
var mysql = require('mysql');
var connection = require('../db');
// ---- URL PARSER
var url = require('url');
var session = require('express-session');
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
        var UID = req.body.table;
        UID = JSON.parse(UID);
        async.forEachOf(UID, function (value, key, callback) {
            var gid = UID[key]["Group ID"];
            var uid = UID[key]["User ID"];
            var sql = "Update capstone.users set users.Group = ? where users.User_ID = ?; INSERT INTO `capstone`.`groupdetails` (`Groupdetails_ID`, `Groupdetails_UserID`) VALUES (? , ? ); ";
            var values = [gid, uid, gid, uid];
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
        console.log(req.body);
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
            console.log(an);
            var sql = "INSERT INTO `capstone`.`approved_activities` (`activity_name`, `description`, `deadline`) VALUES (?, ?, ?);";
            var values = [an, desc, dead];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
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
        var UID = req.body.table;
        console.log("--------");
        console.log(UID);
        var mname = req.body.mname;
        var desc = req.body.desc;
        var group = req.body.group;
        var gid = req.body.gid;
        UID = JSON.parse(UID);
        var sql2 = " INSERT INTO `capstone`.`measurement` (`GroupAssigned`, `cycle_ID`, `measurement_Name`, `measurement_Description`) VALUES (?, ?, ?, ?)";
        var values2 = [group, gid, mname, desc]
        connection.query(sql2, values2, function (err, result) {
            if (err){
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
                    }
                })
            }
        });



    },

    AssignProgressJSON: function (req, resp) {
        var UID = req.body.table;
        UID = JSON.parse(UID);
        var MID = req.body.mid;
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
            }
        })
    },

    AddCyclesJSON: function (req, resp) {
        var UID = req.body.table;
        var MID = req.body.mid;
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
            var sql = "INSERT INTO `capstone`.`cycle` (`cycle_Name`, `start_Date`, `end_Date`, `goal_ID`,`termnum`, `totalterm`) VALUES (?, ?, ?, ?, ?, ?);";
            var values = [cn, sd, ed, gi, tr, tt];
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

    CreateSourcesJSON: function (req, resp) {
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
                insertdatatypes(result.insertId)
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
    }

}
