const express = require('express');
const fileUpload = require('express-fileupload');
const server = express();
const fs = require('fs');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const md5 = require('md5');
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

const bcrypt = require('bcrypt');
const saltRounds = 10;
// ----
var sess;
module.exports = {

    Viewusers: function (req, resp) {

        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("SELECT users.User_ID, users.User_First, users.Role, users.User_Last, users.email_address, group.Group_Name, area.Area_Name, roles.Role_Name, users.ContactNo FROM capstone.users join capstone.group on users.Group=group.Group_ID join capstone.roles on users.Role = roles.Role_ID join capstone.area on group.Area_ID = area.Area_ID; SELECT users.Role, users.User_ID, users.User_First, users.User_Last, users.email_address, users.ContactNo FROM capstone.users where users.Group IS NULL; Select users.User_ID from capstone.users", function (err, results, fields) {
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
                } else {
                    passData = {
                        goodStatus: 1,
                        msg: "User/s added"
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
        });
        resp.redirect('/CreateGroup');
    },

    adduser: function (req, resp) {
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
                console.log("Record Inserted");
            });
            resp.redirect('/Createusers');
        });
    },

    edituser: function (req, resp) {
        sess = req.session;
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

    Recommendations: function (req, resp) {
        resp.render('./pages/Recommendations.ejs');
        console.log("Recommendations");
    },

    SendMeasurement: function (req, resp) {
        var qt = req.body.QualityTarget;
        var mn = req.body.MeasurementName;
        var md = req.body.MeasurementDesc;
        var gid = req.body.GoalID;
        var sql = "INSERT INTO `capstone`.`measurement` (`QualityTarget`,`measurement_Name`,`measurement_Description`, `metric_ID`) VALUES (? , ?, ?, ?)";
        var values = [qt, mn, md, gid ];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            resp.redirect('/QualityMetric');
        });
        console.log("INSERTED MEASUREMENT");
    },

    Measurement: function (req, resp) {
        sess = req.session;
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
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("SELECT * FROM capstone.metric; SELECT * FROM capstone.source; SELECT * FROM capstone.group; SELECT * FROM capstone.cycle; SELECT * FROM capstone.measurement;", function (err, results, fields) {
                if (err) throw err;
                if(results){
                resp.render('./pages/QualityMetrics.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    dataD: results[3],
                    dataE: results[4],
                    current_user: sess.user
                });
                }
                console.log(results);
                console.log("QUALITY METRICS NON AJAX");
            });
        }
    },

    addmetric: function (req, resp) {
        var source = (req.body.source);
        var metricName = (req.body.metricName);
        var metricDesc = (req.body.metricDesc);
        var duration = (req.body.duration);
        var startStatus ="Active"
        console.log(metricName);
        console.log(metricDesc);
        console.log(source);
        console.log(duration);
        var sql = "INSERT INTO `capstone`.`metric` (`metric_Name`,`metric_Desc`,`source_ID`, `duration`, `cycle_Status`) VALUES ( ?, ?, ?, ?, ?)";
        var values = [metricName, metricDesc, source, duration, startStatus];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");
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
            resp.redirect('/ViewMetricofSource?SID=' + source);
        });
    },

    Viewcycle: function (req, resp) {
        sess = req.session;
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

    ViewMeasurementDetails: function (req, resp) {

        sess = req.session;
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
            console.log(MID);
            var values = [MID, MID, MID];

            var sql = "SELECT measurement.measurement_ID, measurement.QualityTarget, measurement.Procedures, measurement.measurement_Name, measurement.Deadline, measurement.GroupAssigned FROM capstone.measurement WHERE measurement_ID = ?; SELECT approved_activities.activity_ID, approved_activities.activity_name, approved_activities.target, approved_activities.code, approved_activities.description, approved_activities.measurement_ID, approved_activities.deadline FROM capstone.approved_activities; SELECT pending_activities.activity_ID,pending_activities.activity_name, pending_activities.target, pending_activities.description FROM capstone.pending_activities WHERE measurement_ID = ?;SELECT * FROM capstone.activity_outputs; SELECT * from capstone.measurement; SELECT * FROM capstone.approved_activities; SELECT * FROM capstone.measurements_activities;"

            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                if(results){
                resp.render('./pages/ViewMeasurementDetails.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    dataD: results[3],
                    dataE: results[4],
                    dataF: results[5],
                    dataG: results[6],
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
        var position = "Leader";
        console.log(position);
        var sql = "Update capstone.groupdetails set Groupdetails_Position = ? where Groupdetails_UserID = ? && Groupdetails_ID = ?;";
        var values = [position, UID, GID];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            console.log("updating");
        });
        var position = "Member";
        var sql = "Update capstone.groupdetails set Groupdetails_Position = ? where Groupdetails_UserID != ? && Groupdetails_ID = ?;";
        var values = [position, UID, GID];
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
        var position = "Member";
        var sql = "Update capstone.groupdetails set Groupdetails_Position = ? where Groupdetails_UserID = ? && Groupdetails_ID = ?;";
        var values = [position, UID, GID];
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
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            resp.render('./pages/CreateSource.ejs', {
                current_user: sess.user
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
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var SID = req.query.SID;
            var sql = "Select metric.metric_ID, metric.metric_Name, metric.metric_Desc, metric.priority_Level, metric.date_insert, metric.cycle_ID, group.Group_Name, source.source_Name FROM capstone.metric join capstone.group on metric.group_ID = group.Group_ID join capstone.source on metric.source_ID = source.source_ID where source.source_ID = (?); Select * FROM capstone.source where source.source_ID = ?; SELECT * FROM capstone.group; SELECT * FROM capstone.cycle;"
            var values = [SID, SID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                if (results){
                    resp.render('./pages/ViewMetricofSource.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataD: results[3],
                        current_user: sess.user
                    });
                    console.log(results);
                    console.log("RECOMMENDATION NON AJAX");
                }
            });
        }
    },

    EditSource: function (req, resp) {
        sess = req.session;
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
                resp.redirect('/QualityMetric');
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
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login');
        } else {
            connection.query("SELECT * FROM capstone.documents ;", function (err, results, fields) {
                if (err) throw err;
                if (results){
                    resp.render('./pages/ViewDocument.ejs', {
                        data: results,
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
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var id = (req.query.UID);
            console.log(id);
            var values = [id];
            connection.query("SELECT * FROM capstone.approved_activities where approved_activities.activity_ID=(?); SELECT * FROM capstone.documents", values, function (err, results) {
                if (err) throw err;
                if(results){
                    console.log(results);
                    resp.render('./pages/ActivityDetails.ejs', {
                        data: results[0],
                        dataB: results[1],
                        current_user: sess.user
                    })
                }
            });
        }
    },

    ActivityPendingDetails: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var id = (req.query.UID);
            console.log(id);
            var values = [id, id];
            connection.query("SELECT * FROM capstone.pending_activities where pending_activities.activity_ID=(?); SELECT activity_evidences.activityID, activity_evidences.documentID, documents.Document_ID, documents.Document_Name, documents.Document_Route FROM capstone.activity_evidences join capstone.documents on activity_evidences.documentID = documents.Document_ID where activity_evidences.activityID=(?);", values, function (err, results) {
                if (err) throw err;
                if (results){
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
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("SELECT * FROM capstone.metric; SELECT * FROM capstone.measurement;", function (err, results, fields) {
            if (err) throw err;
            if(results){

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
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("SELECT * FROM capstone.metric; SELECT * FROM capstone.measurement; SELECT * FROM capstone.approved_activities JOIN capstone.measurement WHERE approved_activities.measurement_ID = measurement.measurement_ID; SELECT * FROM capstone.users;", function (err, results, fields) {
                if (err) throw err;
                if(results){
                    resp.render('./pages/home.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataD: results[3],
                        current_user: sess.user
                    });
                    console.log(results);
                    console.log("Dashboards Loaded");
                }
            });
        }
    },

    Assignactivitytomember: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var AID = req.query.AID;
            var GID = req.query.GID;
            var sql = "Select users.User_ID, users.User_First, users.User_Last, users.email_address, users.Role, users.Group, users.ContactNo, users.username FROM capstone.users where users.Group = (?) && users.Role != 1 ; SELECT * FROM capstone.approved_activities WHERE approved_activities.activity_ID = (?);"
            var values = [GID, AID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                console.log(results[1])
                if(results){
                resp.render('./pages/AssignActivityToMember.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    dataD: results[3],
                    current_user: sess.user
                });
                console.log("Assign Activity to Member Page");
                }
            });
        }
    },

}
