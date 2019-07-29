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
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("select users.User_ID, users.User_First, users.USer_Last from capstone.users", function (err, result, fields) {
                if (err) throw err;
                resp.render('./pages/AssignTask.ejs', {
                    data: result,
                    current_user: sess.user
                });
                console.log(result);
            });
            console.log("AssignTask");
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
        var PlanID = req.query.PID;
        console.log(PlanID);
        var sql = "Select plans.Plan_ID, plans.PlanName, plans.PlanDescription, plans.GroupAssigned, group.Group_Name, cycle.cycle_Name, cycle.start_Date, plans.PriorityLevel, plans.Deadline FROM capstone.plans join capstone.cycle on plans.CycleTime = cycle.Cycle_ID join capstone.group on plans.GroupAssigned = group.Group_ID where recommendation_ID = ?; Select recommendation.recommendation_ID, Recommendation.group_ID, recommendation.recommendation_Name from capstone.recommendation where recommendation_ID = ?; SELECT * FROM capstone.cycle;"
        var values = [PlanID, PlanID];
        connection.query(sql, values, function (err, results, fields) {
            if (err) throw err;
            if (results) {
                resp.render('./pages/PlanPage.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    notif: passData,
                    current_user: sess.user
                });
            }
            console.log(results);
        });
        }
    },

    RecommendationNonAjax: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("Select recommendation.recommendation_ID, recommendation.recommendation_Name, recommendation.recommendation_Desc, recommendation.recommendation_Grade, recommendation.priority_Level, recommendation.date_insert, recommendation.area_ID, area.Area_Name, group.Group_Name, accreditation.accreditation_Name FROM capstone.recommendation join capstone.area on recommendation.area_ID = area.Area_ID join capstone.group on recommendation.group_ID = group.Group_ID join capstone.accreditation on recommendation.accreditation_ID = accreditation.accreditation_ID; Select * FROM capstone.area;SELECT * FROM capstone.accreditation", function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/RecommendationNonAjax.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    current_user: sess.user
                });
                console.log(results);
                console.log("RECOMMENDATION NON AJAX");
            });
        }
    },

    addrecommendation: function (req, resp) {
        var accreditation = (req.body.accreditation);
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
        var sql = "INSERT INTO `capstone`.`recommendation` (`recommendation_Name`, `recommendation_Desc`, `recommendation_Grade` , `priority_Level`, `date_insert`, `area_ID`, `accreditation_ID`) VALUES (? , ? , ? , ?, ?, ?, ?)";
        var values = [recommendationName, recommendationDesc, grade, priority, current, area, accreditation];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");
            resp.redirect('/RecommendationNonAjax');
        });
    },
    addrecommendationtoaccreditation: function (req, resp) {
        var accreditation = (req.body.accreditation);
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
        var sql = "INSERT INTO `capstone`.`recommendation` (`recommendation_Name`, `recommendation_Desc`, `recommendation_Grade` , `priority_Level`, `date_insert`, `area_ID`, `accreditation_ID`) VALUES (? , ? , ? , ?, ?, ?, ?)";
        var values = [recommendationName, recommendationDesc, grade, priority, current, area, accreditation];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");
            resp.redirect('/ViewRecommendationsofAccreditation?AID=' + accreditation);
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
            resp.redirect('/RecommendationNonAjax');
        });
    },

    editrecommendation: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var RID = req.query.UID;
            var AID = req.query.AID;
            var sql = "Select recommendation.recommendation_ID, recommendation.recommendation_Name, recommendation.recommendation_Desc, recommendation.recommendation_Grade, recommendation.priority_Level, recommendation.date_insert, recommendation.area_ID, recommendation.group_ID, area.Area_Name, group.Group_ID, group.Group_Name, group.Area_ID  FROM capstone.recommendation join capstone.area on recommendation.area_ID = area.Area_ID join capstone.group on recommendation.group_ID = group.Group_ID where recommendation.recommendation_ID = ?; Select group.Group_ID, group.Group_Name, group.Area_ID FROM capstone.group where group.Area_ID = ?;"
            var values = [RID, AID]
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/EditRecommendation.ejs', {
                    data: results[0],
                    dataB: results[1],
                    current_user: sess.user
                });
                console.log(results);
                console.log("Edit Recommendation Page");
            });
        }
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
            if (result) {
                resp.redirect('/RecommendationNonAjax');
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

    ViewAllPlans: function (req, resp) {

        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            connection.query("SELECT * FROM capstone.plans;", function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/ViewAllPlans.ejs', {
                    data: results,
                    current_user: sess.user
                });
                console.log(results);
            });
            console.log("ViewAllPlans");
        }
    },

    ViewPlanDetails: function (req, resp) {

        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
        var PID = (req.query.PID);
        console.log(PID);
        var values = [PID];
        var sql = "SELECT plans.Plan_ID ,plans.GenObjective, plans.Measurement, plans.BaseFormula, plans.BaseStandard, plans.QualityTarget, plans.Procedures, plans.CycleTime, plans.PriorityLevel, plans.PlanName, plans.Plan_MinCycles, plans.Deadline, plans.CycleCount, cycle.start_date, cycle.cycle_Name From capstone.plans join capstone.cycle on plans.CycleTime = cycle.cycle_ID where Plan_ID = ?;"
        connection.query(sql, values, function (err, results, fields) {
            if (err) throw err;
            resp.render('./pages/ViewPlanDetails.ejs', {
                data: results, current_user: sess.user
            })
            console.log(results);
        });
        console.log("ViewPlanDetails");
        }

    },

    edittask: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var id = (req.query.TID);
            console.log(id);
            var values = [id];
            connection.query("SELECT * FROM capstone.tasks where tasks.task_ID = (?);", values, function (err, results) {
                if (err) throw err;
                console.log(results);
                resp.render('./pages/EditTask.ejs', {
                    data: results,
                    current_user: sess.user
                })
            });
        }
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
            if (result) {
                resp.redirect('/Viewtasks');
            }
            console.log(result);
        });
        console.log("updating");
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

    CreateAccreditation: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            resp.render('./pages/CreateAccreditation.ejs', {
                current_user: sess.user
            });
            console.log("CREATE ACCREDITATION");
        }
    },

    AddAccreditation: function (req, resp) {
        console.log(req.body);
        var an = (req.body.accreditname);
        var ad = (req.body.accreditdesc);
        var sql = "INSERT INTO `capstone`.`accreditation` (`accreditation_Name`, `accreditation_Description`) VALUES (? , ?)";
        var values = [an, ad];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            if(result){
                resp.redirect('/CreateGrades');
                console.log("Record Inserted");
            }
        });
        
    },

    ViewAccreditation: function (req, resp) {
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
            connection.query("SELECT * FROM capstone.accreditation;", function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/ViewAccreditation.ejs', {
                    data: results,
                    current_user: sess.user,
                    notif: passData
                });
                console.log(results);
            });
            console.log("VIEW ACCREDITATION");
        }
    },

    ViewRecommendationsofAccreditation: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var AID = req.query.AID;
            var sql = "Select recommendation.recommendation_ID, recommendation.recommendation_Name, recommendation.recommendation_Desc, recommendation.recommendation_Grade, recommendation.priority_Level, recommendation.date_insert, recommendation.area_ID, area.Area_Name, group.Group_Name, accreditation.accreditation_Name FROM capstone.recommendation join capstone.area on recommendation.area_ID = area.Area_ID join capstone.group on recommendation.group_ID = group.Group_ID join capstone.accreditation on recommendation.accreditation_ID = accreditation.accreditation_ID where accreditation.accreditation_ID = ?; Select * FROM capstone.area; Select * FROM capstone.accreditation where accreditation.accreditation_ID = ?;"
            var values = [AID, AID];
            connection.query(sql, values, function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/ViewRecommendationofAccreditation.ejs', {
                    data: results[0],
                    dataB: results[1],
                    dataC: results[2],
                    current_user: sess.user
                });
                console.log(results);
                console.log("RECOMMENDATION NON AJAX");
            });
        }
    },

    EditAccreditation: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var id = (req.query.AID);
            console.log(id);
            var values = [id];
            connection.query("SELECT * FROM capstone.accreditation where accreditation.accreditation_ID = (?);", values, function (err, results) {
                if (err) throw err;
                console.log(results);
                resp.render('./pages/EditAccreditation.ejs', {
                    data: results,
                    current_user: sess.user
                })
            });
        }
    },

    AlterAccreditation: function (req, resp) {
        var id = (req.body.AID);
        var an = (req.body.accreditname);
        var ad = (req.body.accreditdesc);
        console.log(id);
        console.log(an);
        console.log(ad);
        var sql = "Update capstone.accreditation set accreditation_Name = ?, accreditation_Description = ? where accreditation_ID = ? ";
        var values = [an, ad, id];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result);
            if (result) {
                resp.redirect('/ViewAccreditation');
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

}
