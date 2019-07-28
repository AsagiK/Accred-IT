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
            var sql = "SELECT plansubmissions.Submission_ID, plansubmissions.Plan_ID, plansubmissions.User_ID, plansubmissions.Submission_Title, plansubmissions.Submission_File, plansubmissions.Submission_Description, plansubmissions.Submission_Date, plansubmissions.Submission_Status, plans.PlanName, users.User_First, recommendation.recommendation_ID, recommendation.recommendation_Name FROM capstone.plansubmissions JOIN capstone.plans ON plansubmissions.Plan_ID = plans.Plan_ID JOIN capstone.users ON plansubmissions.User_ID = users.User_ID JOIN capstone.recommendation ON recommendation.recommendation_ID = plans.recommendation_ID; Select * FROM capstone.plans; Select * FROM capstone.recommendation;"
            connection.query(sql, function(err, results, fields){
                if (err) throw err;
                resp.render('./pages/Checking.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results [2],
                    current_user: sess.user
                });
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
            connection.query(sql, values, function(err, results, fields){
                if (err) throw err;
                resp.render('./pages/CheckingDetailsPage.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    current_user: sess.user
                    
                });
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
            connection.query(sql, function(err, results, fields){
                if (err) throw err;
                resp.render('./pages/PreChecking.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results [2],
                    current_user: sess.user
                });
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
            connection.query(sql, values, function(err, results, fields){
                if (err) throw err;
                resp.render('./pages/PreCheckingDetailsPage.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    current_user: sess.user
                    
                });
            });
            console.log("Checking");
            
        }
    },

}
