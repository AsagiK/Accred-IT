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
// ---- DEFINE SESSION
server.use(session({
    secret: 'ssshhhhh',
    resave: false,
    saveUninitialized: true
}));
// ----
var sess;

module.exports = {

    CreateNotif: function (data) {
        console.log("notif called")
        var notif = data;
        const Message = notif.body;
        const Sender = notif.sender;
        const Receiver = notif.receiver;
        const Group = notif.group;
        const Range = notif.range;
        const Admin = notif.admin;
        const Sysadmin = notif.sysadmin;
        const Triggerdate = notif.triggerdate;

        if (notif.isactivity) {
                console.log("ACTIVITY NOTIF");
                var sql = "INSERT INTO `capstone`.`notifications` (`message`, `sender`, `receiver`, `group_id`, `range`, `admin`, `sysadmin`, `triggerdate`, `isactivity`) VALUES (?,?,?,?,?,?,?,?,?);"
                var values = [Message, Sender, Receiver, Group, Range, Admin, Sysadmin, Triggerdate, notif.isactivity]
                connection.query(sql, values, function (err, result) {
                    if (err) console.log(err);
                    if (result && Range != 5) {
                        checkrange(Sender, Range, result.insertId, 1);
                        admin(Admin, result.insertId);
                        sysadmin(Sysadmin, result.insertId);
                        console.log("notif added")
                    } else {
                        checkrange(Sender, Range, result.insertId, 1);
                        console.log("notif added")
                    }
                });
                console.log(notif)
        } else {
            if (Triggerdate.length > 0) {
                var sql = "INSERT INTO `capstone`.`notifications` (`message`, `sender`, `receiver`, `group_id`, `range`, `admin`, `sysadmin`, `triggerdate`) VALUES (?,?,?,?,?,?,?,?);"
                var values = [Message, Sender, Receiver, Group, Range, Admin, Sysadmin, Triggerdate]
                connection.query(sql, values, function (err, result) {
                    if (err) console.log(err);
                    if (result && Range != 5) {
                        checkrange(Sender, Range, result.insertId, 0);
                        admin(Admin, result.insertId);
                        sysadmin(Sysadmin, result.insertId);
                        console.log("notif added")
                    } else {
                        checkrange(Sender, Range, result.insertId, 0);
                        console.log("notif added")
                    }
                });
                console.log(notif)
            } else {
                var sql = "INSERT INTO `capstone`.`notifications` (`message`, `sender`, `receiver`, `group_id`, `range`, `admin`, `sysadmin`) VALUES (?,?,?,?,?,?,?);"
                var values = [Message, Sender, Receiver, Group, Range, Admin, Sysadmin]
                connection.query(sql, values, function (err, result) {
                    if (err) console.log(err);
                    if (result && Range != 5) {
                        checkrange(Sender, Range, result.insertId, 0);
                        admin(Admin, result.insertId);
                        sysadmin(Sysadmin, result.insertId);
                        console.log("notif added")
                    } else {
                        checkrange(Sender, Range, result.insertId, 0);
                        console.log("notif added")
                    }
                });
                console.log(notif)
            }
        }


        function checkrange(sender, range, insertid, checkactivity) {
            console.log("range condition " + range)
            if (checkactivity == 1) {
                if (range == 1) {
                    var sql = "INSERT INTO `capstone`.`notifications_read` (`Notifications_ID`, `Recipient_ID`, `notif_read`) VALUES (?,?,?);"
                    var values = [insertid, Receiver, 1]
                    connection.query(sql, values, function (err, result) {
                        if (err) console.log(err);
                        if (result) {
                            console.log("range type 1")
                        }
                    });
                } else if (range == 2) {
                    var sql = "INSERT INTO `capstone`.`notifications_read` (`Notifications_ID`, `Recipient_ID`, `notif_read`) VALUES ?;"
                    var values = [
                    [insertid, Receiver, 1],
                    [insertid, Sender, 1]
                ];
                    connection.query(sql, [values], function (err, result) {
                        if (err) console.log(err);
                        if (result) {
                            console.log("range type 2")
                        }
                    });
                } else if (range > 2 && range < 5) {
                    console.log("range type 3 - 4")
                    const sql = "SELECT * FROM capstone.users where users.Group = ?;"
                    const value = [Group];
                    connection.query(sql, value, function (err, result, fields) {
                        if (err) throw err;
                        if (result) {
                            var resdata = JSON.parse(JSON.stringify(result))
                            async.forEachOf(resdata, function (value, key, callback) {
                                var ui = resdata[key]["User_ID"];
                                const sql2 = "INSERT INTO `capstone`.`notifications_read` (`Notifications_ID`, `Recipient_ID`, `notif_read`) VALUES (?,?,?);"
                                const values = [insertid, ui,1];
                                if (range == 3) {
                                    if (ui != Sender) {
                                        connection.query(sql2, values, function (err, result) {
                                            if (err) callback(err);
                                            if (result) callback();
                                            console.log("individual group notif sent")
                                        })
                                    } else {
                                        console.log("Sender skipped");
                                    }
                                } else {
                                    connection.query(sql2, values, function (err, result) {
                                        if (err) callback(err);
                                        if (result) callback();
                                        console.log("individual group notif sent")
                                    })

                                }

                            }, function (err) {
                                if (err) {
                                    console.log("Failed");
                                    console.log(err);
                                } else {
                                    console.log("Group Notif sent");
                                }
                            })
                        }
                    })
                } else {
                    console.log("range type 5")
                    const sql = "SELECT * FROM capstone.users;"
                    const value = [Group];
                    connection.query(sql, value, function (err, result, fields) {
                        if (err) throw err;
                        if (result) {
                            var resdata = JSON.parse(JSON.stringify(result))
                            async.forEachOf(resdata, function (value, key, callback) {
                                var ui = resdata[key]["User_ID"];
                                const sql2 = "INSERT INTO `capstone`.`notifications_read` (`Notifications_ID`, `Recipient_ID`, `notif_read`) VALUES (?,?,?);"
                                const values = [insertid, ui,1];

                                connection.query(sql2, values, function (err, result) {
                                    if (err) callback(err);
                                    if (result) callback();
                                    console.log("individual group notif sent")
                                })
                            }, function (err) {
                                if (err) {
                                    console.log("Failed");
                                    console.log(err);
                                } else {
                                    console.log("Notif to all sent");
                                }
                            })
                        }
                    })

                }
            } else {
                if (range == 1) {
                    var sql = "INSERT INTO `capstone`.`notifications_read` (`Notifications_ID`, `Recipient_ID`) VALUES (?,?);"
                    var values = [insertid, Receiver]
                    connection.query(sql, values, function (err, result) {
                        if (err) console.log(err);
                        if (result) {
                            console.log("range type 1")
                        }
                    });
                } else if (range == 2) {
                    var sql = "INSERT INTO `capstone`.`notifications_read` (`Notifications_ID`, `Recipient_ID`) VALUES ?;"
                    var values = [
                    [insertid, Receiver],
                    [insertid, Sender]
                ];
                    connection.query(sql, [values], function (err, result) {
                        if (err) console.log(err);
                        if (result) {
                            console.log("range type 2")
                        }
                    });
                } else if (range > 2 && range < 5) {
                    console.log("range type 3 - 4")
                    const sql = "SELECT * FROM capstone.users where users.Group = ?;"
                    const value = [Group];
                    connection.query(sql, value, function (err, result, fields) {
                        if (err) throw err;
                        if (result) {
                            var resdata = JSON.parse(JSON.stringify(result))
                            async.forEachOf(resdata, function (value, key, callback) {
                                var ui = resdata[key]["User_ID"];
                                const sql2 = "INSERT INTO `capstone`.`notifications_read` (`Notifications_ID`, `Recipient_ID`) VALUES (?,?);"
                                const values = [insertid, ui];
                                if (range == 3) {
                                    if (ui != Sender) {
                                        connection.query(sql2, values, function (err, result) {
                                            if (err) callback(err);
                                            if (result) callback();
                                            console.log("individual group notif sent")
                                        })
                                    } else {
                                        console.log("Sender skipped");
                                    }
                                } else {
                                    connection.query(sql2, values, function (err, result) {
                                        if (err) callback(err);
                                        if (result) callback();
                                        console.log("individual group notif sent")
                                    })

                                }

                            }, function (err) {
                                if (err) {
                                    console.log("Failed");
                                    console.log(err);
                                } else {
                                    console.log("Group Notif sent");
                                }
                            })
                        }
                    })
                } else {
                    console.log("range type 5")
                    const sql = "SELECT * FROM capstone.users;"
                    const value = [Group];
                    connection.query(sql, value, function (err, result, fields) {
                        if (err) throw err;
                        if (result) {
                            var resdata = JSON.parse(JSON.stringify(result))
                            async.forEachOf(resdata, function (value, key, callback) {
                                var ui = resdata[key]["User_ID"];
                                const sql2 = "INSERT INTO `capstone`.`notifications_read` (`Notifications_ID`, `Recipient_ID`) VALUES (?,?);"
                                const values = [insertid, ui];

                                connection.query(sql2, values, function (err, result) {
                                    if (err) callback(err);
                                    if (result) callback();
                                    console.log("individual group notif sent")
                                })
                            }, function (err) {
                                if (err) {
                                    console.log("Failed");
                                    console.log(err);
                                } else {
                                    console.log("Notif to all sent");
                                }
                            })
                        }
                    })

                }
            }

        }


        function admin(Admin, insertid) {
            if (Admin == 1) {
                var sql = "SELECT * FROM capstone.users where users.Role = 2;"
                connection.query(sql, function (err, result, fields) {
                    var resdata = JSON.parse(JSON.stringify(result))
                    async.forEachOf(resdata, function (value, key, callback) {
                        var ui = resdata[key]["User_ID"];
                        const sql2 = "INSERT INTO `capstone`.`notifications_read` (`Notifications_ID`, `Recipient_ID`) VALUES (?,?);"
                        const values = [insertid, ui];
                        connection.query(sql2, values, function (err, result) {
                            if (err) callback(err);
                            if (result) callback();
                        })
                    }, function (err) {
                        if (err) {
                            console.log("Failed");
                            console.log(err);
                        } else {
                            console.log("Admins Notified");
                        }
                    })
                })
            }
        }

        function sysadmin(Sysadmin, insertid) {
            if (Sysadmin == 1) {
                var sql = "SELECT * FROM capstone.users where users.Role = 1;"
                connection.query(sql, function (err, result, fields) {
                    var resdata = JSON.parse(JSON.stringify(result))
                    async.forEachOf(resdata, function (value, key, callback) {
                        var ui = resdata[key]["User_ID"];
                        const sql2 = "INSERT INTO `capstone`.`notifications_read` (`Notifications_ID`, `Recipient_ID`) VALUES (?,?);"
                        const values = [insertid, ui];
                        connection.query(sql2, values, function (err, result) {
                            if (err) callback(err);
                            if (result) callback();
                        })
                    }, function (err) {
                        if (err) {
                            console.log("Failed");
                            console.log(err);
                        } else {
                            console.log("Sysadmins Notified");
                        }
                    })
                })
            }
        }



    },
    //called on document ready
    GetNotif: function (req, resp) {
        console.log(req.session.user[0].User_ID);
        var today = new Date();
        var current = today.toISOString().split('T')[0];
        var sql = "SELECT notifications_read.Notifications_ID, Recipient_ID, notif_read, message, triggerdate, isactivity FROM capstone.notifications_read join capstone.notifications on notifications_read.Notifications_ID = notifications.Notifications_ID where notifications_read.Recipient_ID = ? && notifications.isactivity = 0 && DATE(triggerdate) <= DATE(NOW()) ORDER BY DATE(triggerdate) desc; SELECT notifications_read.Notifications_ID, Recipient_ID, notif_read, message, triggerdate, isactivity, activity_members.activity_Member , activity_members.activity_ID, approved_activities.activity_ID FROM capstone.notifications_read join capstone.notifications on notifications_read.Notifications_ID = notifications.Notifications_ID join capstone.activity_members on notifications_read.Recipient_ID  = activity_members.activity_ID join capstone.approved_activities on activity_members.activity_ID = approved_activities.activity_ID where activity_members.activity_Member  = ? && notifications.isactivity = 1 && DATE(triggerdate) <= DATE(NOW()) ORDER BY DATE(triggerdate) desc"

        var values = [req.session.user[0].User_ID, req.session.user[0].Group]
        connection.query(sql, values, function (err, results, fields) {
            resp.send(results);
            console.log(results)
        })

    },
    //called when the notification bar is clicked
    SetRead: function (req, resp) {
        console.log(req.session.user[0].User_ID);
        var sql = "Update notifications_read join notifications on notifications_read.Notifications_ID = notifications.Notifications_ID set notif_read = 1 where Recipient_ID = 46 && DATE(triggerdate) <= DATE(NOW())"
        var values = [req.session.user[0].User_ID]
        connection.query(sql, values, function (err, results, fields) {
            console.log("notifications read")
            console.log(results);
        })
    },
}
