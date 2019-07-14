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

    Viewusers: function (req, resp) {

        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login');
        } else {

            connection.query("SELECT users.User_ID, users.User_First, users.Role, users.User_Last, users.email_address, group.Group_Name, area.Area_Name, roles.Role_Name, users.ContactNo FROM capstone.users join capstone.group on users.Group=group.Group_ID join capstone.roles on users.Role = roles.Role_ID join capstone.area on group.Area_ID = area.Area_ID; SELECT users.Role, users.User_ID, users.User_First, users.User_Last, users.email_address, users.ContactNo FROM capstone.users where users.Group IS NULL; Select users.User_ID from capstone", function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/Viewusers.ejs', {
                    data: results[0],
                    dataB: results[1],
                    current_user: sess.user
                });
                console.log(results);
            });
            console.log("Viewusers");
        }
    },

    Createusers: function (req, resp) {


        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login');
        } else {

            connection.query("SELECT * FROM capstone.roles where Role_ID > 3; Select users.User_ID from capstone.users;", function (err, results, fields) {
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

    Viewtasks: function (req, resp) {

        connection.query("Select * from capstone.tasks", function (err, result, fields) {
            if (err) throw err;
            console.log(result);

            resp.render('./pages/Viewtasks.ejs', {
                data: result
            });
        });
        console.log("Viewtasks");
    },

    CreateTask: function (req, resp) {
        resp.render('./pages/CreateTask.ejs');
        console.log("CreateTask");
    },

    SubmitTask: function (req, resp) {
        var TN = req.body.TaskName;
        var TD = req.body.TaskDesc;
        var GO = req.body.GenObj;
        var ME = req.body.Measurement;
        var QT = req.body.QT;
        var BS = req.body.BS;
        var PL = req.body.priority;
        var sql = "INSERT INTO `capstone`.`tasks` (`Task_Name`, `Task_Desc`, `GenObj`, `Measurement`, `QT`, `BaseStandard`, `Level` ) VALUES (?, ?, ?, ?, ?, ?, ?);"
        var values = [TN, TD, GO, ME, QT, BS, PL];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");
            resp.redirect("/Viewtasks")
        });


    },

    AssignTask: function (req, resp) {
        connection.query("select users.User_ID, users.User_First, users.USer_Last from capstone.users", function (err, result, fields) {
            if (err) throw err;
            resp.render('./pages/AssignTask.ejs', {
                data: result
            });
            console.log(result);
        });
        console.log("AssignTask");
    },

    ViewGroups: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login');
        } else {

            connection.query("SELECT * FROM capstone.area; SELECT * FROM capstone.group; SELECT users.User_ID, users.User_First, users.User_Last, users.email_address, users.Role, users.Group, users.ContactNo, users.username, roles.Role_Name, groupdetails.Groupdetails_Position FROM capstone.users join capstone.roles on users.Role = roles.Role_ID join capstone.groupdetails on groupdetails.Groupdetails_ID = users.Group && users.User_ID = groupdetails.Groupdetails_UserID", function (err, results, fields) {
                if (err) throw err;
                console.log(results);
                resp.render('./pages/ViewGroups.ejs', {
                    dataA: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    current_user: sess.user
                });
            });

            console.log("ViewGroups");

        }
    },

    CreateGroup: function (req, resp) {

        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login');
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
        var em = (req.body.email);
        var rl = (req.body.role);
        var co = (req.body.contact);
        var count = parseInt(req.body.count) + 1;
        var un = fn + ln + count;
        console.log(un);

        var sql = "INSERT INTO `capstone`.`users` (`User_First`, `User_Last`, `email_address` , `Role`, `ContactNo`, `username`) VALUES (? , ? , ? , ? , ?, ?)";
        var values = [fn, ln, em, rl, co, un];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");
        });

        resp.redirect('/Createusers');
    },

    edituser: function (req, resp) {
        var id = (req.query.UID);
        console.log(id);
        var values = [id];
        connection.query("SELECT * FROM capstone.users where users.User_ID = (?); SELECT * FROM capstone.roles where Role_ID > 1;", values, function (err, results) {
            if (err) throw err;
            console.log(results);
            resp.render('./pages/EditUser.ejs', {
                data: results[0],
                dataB: results[1]
            })
        });
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
        });
        console.log("updating");
        setTimeout(function () {
            resp.redirect('/Viewusers');
        }, 3000);
    },

    Recommendations: function (req, resp) {
        resp.render('./pages/Recommendations.ejs');
        console.log("Recommendations");
    },

    SendPlan: function (req, resp) {
        var go = req.body.GenObj;
        var me = req.body.PlanM;
        var tn = req.body.BaseFormula;
        var qt = req.body.QualityTarget;
        var pr = req.body.Procedures;
        var pl = "High";
        var bs = "No base standard assigned"
        var RID = req.body.RID;
        var GID = req.body.GID;
        var pn = req.body.PlanName;
        var pd = req.body.PlanD;
        console.log(go);
        console.log(me);
        console.log(tn);
        console.log(qt);
        console.log(pr);
        console.log(pl);
        console.log(bs);
        console.log(RID);
        console.log(pn);
        console.log(pd);
        var sql = "INSERT INTO `capstone`.`plans` (`GenObjective`, `Measurement`, `BaseFormula`, `QualityTarget`, `Procedures`,`PriorityLevel`,`BaseStandard`, `recommendation_ID`,`PlanName`,`PlanDescription`, `GroupAssigned`) VALUES (? , ? , ? , ?, ?, ?, ?, ?,?,?,?)";
        var values = [go, me, tn, qt, pr, pl, bs, RID, pn, pd, GID];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            resp.redirect('/PlanPage?PID=' + RID);
        });
    },

    Planning: function (req, resp) {
        var PlanID = req.query.PID;
        var sql = "Select plans.Plan_ID, plans.PlanName, plans.PlanDescription, group.Group_Name, cycle.cycle_Name, plans.PriorityLevel FROM capstone.plans join capstone.cycle on plans.CycleTime = cycle.Cycle_ID join capstone.group on plans.GroupAssigned = group.Group_ID where recommendation_ID = ?; Select recommendation.recommendation_ID, Recommendation.group_ID, recommendation.recommendation_Name from capstone.recommendation where recommendation_ID = ?;"
        var values = [PlanID, PlanID];
        connection.query(sql, values, function (err, results, fields) {
            if (err) throw err;
            resp.render('./pages/PlanPage.ejs', {
                data: results[0],
                dataB: results[1],
            });
            console.log(results);
        });
    },

    RecommendationNonAjax: function (req, resp) {
        connection.query("Select recommendation.recommendation_ID, recommendation.recommendation_Name, recommendation.recommendation_Desc, recommendation.recommendation_Grade, recommendation.priority_Level, recommendation.date_insert, recommendation.area_ID, area.Area_Name, group.Group_Name  FROM capstone.recommendation join capstone.area on recommendation.area_ID = area.Area_ID join capstone.group on recommendation.group_ID = group.Group_ID; Select * FROM capstone.area;", function (err, results, fields) {
            if (err) throw err;
            resp.render('./pages/RecommendationNonAjax.ejs', {
                data: results[0],
                dataB: results[1]
            });
            console.log(results);
            console.log("RECOMMENDATION NON AJAX");
        });
    },

    addrecommendation: function (req, resp) {
        var recommendationName = (req.body.recommendationName);
        var recommendationDesc = (req.body.recommendationDesc);
        var grade = (req.body.grade);
        var priority = (req.body.priority);
        var area = (req.body.SelectArea);
        var today = new Date();
        //var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        //var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
        //var dateTime = date+' '+time;
        var current = today.toISOString().split('T')[0];
        console.log(today);
        console.log(recommendationName);
        console.log(recommendationDesc);
        console.log(grade);
        console.log(priority);
        console.log(area);
        console.log(current);
        var sql = "INSERT INTO `capstone`.`recommendation` (`recommendation_Name`, `recommendation_Desc`, `recommendation_Grade` , `priority_Level`, `date_insert`, `area_ID`) VALUES (? , ? , ? , ?, ?, ?)";
        var values = [recommendationName, recommendationDesc, grade, priority, current, area];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");
            resp.redirect('/RecommendationNonAjax');
        });
    },

    Viewcycle: function (req, resp) {
        connection.query("Select * FROM capstone.cycle;", function (err, results, fields) {
            if (err) throw err;
            resp.render('./pages/Viewcycle.ejs', {
                data: results
            });
            console.log("View Cycle Page");
        });
    },

    addcycle: function (req, resp) {
        var cyclename = (req.body.cycleName);
        var date = (req.body.date);
        var startDate = '';
        var startYear = date.substr(6, 4);
        var startMonth = date.substr(0, 2);
        var startDay = date.substr(3, 2);
        console.log(cyclename);
        console.log(date);
        startDate = startYear + "-" + startMonth + "-" + startDay;
        console.log("Start Date: " + startDate);
        var sql = "INSERT INTO `capstone`.`cycle` (`cycle_Name`, `start_Date`) VALUES (? , ?)";
        var values = [cyclename, startDate];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");
            resp.redirect('/RecommendationNonAjax');
        });

    },

    editrecommendation: function (req, resp) {
        var RID = req.query.UID;
        var AID = req.query.AID;
        var sql = "Select recommendation.recommendation_ID, recommendation.recommendation_Name, recommendation.recommendation_Desc, recommendation.recommendation_Grade, recommendation.priority_Level, recommendation.date_insert, recommendation.area_ID, recommendation.group_ID, area.Area_Name, group.Group_ID, group.Group_Name, group.Area_ID  FROM capstone.recommendation join capstone.area on recommendation.area_ID = area.Area_ID join capstone.group on recommendation.group_ID = group.Group_ID where recommendation.recommendation_ID = ?; Select group.Group_ID, group.Group_Name, group.Area_ID FROM capstone.group where group.Area_ID = ?;"
        var values = [RID, AID]
        connection.query(sql, values, function (err, results, fields) {
            if (err) throw err;
            resp.render('./pages/EditRecommendation.ejs', {
                data: results[0],
                dataB: results[1]
            });
            console.log(results);
            console.log("Edit Recommendation Page");
        });
    },

    alterrecommendation: function (req, resp) {
        var id = (req.body.UID);
        var name = (req.body.recommendationName);
        var desc = (req.body.recommendationDesc);
        var grade = (req.body.grade);
        var priority = (req.body.priority);
        var AID = (req.body.AID);
        var GID = (req.body.group);
        var date = new Date();
        var current = date.toISOString().split('T')[0];
        console.log(id);
        console.log(name);
        console.log(desc);
        console.log(grade);
        console.log(priority);
        var sql = "Update capstone.recommendation set recommendation_Name = ?, recommendation_Desc = ?, recommendation_Grade = ?, priority_Level = ?, date_insert = ?, area_ID = ?, group_ID = ? where recommendation_ID = ?";
        var values = [name, desc, grade, priority, current, AID, GID, id];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
        });
        console.log("updating");
        setTimeout(function () {
            resp.redirect('/RecommendationNonAjax');
        }, 3000);
    },

    assignplantogroup: function (req, resp) {
        var id = (req.body.UID);
        var idrecommendation = (req.body.UIDRecommendation);
        console.log(id);
        var values = [id, idrecommendation];
        connection.query("SELECT * FROM capstone.plans where plans.Plan_ID = ?; SELECT group.Group_ID, group.Group_Name, area.Area_Name FROM capstone.group join capstone.area on group.Area_ID = area.Area_ID; SELECT * FROM capstone.cycle; SELECT * FROM capstone.recommendation where recommendation_ID = ?;", values, function (err, results) {
            if (err) throw err;
            console.log(results);
            resp.render('./pages/AssignPlanToGroup.ejs', {
                data: results[0],
                dataB: results[1],
                dataC: results[2],
                dataD: results[3]
            })
        });

        console.log("Edit Recommendations Page");
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
        var GID = req.query.GID;
        var sql = "Select users.User_ID, users.User_First, users.User_Last, users.email_address, users.Role, users.Group, users.ContactNo, users.username FROM capstone.users where users.Group is null ; SELECT group.Group_ID, group.Group_Name, area.Area_Name FROM capstone.group join capstone.area on group.Area_ID = area.Area_ID where group.Group_ID = ?;"
        var values = [GID];
        connection.query(sql, values, function (err, results, fields) {
            if (err) throw err;
            console.log(results[1])
            resp.render('./pages/AssignMemberToGroup.ejs', {
                data: results[0],
                dataB: results[1]
            });
            console.log("Assign Member to Group Page");
        });
    },


    ViewAllPlans: function (req, resp) {

        connection.query("SELECT * FROM capstone.plans;", function (err, results, fields) {
            if (err) throw err;
            resp.render('./pages/ViewAllPlans.ejs', {
                data: results
            });
            console.log(results);
        });
        console.log("ViewAllPlans");
    },

    ViewPlanDetails: function (req, resp) {
        connection.query("SELECT plans.GenObjective, plans.Measurement, plans.BaseFormula, plans.BaseStandard, plans.QualityTarget, plans.Procedures, plans.CycleTime, plans.PriorityLevel, plans.PlanName, cycle.start_date, cycle.end_date From capstone.plans,capstone.cycle Where Plan_ID=1 and cycle_ID=1;", function (err, results, fields) {
            if (err) throw err;
            resp.render('./pages/ViewPlanDetails.ejs', {
                data: results
            });
            console.log(results);
        });
        console.log("ViewPlanDetails");
    },


    edittask: function (req, resp) {
        var id = (req.query.TID);
        console.log(id);
        var values = [id];
        connection.query("SELECT * FROM capstone.tasks where tasks.task_ID = (?);", values, function (err, results) {
            if (err) throw err;
            console.log(results);
            resp.render('./pages/EditTask.ejs', {
                data: results
            })
        });
    },

    altertask: function (req, resp) {
        var ID = req.body.taskID;
        var TN = req.body.TaskName;
        var TD = req.body.TaskDesc;
        var GO = req.body.GenObj;
        var ME = req.body.Measurement;
        var QT = req.body.QT;
        var BS = req.body.BS;
        var PL = req.body.priority;
        var sql = "Update capstone.tasks set Task_Name = ?, Task_Desc = ?, GenObj = ?, Measurement= ?, QT = ?, BaseStandard = ?, Level = ? where task_ID = ? ";
        var values = [TN, TD, GO, ME, QT, BS, PL, ID];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
        });
        console.log("updating");
        setTimeout(function () {
            resp.redirect('/Viewtasks');
        }, 3000);
    },

    AssignRecommendationToGroup: function (req, resp) {
        var RID = req.query.UID;
        var AID = req.query.AID;
        var sql = "Select recommendation.recommendation_ID, recommendation.recommendation_Name, recommendation.recommendation_Desc, recommendation.recommendation_Grade, recommendation.priority_Level, recommendation.date_insert, recommendation.area_ID, area.Area_Name, group.Group_ID, group.Group_Name, group.Area_ID  FROM capstone.recommendation join capstone.area on recommendation.area_ID = area.Area_ID join capstone.group on recommendation.group_ID = group.Group_ID where recommendation.recommendation_ID = ?; Select group.Group_ID, group.Group_Name, group.Area_ID FROM capstone.group where group.Area_ID = ?;"
        var values = [RID, AID]
        connection.query(sql, values, function (err, results, fields) {
            if (err) throw err;
            resp.render('./pages/AssignRecommendationToGroup.ejs', {
                data: results[0],
                dataB: results[1]
            });
            console.log(results);
            console.log("Assign Recommendation to Group");
        });
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
            resp.redirect('/ViewGroups');
        });
        console.log("updating");
        setTimeout(function () {

        }, 3000);
    },

    makeMember: function (req, resp) {
        var UID = req.body.UID;
        var GID = req.body.GID;
        var position = "Member";
        var sql = "Update capstone.groupdetails set Groupdetails_Position = ? where Groupdetails_UserID = ? && Groupdetails_ID = ?;";
        var values = [position, UID, GID];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
        });
        console.log("updating");
        setTimeout(function () {
            resp.redirect('/ViewGroups');
        }, 3000);
    },

}
