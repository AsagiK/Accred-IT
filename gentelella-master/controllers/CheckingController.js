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
// ----
var sess;
module.exports = {

    CheckingPage: function (req, resp) {
        sess = req.session;
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
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("SELECT * FROM capstone.metric; SELECT * FROM capstone.measurement; SELECT * FROM capstone.approved_activities;", function (err, results, fields) {
            if (err) throw err;
            if(results){

                resp.render('./pages/CheckingAccordionPage.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    current_user: sess.user
                });
                console.log(results);
                console.log("Checking Accordion Page loaded");

            }
            });
        }
    }, 
}
