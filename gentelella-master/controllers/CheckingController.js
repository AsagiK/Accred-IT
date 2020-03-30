const express = require('express');
const fileUpload = require('express-fileupload');
const server = express();
const fs = require('fs');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const md5 = require('md5');
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

    CheckingPage: function (req, resp) {
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
            var sql = "Select metric.metric_ID, metric.metric_Name, metric.metric_Desc, metric.priority_Level, metric.date_insert, metric.cycle_ID, group.Group_Name, source.source_Name FROM capstone.metric join capstone.group on metric.group_ID = group.Group_ID join capstone.source on metric.source_ID = source.source_ID; SELECT * FROM capstone.source; SELECT * FROM capstone.group; SELECT * FROM capstone.cycle;SELECT * FROM capstone.measurement; SELECT * FROM capstone.approved_activities;"
            connection.query(sql, function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    resp.render('./pages/Checking.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataD: results[3],
                        dataE: results[4],
                        dataF: results[5],
                        current_user: sess.user
                    });
                }
                console.log(results[4]);
            });

            console.log("PRE CHECKING PAGE");
        }
    },

    CheckDetails: function (req, resp) {
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
            var SID = (req.query.SID);
            var RID = (req.query.RID);
            var PID = (req.query.PID);
            var sql = "SELECT plansubmissions.Submission_ID, plansubmissions.Plan_ID, plansubmissions.User_ID, plansubmissions.Submission_Title, plansubmissions.Submission_File, plansubmissions.Submission_Description, plansubmissions.Submission_Date, plansubmissions.Submission_Status, plans.PlanName, users.User_First, recommendation.recommendation_ID, recommendation.recommendation_Name FROM capstone.plansubmissions JOIN capstone.plans ON plansubmissions.Plan_ID = plans.Plan_ID JOIN capstone.users ON plansubmissions.User_ID = users.User_ID JOIN capstone.recommendation ON recommendation.recommendation_ID = plans.recommendation_ID WHERE plansubmissions.Submission_ID = ?; Select * FROM capstone.plans WHERE plans.Plan_ID = ?; Select * FROM capstone.recommendation WHERE recommendation.recommendation_ID = ?;"
            var values = [SID, PID, RID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    resp.render('./pages/CheckingDetailsPage.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        current_user: sess.user

                    });
                    console.log(results);
                }
            });
            console.log("Checking");

        }
    },

    PreChecking: function (req, resp) {
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
            var sql = "SELECT plansubmissions.Submission_ID, plansubmissions.Plan_ID, plansubmissions.User_ID, plansubmissions.Submission_Title, plansubmissions.Submission_File, plansubmissions.Submission_Description, plansubmissions.Submission_Date, plansubmissions.Submission_Status, plans.PlanName, users.User_First, recommendation.recommendation_ID, recommendation.recommendation_Name FROM capstone.plansubmissions JOIN capstone.plans ON plansubmissions.Plan_ID = plans.Plan_ID JOIN capstone.users ON plansubmissions.User_ID = users.User_ID JOIN capstone.recommendation ON recommendation.recommendation_ID = plans.recommendation_ID; Select * FROM capstone.plans; Select * FROM capstone.recommendation;"
            connection.query(sql, function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    resp.render('./pages/PreChecking.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        current_user: sess.user
                    });
                }
            });

            console.log("PRE CHECKING PAGE");
        }
    },

    PreCheckingDetails: function (req, resp) {
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
            var SID = (req.query.SID);
            var RID = (req.query.RID);
            var PID = (req.query.PID);
            var sql = "SELECT plansubmissions.Submission_ID, plansubmissions.Plan_ID, plansubmissions.User_ID, plansubmissions.Submission_Title, plansubmissions.Submission_File, plansubmissions.Submission_Description, plansubmissions.Submission_Date, plansubmissions.Submission_Status, plans.PlanName, users.User_First, recommendation.recommendation_ID, recommendation.recommendation_Name FROM capstone.plansubmissions JOIN capstone.plans ON plansubmissions.Plan_ID = plans.Plan_ID JOIN capstone.users ON plansubmissions.User_ID = users.User_ID JOIN capstone.recommendation ON recommendation.recommendation_ID = plans.recommendation_ID WHERE plansubmissions.Submission_ID = ?; Select * FROM capstone.plans WHERE plans.Plan_ID = ?; Select * FROM capstone.recommendation WHERE recommendation.recommendation_ID = ?;"
            var values = [SID, PID, RID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    console.log(results);
                    resp.render('./pages/PreCheckingDetailsPage.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        current_user: sess.user
                    });

                }
            });
            console.log("Checking");

        }
    },

    PreCheckingDetailsInsert: function (req, resp) {

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
            var Comment = req.body.Comment;
            var Status = req.body.Status;
            var SID = req.body.SID;
            var sql = "UPDATE `capstone`.`plansubmissions` SET `Submission_Status` = ?, `Leader_Notes` = ? WHERE (`Submission_ID` = ?);"
            var values = [Status, Comment, SID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    console.log(results);
                    resp.redirect('/PreChecking');
                }
            });

        }

    },

    CheckingDetailsInsert: function (req, resp) {
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
            var Comment = req.body.Comment;
            var Status = req.body.Status;
            var date = req.body.date;
            var SID = req.body.SID;
            var PID = req.body.PID;
            if (Status == "3") {
                console.log("Insert date here")
                var sql = "UPDATE `capstone`.`plans` SET `Deadline` = ? WHERE (`Plan_ID` = ?); UPDATE `capstone`.`plansubmissions` SET `Submission_Status` = ?, `Leader_Notes` = ? WHERE (`Submission_ID` = ?);"
                var values = [date, PID, Status, Comment, SID];
                connection.query(sql, values, function (err, results, fields) {
                    if (err) throw err;
                    if (results) {
                        console.log(results);
                        resp.redirect('/CheckingPage');
                    }
                });
            } else {
                console.log("No insert date here")
                var sql = "UPDATE `capstone`.`plansubmissions` SET `Submission_Status` = ?, `Leader_Notes` = ? WHERE (`Submission_ID` = ?);"
                var values = [Status, Comment, SID];
                connection.query(sql, values, function (err, results, fields) {
                    if (err) throw err;
                    if (results) {
                        console.log(results);
                        resp.redirect('/CheckingPage');
                    }
                });
            }
        }

    }, 

    CheckingAccordionPage: function (req, resp) {
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
            connection.query("SELECT * FROM capstone.metric; SELECT * FROM capstone.measurement; SELECT * FROM capstone.approved_activities;SELECT * FROM capstone.activity_evidences; SELECT * FROM capstone.pending_activities JOIN capstone.users ON pending_activities.user_ID = users.User_ID; SELECT * FROM capstone.measurements_activities; SELECT * FROM capstone.activity_outputs; SELECT * FROM capstone.pending_outputs; SELECT * FROM capstone.group; SELECT * FROM capstone.activity_members; SELECT * FROM capstone.users; SELECT * FROM capstone.activity_members_members; SELECT * FROM capstone.measurements_targets;", function (err, results, fields) {
            if (err) throw err;
            if(results){

                resp.render('./pages/CheckingAccordionPage.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    dataD: results[3],
                    dataE: results[4],
                    dataF: results[5],
                    dataG: results[6],
                    dataH: results[7],
                    dataGroup: results[8],
                    dataAssignedgroup: results[9],
                    dataUsers: results[10],
                    dataAssignedusers: results[11],
                    dataTargets: results[12],
                    current_user: sess.user
                });
                console.log(results);
                console.log("Checking Accordion Page loaded");

            }
            });
        }
    }, 

    CheckingAccordionGroupLeaderPage: function (req, resp) {
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
            connection.query("SELECT * FROM capstone.metric; SELECT * FROM capstone.measurement; SELECT * FROM capstone.approved_activities;SELECT * FROM capstone.activity_evidences; SELECT * FROM capstone.pending_activities JOIN capstone.users ON pending_activities.user_ID = users.User_ID; SELECT * FROM capstone.measurements_activities; SELECT * FROM capstone.activity_outputs; SELECT * FROM capstone.pending_outputs; SELECT * FROM capstone.group; SELECT * FROM capstone.groupdetails; SELECT * FROM capstone.activity_members; SELECT * FROM capstone.users; SELECT * FROM capstone.activity_members_members; SELECT * FROM capstone.measurements_targets;", function (err, results, fields) {
            if (err) throw err;
            if(results){

                resp.render('./pages/CheckingAccordionGroupLeaderPage.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    dataD: results[3],
                    dataE: results[4],
                    dataF: results[5],
                    dataG: results[6],
                    dataH: results[7],
                    dataGroups: results[8],
                    dataGroupDetails: results[9],
                    dataAssignedgroup: results[10],
                    dataUsers: results[11],
                    dataAssignedusers: results[12],
                    dataTargets: results[13],
                    current_user: sess.user
                });
                console.log(results);
                console.log("Checking Accordion Group Leader Page loaded");

            }
            });
        }
    }, 

    ViewActivityEvidences: function (req, resp) {
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
            var id = (req.query.PID);
            console.log(id);
            var values = [id];
            connection.query("SELECT * FROM capstone.pending_activities where pending_activities.pending_ID=(?); SELECT * FROM capstone.documents; SELECT * FROM capstone.activity_evidences;  SELECT * FROM capstone.measurements_targets;", values, function (err, results) {
                if (err) throw err;
                if (results){
                console.log(results);
                    resp.render('./pages/ViewActivityEvidences.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataTargets: results[3],
                        current_user: sess.user
                    })
                }
            });
        }
    }, 

    ViewActivityEvidencesGroupLeaderPage: function (req, resp) {
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
            var id = (req.query.PID);
            console.log(id);
            var values = [id];
            connection.query("SELECT * FROM capstone.pending_activities where pending_activities.pending_ID=(?); SELECT * FROM capstone.documents; SELECT * FROM capstone.activity_evidences; SELECT * FROM capstone.measurements_targets;", values, function (err, results) {
                if (err) throw err;
                if (results){
                console.log(results);
                    resp.render('./pages/ViewActivityEvidencesGroupLeaderPage.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataTargets: results[3],
                        current_user: sess.user
                    })
                }
            });
        }
    }, 

    ProgressPage: function (req, resp) {
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
            var id = (req.query.PID);
            console.log(id);
            var values = [id];
            connection.query("SELECT * FROM capstone.measurement; SELECT * FROM capstone.measurements_targets; SELECT * FROM capstone.group; SELECT * FROM capstone.cycle; SELECT * FROM capstone.metric;", values, function (err, results) {
                if (err) throw err;
                if (results){
                console.log(results);
                    resp.render('./pages/ProgressPage.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataCycle: results[3],
                        dataGoal: results[4],
                        current_user: sess.user
                    })
                }
            });
        }
    }, 

    ProgressDetailsPage: function (req, resp) {
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
            var id = (req.query.MID);
            console.log(id+ "------------------------------------------------------------------------");
            var values = [id, id, id, id];
            connection.query("SELECT * FROM capstone.measurement WHERE measurement_ID=(?); SELECT * FROM capstone.measurements_targets WHERE measurementID=(?); SELECT * FROM capstone.group; SELECT * FROM capstone.documents join activity_evidences on documents.Document_ID = activity_evidences.documentID join pending_activities on activity_evidences.pendingID = pending_activities.pending_ID join approved_activities on pending_activities.activity_ID = approved_activities.activity_ID join measurements_activities on approved_activities.activity_ID = measurements_activities.activity_ID join measurement  on measurement.measurement_ID = measurements_activities.measurement_ID where pending_activities.status = 1 && pending_activities.active = 1 && measurement.measurement_ID = ?; SELECT * FROM capstone.approved_activities JOIN capstone.measurements_activities ON approved_activities.activity_ID = measurements_activities.activity_ID WHERE measurements_activities.measurement_ID = ?;SELECT * FROM capstone.measurements_targets; SELECT * FROM capstone.pending_activities JOIN capstone.users ON pending_activities.user_ID = users.User_ID;", values, function (err, results) {
                if (err) throw err;
                if (results){
                console.log(results[1]);
                    resp.render('./pages/ProgressDetailsPage.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        dataD: results[3],
                        dataActivity: results[4],
                        dataTargets: results[5],
                        dataPending: results[6],
                        current_user: sess.user
                    })
                }
            });
        }
    }, 
    
}
