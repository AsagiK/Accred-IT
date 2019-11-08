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
// ---- GOOGLE API
const readline = require('readline');
const {
    google
} = require('googleapis');

server.use(fileUpload({
    createParentPath: true,
    safeFileNames: true,
    preserveExtension: 10
}));
const SCOPES = ['https://www.googleapis.com/auth/drive'];
const TOKEN_PATH = 'token.json';
var mime = require('mime-types');
var UPLOAD_PATH = '';
if (fs.existsSync('accredit.json')) {
    UPLOAD_PATH = require('../accredit.json');
}
var sess
module.exports = {

    SendDocument: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var name = req.body.DocName;
            var filename = req.files.DocFile.name;
            var path = 'uploads/' + req.files.DocFile.name
            var desc = req.body.DocDesc;
            var point = filename.lastIndexOf(".");
            var ext = filename.substr(point);
            var folderId = UPLOAD_PATH.data.id;
            var fileMetadata = {
                'name': req.files.DocFile.name,
                'description': req.body.DocDesc,
                parents: [folderId]
            };
            var media;
            let uploadedimg = req.files.DocFile;
            uploadedimg.mv('public/uploads/' + req.files.DocFile.name, function (err) {
                if (err) return console.log("file not moved to server");
                else console.log("File uploaded");
            })
            var sql = "INSERT INTO `capstone`.`documents` (`Document_Name`, `Document_Route`, `Document_Desc`, `Document_Ext`) VALUES (? , ? , ?, ?);"
            var values = [name, path, desc, ext];

            connection.query(sql, values, function (err, result) {
                if (err) console.log("file not saved to local server");
                if (result) {
                    console.log("Record Inserted");
                    resp.redirect('/UploadDocument');
                    media = {
                        mimeType: mime.lookup('public/uploads/' + req.files.DocFile.name),
                        body: fs.createReadStream('public/uploads/' + req.files.DocFile.name)
                    };
                    uploadfile();
                }
            });

            function uploadfile() {
                fs.readFile('credentials.json', (err, content) => {
                    if (err) return console.log('Error loading client secret file:', err);
                    authorize(JSON.parse(content), uploadtodrive);
                });
            }

            function authorize(credentials, callback) {
                const {
                    client_secret,
                    client_id,
                    redirect_uris
                } = credentials.installed;
                const oAuth2Client = new google.auth.OAuth2(
                    client_id, client_secret, redirect_uris[0]);

                fs.readFile(TOKEN_PATH, (err, token) => {
                    if (err) return getAccessToken(oAuth2Client, callback);
                    oAuth2Client.setCredentials(JSON.parse(token));
                    callback(oAuth2Client);
                });
            }

            function uploadtodrive(auth) {
                const drive = google.drive({
                    version: 'v3',
                    auth
                });
                drive.files.create({
                    resource: fileMetadata,
                    media: media,
                    fields: 'id'
                }, function (err, file) {
                    if (err) {
                        console.log("File was not uploaded to Google Drive")
                    } else {
                        sql = "UPDATE `capstone`.`documents` SET `InDrive` = '1' WHERE (`Document_Route` = ?);"
                        values = 'uploads/' + req.files.DocFile.name;
                        connection.query(sql, values, function (err, result) {
                            if (err) throw err;
                            if (result) {
                                //  console.log(result);
                                console.log(req.files.DocFile.name + " Uploaded to Google Drive")
                                var fileid = file.data.id;
                                sql = "UPDATE `capstone`.`documents` SET `DriveID` = ? WHERE (`Document_Route` = ?)";
                                values = [fileid, 'uploads/' + req.files.DocFile.name];
                                addID(sql, values);

                            }
                        });
                    }
                });
            }

            function addID(sql, values) {
                connection.query(sql, values, function (err, result) {
                    if (err) throw err;
                    if (result) {
                        console.log("ID inserted to DB");
                    }
                });
            }
        }
    },

    SubmitReport: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var UID = req.body.UID;
            var PID = req.body.PID;
            var name = req.body.RepName;
            var filename = req.files.Evidence.name;
            var path = 'uploads/' + req.files.Evidence.name
            var desc = req.body.RepDesc;
            var point = filename.lastIndexOf(".");
            var ext = filename.substr(point);
            var today = new Date();
            var current = today.toISOString().split('T')[0];
            let uploadedimg = req.files.Evidence;
            var folderId = UPLOAD_PATH.data.id;
            var fileMetadata = {
                'name': req.files.Evidence.name,
                parents: [folderId]
            };
            var media;

            uploadedimg.mv('public/uploads/' + req.files.Evidence.name, function (err) {
                if (err) return console.log(err);
                else console.log("File uploaded");
            })
            var sql = "INSERT INTO `capstone`.`documents` (`Document_Name`, `Document_Route`, `Document_Desc`, `Document_Ext`) VALUES (? , ? , ?, ?); INSERT INTO `capstone`.`plansubmissions` (`Plan_ID`, `User_ID`, `Submission_Title`, `Submission_File`, `Submission_Description`, `Submission_Date`) VALUES (?, ?, ?, ?, ?, ?) "
            var values = [name, path, desc, ext, PID, UID, name, path, desc, current];
            connection.query(sql, values, function (err, result) {
                if (err) throw err;
                if (result) {
                    media = {
                        mimeType: mime.lookup('public/uploads/' + req.files.Evidence.name),
                        body: fs.createReadStream('public/uploads/' + req.files.Evidence.name)
                    };
                    uploadfile();
                }
                console.log("Record Inserted");

            });

            function uploadfile() {
                fs.readFile('credentials.json', (err, content) => {
                    if (err) return console.log('Error loading client secret file:', err);
                    authorize(JSON.parse(content), uploadtodrive);
                });
            }

            function authorize(credentials, callback) {
                const {
                    client_secret,
                    client_id,
                    redirect_uris
                } = credentials.installed;
                const oAuth2Client = new google.auth.OAuth2(
                    client_id, client_secret, redirect_uris[0]);

                fs.readFile(TOKEN_PATH, (err, token) => {
                    if (err) return getAccessToken(oAuth2Client, callback);
                    oAuth2Client.setCredentials(JSON.parse(token));
                    callback(oAuth2Client);
                });
            }

            function uploadtodrive(auth) {
                const drive = google.drive({
                    version: 'v3',
                    auth
                });
                drive.files.create({
                    resource: fileMetadata,
                    media: media,
                    fields: 'id'
                }, function (err, file) {
                    if (err) {
                        console.log("File was not uploaded")
                    } else {
                        sql = "UPDATE `capstone`.`documents` SET `InDrive` = '1' WHERE (`Document_Route` = ?);"
                        values = 'uploads/' + req.files.Evidence.name;
                        connection.query(sql, values, function (err, result) {
                            if (err) throw err;
                            if (result) {
                                // console.log(result);
                                console.log(req.files.Evidence.name + " Uploaded to Google Drive")
                                var fileid = file.data.id;
                                sql = "UPDATE `capstone`.`documents` SET `DriveID` = ? WHERE (`Document_Route` = ?)";
                                values = [fileid, 'uploads/' + req.files.Evidence.name];
                                addID(sql, values);
                            }
                        });
                    }
                });
            }

            function addID(sql, values) {
                connection.query(sql, values, function (err, result) {
                    if (err) throw err;
                    if (result) {
                        console.log("ID inserted to DB");
                    }
                });
            }
        }
    },

    FinalReport: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else {
            var sql = "SELECT plansubmissions.Submission_ID, plansubmissions.Plan_ID, plansubmissions.User_ID, plansubmissions.Submission_Title, plansubmissions.Submission_File, plansubmissions.Submission_Description, plansubmissions.Submission_Date, plansubmissions.Submission_Status, plans.PlanName, users.User_First, recommendation.recommendation_ID, recommendation.recommendation_Name FROM capstone.plansubmissions JOIN capstone.plans ON plansubmissions.Plan_ID = plans.Plan_ID JOIN capstone.users ON plansubmissions.User_ID = users.User_ID JOIN capstone.recommendation ON recommendation.recommendation_ID = plans.recommendation_ID; Select * FROM capstone.plans; Select * FROM capstone.recommendation;"
            connection.query(sql, function (err, results, fields) {
                if (err) throw err;
                if (results) {
                    resp.render('./pages/FinalReportGroupLeader.ejs', {
                        data: results[0],
                        dataB: results[1],
                        dataC: results[2],
                        current_user: sess.user
                    });
                }
            });

            console.log("FINAL REPORT GROUP LEADER PAGE");
        }
    },

    SendDocuments: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else if (req.files != null) {
            var files = req.files.DocFile;
            console.log(req.files)
            var max = files.length;
            var AID = req.body.activityID;
            var name = req.body.activityName;
            var code = req.body.code;
            var description = req.body.subdesc;
            var MID = req.body.MID;
            var PID = req.body.PID;


            var count = 0;
            console.log(files.length);
            if (files.length) {
                async.forEachOf(files, function (value, key, callback) {
                    var name = files[key].name;
                    var filename = files[key].name;
                    var path = 'uploads/' + files[key].name;
                    var desc = req.body.DocDesc;
                    var point = filename.lastIndexOf(".");
                    var ext = filename.substr(point);
                    var folderId = UPLOAD_PATH.data.id;
                    var fileMetadata = {
                        'name': files[key].name,
                        'parents': [folderId]
                    };
                    var media;
                    let uploadedimg = files[key];
                    uploadedimg.mv('public/uploads/' + files[key].name, function (err) {
                        if (err) return console.log(err);
                        else console.log("File uploaded");
                    })
                    var sql = "INSERT INTO `capstone`.`documents` (`Document_Name`, `Document_Route`, `Document_Desc`, `Document_Ext`) VALUES (? , ? , ?, ?);"
                    var values = [name, path, desc, ext];

                    connection.query(sql, values, function (err, result) {
                        if (err) callback(err);
                        if (result) {
                            console.log("Record Inserted");
                            media = {
                                mimeType: mime.lookup('public/uploads/' + files[key].name),
                                body: fs.createReadStream('public/uploads/' + files[key].name)
                            };
                            uploadfile();
                            sql = "INSERT INTO `capstone`.`activity_evidences` (`activityID`, `documentID`, `pendingID`) VALUES (?, ?, ?); "
                            values = [req.body.activityID, result.insertId, PID];
                            addDoc(sql, values);
                            callback();
                        }
                    });

                    function uploadfile() {
                        fs.readFile('credentials.json', (err, content) => {
                            if (err) return console.log('Error loading client secret file:', err);
                            authorize(JSON.parse(content), uploadtodrive);
                        });
                    }

                    function authorize(credentials, callback) {
                        const {
                            client_secret,
                            client_id,
                            redirect_uris
                        } = credentials.installed;
                        const oAuth2Client = new google.auth.OAuth2(
                            client_id, client_secret, redirect_uris[0]);

                        fs.readFile(TOKEN_PATH, (err, token) => {
                            if (err) return getAccessToken(oAuth2Client, callback);
                            oAuth2Client.setCredentials(JSON.parse(token));
                            callback(oAuth2Client);
                        });
                    }

                    function uploadtodrive(auth) {
                        const drive = google.drive({
                            version: 'v3',
                            auth
                        });
                        drive.files.create({
                            resource: fileMetadata,
                            media: media,
                            fields: 'id'
                        }, function (err, file) {
                            count = count + 1;
                            console.log("File " + count + " of " + max);
                            if (err) {
                                console.log(files[key].name + "Was not uploaded to Google Drive")
                            } else {
                                sql = "UPDATE `capstone`.`documents` SET `InDrive` = '1' WHERE (`Document_Route` = ?);"
                                values = 'uploads/' + files[key].name;
                                connection.query(sql, values, function (err, result) {
                                    if (err) throw err;
                                    if (result) {
                                        console.log(files[key].name + " Uploaded to Google Drive")
                                        var fileid = file.data.id;
                                        sql = "UPDATE `capstone`.`documents` SET `DriveID` = ? WHERE (`Document_Route` = ?)";
                                        values = [fileid, 'uploads/' + files[key].name];
                                        addID(sql, values);
                                    }
                                });
                            }
                        });
                    }

                    function addID(sql, values) {
                        connection.query(sql, values, function (err, result) {
                            if (err) throw err;
                            if (result) {
                                console.log("ID inserted to DB");
                            }
                        });
                    }

                    function addDoc(sql, values) {
                        connection.query(sql, values, function (err, result) {
                            if (err) throw err;
                            if (result) {
                                console.log("Document linked to DB");
                            }
                        });
                    }
                }, function (err) {
                    if (err) {
                        console.log("Failed");
                        resp.redirect('/ViewDocument')
                    } else {
                        console.log("Passed")
                        resp.redirect('/ViewDocument')

                    }
                })
                //-----------------------------------------------------------------
            } else {
                var name = files.name;
                var filename = files.name;
                var path = 'uploads/' + files.name;
                var desc = req.body.DocDesc;
                var point = filename.lastIndexOf(".");
                var ext = filename.substr(point);
                var folderId = UPLOAD_PATH.data.id
                var fileMetadata = {
                    'name': files.name,
                    parents: [folderId]
                };
                var media;
                let uploadedimg = files;
                uploadedimg.mv('public/uploads/' + files.name, function (err) {
                    if (err) return console.log(err);
                    else console.log("File uploaded");
                })
                var sql = "INSERT INTO `capstone`.`documents` (`Document_Name`, `Document_Route`, `Document_Desc`, `Document_Ext`) VALUES (? , ? , ?, ?);"
                var values = [name, path, desc, ext];
                connection.query(sql, values, function (err, result) {
                    if (err) console.log(err);
                    if (result) {
                        console.log("Record Inserted");
                        media = {
                            mimeType: mime.lookup('public/uploads/' + files.name),
                            body: fs.createReadStream('public/uploads/' + files.name)
                        };
                        uploadfile();
                        sql = "INSERT INTO `capstone`.`activity_evidences` (`activityID`, `documentID`, `pendingID`) VALUES (?, ?, ?); "
                        values = [req.body.activityID, result.insertId, PID];
                        addDoc(sql, values);
                        resp.redirect('/ViewDocument')
                    }
                });

                function uploadfile() {
                    fs.readFile('credentials.json', (err, content) => {
                        if (err) return console.log('Error loading client secret file:', err);
                        authorize(JSON.parse(content), uploadtodrive);
                    });
                }

                function authorize(credentials, callback) {
                    const {
                        client_secret,
                        client_id,
                        redirect_uris
                    } = credentials.installed;
                    const oAuth2Client = new google.auth.OAuth2(
                        client_id, client_secret, redirect_uris[0]);

                    fs.readFile(TOKEN_PATH, (err, token) => {
                        if (err) return getAccessToken(oAuth2Client, callback);
                        oAuth2Client.setCredentials(JSON.parse(token));
                        callback(oAuth2Client);
                    });
                }

                function uploadtodrive(auth) {
                    const drive = google.drive({
                        version: 'v3',
                        auth
                    });
                    drive.files.create({
                        resource: fileMetadata,
                        media: media,
                        fields: 'id'
                    }, function (err, file) {
                        count = count + 1;
                        console.log("File " + count + " of 1");
                        if (err) {
                            console.log(files.name + "Was not uploaded to Google Drive")
                        } else {
                            sql = "UPDATE `capstone`.`documents` SET `InDrive` = '1' WHERE (`Document_Route` = ?);"
                            values = 'uploads/' + files.name;
                            connection.query(sql, values, function (err, result) {
                                if (err) throw err;
                                if (result) {
                                    console.log(files.name + " Uploaded to Google Drive")
                                    var fileid = file.data.id;
                                    sql = "UPDATE `capstone`.`documents` SET `DriveID` = ? WHERE (`Document_Route` = ?)";
                                    values = [fileid, 'uploads/' + files.name];
                                    addID(sql, values);

                                }
                            });
                        }
                    });
                }

                function addID(sql, values) {
                    connection.query(sql, values, function (err, result) {
                        if (err) throw err;
                        if (result) {
                            console.log("ID inserted to DB");
                        }
                    });
                }

                function addDoc(sql, values) {
                    connection.query(sql, values, function (err, result) {
                        if (err) throw err;
                        if (result) {
                            console.log("Document linked to DB");
                        }
                    });
                }

            }
        } else {
            resp.redirect('/ViewDocument')
        }
    },

    PreCheck: function (req, resp) {
        console.log(req.body);
        if (req.body.subtype == "1") {
            var AID = req.body.activityID;
            var name = req.body.activityName;
            var target = req.body.target;
            var code = req.body.code;
            var description = req.body.activityDesc;
            var MID = req.body.MID;
            var score = req.body.score;
            var status = 1;
            var values = [score, AID, AID, name, target, code, description, MID, score, status, AID]
            var sql = "UPDATE capstone.approved_activities set current_Score = ? where activity_ID = ?; INSERT INTO `capstone`.`audit_activities` ( `activity_ID`, `activity_name`, `target`, `code`, `description`, `measurement_ID`, `current_Score`, `status`) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?); DELETE FROM `capstone`.`pending_activities` WHERE (`activity_ID` = ?);"
            connection.query(sql, values, function (err, results) {
                if (err) throw err;
                console.log(results);
                resp.redirect('/ViewMeasurementDetails?MID=' + MID)
            });
        } else {
            var AID = req.body.activityID;
            var name = req.body.activityName;
            var target = req.body.target;
            var code = req.body.code;
            var description = req.body.activityDesc;
            var MID = req.body.MID;
            var score = req.body.score;
            var values = [AID]
            var sql = "DELETE FROM `capstone`.`pending_activities` WHERE (`activity_ID` = ?);";
            connection.query(sql, values, function (err, results) {
                if (err) throw err;
                console.log(results);
                resp.redirect('/ViewMeasurementDetails?MID=' + MID)
            });
        }
    },

    SendDocumentsJSON: function (req, resp) {
        console.log(req.body);
        var AID = req.body.AID;
        var name = req.body.name;
        var code = req.body.code;
        var UID = req.body.UID;
        var description = req.body.description;
        //var MID = req.body.MID;
        var target = req.body.target;
        var score = req.body.score;
        var today = new Date();
        var current = today.toISOString().split('T')[0];
        var values2 = [AID, name, code, description, score, current, UID]
        var sql2 = "INSERT INTO `capstone`.`pending_activities` (`activity_ID`, `activity_Name`,  `code`, `description`,  `suggested_Score`, `dateupdated`, `user_ID`) VALUES (? , ?, ?, ?, ?, ?, ?);"
        connection.query(sql2, values2, function (err, results, fields) {
            if (err) throw err;
            if (results) {
                console.log("Pending activity inserted")
                inserttable(results.insertId);
            }
        });

        function inserttable(pending) {
            var pendingID = pending;
            pendingID = pendingID.toString();
            
            var Doc = req.body.table
            Doc = JSON.parse(Doc)
            if (Object.keys(Doc).length == 0) {
                console.log("Empty");
                resp.send(pendingID);
            } else {
                async.forEachOf(Doc, function (value, key, callback) {
                    var did = Doc[key]["Document ID"];
                    var sql = "INSERT INTO `capstone`.`activity_evidences` (`activityID`, `documentID`, `pendingID`) VALUES (?, ?, ?); ";
                    var values = [AID, did, pendingID];
                    connection.query(sql, values, function (err, result) {
                        if (err) {
                            console.log(err);
                            callback(err);
                        }
                        if (result) {
                            console.log("Document linked to DB");
                            callback();
                        }
                    });
                }, function (err) {
                    if (err) {
                        console.log("Failed");
                        resp.send("Not OK")
                    } else {
                        console.log("Passed");
                        resp.send(pendingID);
                    }
                })
            }
        }
    },
    
    UpdateDocumentsJSON: function (req, resp){
        /*
      Step 0 = create isaversionof, md5, and version number in documents table
      Step 1 = receive ID of document to be updated and new document
      Step 2 = generate a hash of new document
      Step 3 = compare hash of old document and new document
      IF failed then return a dupicate error
      IF not failed check for same filename
      IF same filename then append v + "version number" to filename
      ELSE process document and return success message
      Step 4 = fix hardlinks of evidence to activity
      */
    },


}
