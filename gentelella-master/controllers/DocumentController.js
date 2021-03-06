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
try {
    var TOKEN_PATH = './config/token.json'
    var UPLOAD_PATH = JSON.parse(fs.readFileSync('./config/accredit.json', 'utf8'));
} catch (e) {

}



var dir = 'public/uploads';

if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir);
}


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
var mime = require('mime-types');
var Notif = require('../controllers/NotifController')
var sess
const datefix = new Date()
const offset = datefix.getTimezoneOffset()


module.exports = {

    SendDocument: function (req, resp) {
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
            var files = req.files.DocFile;
            console.log(req.files)
            var max = files.length;
            var count = 0;
            if (files.length) {
                async.forEachOf(files, function (value, key, callback) {

                    var name = files[key].name;
                    var filename = files[key].name;
                    var path = 'uploads/' + files[key].name;
                    var desc = req.body.DocDesc;
                    var md5 = files[key].md5;
                    var point = filename.lastIndexOf(".");
                    var ext = filename.substr(point);
                    var folderId = UPLOAD_PATH.data.id;
                    var fileMetadata = {
                        'name': files[key].name,
                        'parents': [folderId]
                    };
                    var media;
                    let uploadedimg = files[key];

                    var checknamesql = "SELECT * FROM capstone.documents where md5 = ?; SELECT * FROM capstone.documents where Document_Name = ?;"
                    var checknamevalue = [md5, filename]
                    connection.query(checknamesql, checknamevalue, function (err, results) {
                        if (err) callback(err);
                        if (results) {
                            if (results[0].length == 0) { // file content is unique
                                if (results[1].length > 0) { //file in system exists with same name
                                    generatename(filename, md5);
                                } else { // file is completely unique
                                    movefile(filename);
                                }
                            } else {
                                console.log("duplicate file")
                            }
                            callback();
                        }
                    });

                    function generatename(filename, md5) {
                        var namecontents = filename.split(".");
                        var fname = namecontents[0];
                        var fext = namecontents[1];
                        var fname = fname + md5.substr(0, 10) + "." + fext;
                        movefile(fname);
                    }

                    function movefile(newname) {
                        path = 'uploads/' + newname;
                        uploadedimg.mv('public/uploads/' + newname, function (err) {
                            if (err) return console.log(err);
                            else console.log("File uploaded");
                        })
                        var sql = "INSERT INTO capstone.`documents` (Document_Name, Document_Route, Document_Desc, Document_Ext, md5, upload_id) VALUES (? , ? , ?, ?, ?, ?);"
                        var values = [newname, path, desc, ext, md5, req.session.user[0].User_ID];

                        connection.query(sql, values, function (err, result) {
                            if (err) callback(err);
                            if (result) {
                                console.log("Record Inserted");
                                media = {
                                    mimeType: mime.lookup('public/uploads/' + newname),
                                    body: fs.createReadStream('public/uploads/' + newname)
                                };
                                uploadfile(newname);
                                sql = "INSERT INTO capstone.`folder_documents` (folder_id, document_id, folder_name) VALUES (?, ?, ?); "
                                values = [req.body.FoldID, result.insertId, req.body.FoldName];
                                addFolder(sql, values, req.body.FoldID);
                                callback();
                            }
                        });
                    }

                    function uploadfile(newname) {
                        fs.readFile('./config/credentials.json', (err, content) => {
                            if (err) return console.log('Error loading client secret file:', err);
                            authorize(JSON.parse(content), uploadtodrive, newname);
                            console.log(content)
                        })
                    }

                    function authorize(credentials, callback, newname) {
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
                            callback(oAuth2Client, newname);
                        });
                    }

                    function uploadtodrive(auth, newname) {
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
                                console.log(newname + "Was not uploaded to Google Drive")
                            } else {
                                sql = "UPDATE capstone.`documents` SET InDrive = '1' WHERE (Document_Route = ?);"
                                values = 'uploads/' + newname;
                                connection.query(sql, values, function (err, result) {
                                    if (err) throw err;
                                    if (result) {
                                        console.log(newname + " Uploaded to Google Drive")
                                        var fileid = file.data.id;
                                        sql = "UPDATE capstone.`documents` SET DriveID = ? WHERE (Document_Route = ?)";
                                        values = [fileid, 'uploads/' + newname];
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

                    function addFolder(sql, values, folderid) {
                        if (folderid) {
                            connection.query(sql, values, function (err, result) {
                                if (err) throw err;
                                if (result) {
                                    console.log("Document linked to DB");
                                }
                            });
                        }
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

            } else {
                var files = req.files.DocFile;
                var name = files.name;
                var filename = files.name;
                var path = 'uploads/' + files.name;
                var desc = req.body.DocDesc;
                var md5 = files.md5;
                var point = filename.lastIndexOf(".");
                var ext = filename.substr(point);
                var folderId = UPLOAD_PATH.data.id
                var fileMetadata = {
                    'name': files.name,
                    parents: [folderId]
                };
                var media;
                let uploadedimg = files;

                var checknamesql = "SELECT * FROM capstone.documents where md5 = ?; SELECT * FROM capstone.documents where Document_Name = ?;"
                var checknamevalue = [md5, filename]
                connection.query(checknamesql, checknamevalue, function (err, results) {
                    if (err) console.log(err);
                    if (results) {
                        if (results[0].length == 0) { // file content is unique
                            if (results[1].length > 0) { //file in system exists with same name
                                generatename(filename, md5);
                            } else { // file is completely unique
                                movefile(filename);
                            }
                        } else {
                            console.log("duplicate file")
                            resp.redirect('/ViewDocument')
                        }
                    }
                });

                function generatename(filename, md5) {
                    var namecontents = filename.split(".");
                    var fname = namecontents[0];
                    var fext = namecontents[1];
                    var fname = fname + md5.substr(0, 10) + "." + fext;
                    movefile(fname);
                }

                function movefile(newname) {
                    path = 'uploads/' + newname;
                    uploadedimg.mv('public/uploads/' + newname, function (err) {
                        if (err) return console.log(err);
                        else console.log("File uploaded");
                    })
                    var sql = "INSERT INTO capstone.`documents` (Document_Name, Document_Route, Document_Desc, Document_Ext, md5, upload_id) VALUES (? , ? , ?, ?, ?, ?);"
                    var values = [newname, path, desc, ext, md5, req.session.user[0].User_ID];
                    connection.query(sql, values, function (err, result) {
                        if (err) console.log(err);
                        if (result) {
                            console.log("Record Inserted");
                            media = {
                                mimeType: mime.lookup('public/uploads/' + newname),
                                body: fs.createReadStream('public/uploads/' + newname)
                            };
                            uploadfile(newname);
                            sql = "INSERT INTO capstone.`folder_documents` (folder_id, document_id, folder_name) VALUES (?, ?, ?); "
                            values = [req.body.FoldID, result.insertId, req.body.FoldName];
                            addFolder(sql, values, req.body.FoldID);
                            resp.redirect('/ViewDocument')
                        }
                    });
                }

                function uploadfile(newname) {
                    fs.readFile('./config/credentials.json', (err, content) => {
                        if (err) return console.log('Error loading client secret file:', err);
                        authorize(JSON.parse(content), uploadtodrive, newname);
                        console.log(content)
                    });
                }

                function authorize(credentials, callback, newname) {
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
                        callback(oAuth2Client, newname);
                    });
                }

                function uploadtodrive(auth, newname) {
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
                            console.log(newname + "Was not uploaded to Google Drive")
                        } else {
                            sql = "UPDATE capstone.`documents` SET InDrive = '1' WHERE (Document_Route = ?);"
                            values = 'uploads/' + newname;
                            connection.query(sql, values, function (err, result) {
                                if (err) throw err;
                                if (result) {
                                    console.log(newname + " Uploaded to Google Drive")
                                    var fileid = file.data.id;
                                    sql = "UPDATE capstone.`documents` SET DriveID = ? WHERE (Document_Route = ?)";
                                    values = [fileid, 'uploads/' + newname];
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

                function addFolder(sql, values, folderid) {
                    if (folderid) {
                        connection.query(sql, values, function (err, result) {
                            if (err) throw err;
                            if (result) {
                                console.log("Document linked to DB");
                            }
                        });
                    }
                }
            }
        }
    },

    SubmitReport: function (req, resp) {
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
            var sql = "INSERT INTO `capstone`.`documents` (`Document_Name`, `Document_Route`, `Document_Desc`, `Document_Ext`, `upload_id`) VALUES (? , ? , ?, ?, ?); INSERT INTO `capstone`.`plansubmissions` (`Plan_ID`, `User_ID`, `Submission_Title`, `Submission_File`, `Submission_Description`, `Submission_Date`) VALUES (?, ?, ?, ?, ?, ?) "
            var values = [name, path, desc, ext, req.session.user[0].User_ID, PID, UID, name, path, desc, current];
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
                fs.readFile('./config/credentials.json', (err, content) => {
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
            console.log("--------------------------------------------------------------------------------------------------" + req.body.FoldID)
            console.log("--------------------------------------------------------------------------------------------------" + req.body.FoldName)

            var count = 0;
            console.log(files.length);
            if (files.length) {
                async.forEachOf(files, function (value, key, callback) {
                        var name = files[key].name;
                        var filename = files[key].name;
                        var path = 'uploads/' + files[key].name;
                        var desc = req.body.DocDesc;
                        var md5 = files[key].md5;
                        var point = filename.lastIndexOf(".");
                        var ext = filename.substr(point);
                        var folderId = UPLOAD_PATH.data.id;
                        var fileMetadata = {
                            'name': files[key].name,
                            'parents': [folderId]
                        };
                        var media;
                        let uploadedimg = files[key];

                        var checknamesql = "SELECT * FROM capstone.documents where md5 = ?; SELECT * FROM capstone.documents where Document_Name = ?;"
                        var checknamevalue = [md5, filename]
                        connection.query(checknamesql, checknamevalue, function (err, results) {
                            if (err) callback(err);
                            if (results) {
                                if (results[0].length == 0) { // file content is unique
                                    if (results[1].length > 0) { //file in system exists with same name
                                        generatename(filename, md5);
                                    } else { // file is completely unique
                                        movefile(filename);
                                    }
                                } else {
                                    console.log("duplicate file")
                                }
                                callback();
                            }
                        });

                        function generatename(filename, md5) {
                            var namecontents = filename.split(".");
                            var fname = namecontents[0];
                            var fext = namecontents[1];
                            var fname = fname + md5.substr(0, 10) + "." + fext;
                            movefile(fname);
                        }



                        function movefile(newname) {
                            path = 'uploads/' + newname;
                            uploadedimg.mv('public/uploads/' + newname, function (err) {
                                if (err) return console.log(err);
                                else console.log("File uploaded");
                            })
                            var sql = "INSERT INTO capstone.`documents` (Document_Name, Document_Route, Document_Desc, Document_Ext, md5, upload_id) VALUES (? , ? , ?, ?, ?, ?);"
                            var values = [newname, path, desc, ext, md5, req.session.user[0].User_ID];

                            connection.query(sql, values, function (err, result) {
                                if (err) {
                                    console.log(err)
                                };
                                if (result) {
                                    console.log("Record Inserted");
                                    media = {
                                        mimeType: mime.lookup('public/uploads/' + newname),
                                        body: fs.createReadStream('public/uploads/' + newname)
                                    };
                                    uploadfile(newname);
                                    sql = "INSERT INTO capstone.`activity_evidences` (activityID, documentID, pendingID) VALUES (?, ?, ?); "
                                    values = [req.body.activityID, result.insertId, PID];
                                    addDoc(sql, values);
                                    var sql2 = "INSERT INTO capstone.`folder_documents` (folder_id, document_id, folder_name) VALUES (?, ?, ?); "
                                    var values2 = [req.body.FoldID, result.insertId, req.body.FoldName];
                                    addFolder(sql2, values2, req.body.FoldID);
                                }
                            });
                        }

                        function uploadfile(newname) {
                            fs.readFile('./config/credentials.json', (err, content) => {
                                if (err) return console.log('Error loading client secret file:', err);
                                authorize(JSON.parse(content), uploadtodrive, newname);
                            });
                        }

                        function authorize(credentials, callback, newname) {
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
                                callback(oAuth2Client, newname);
                            });
                        }

                        function uploadtodrive(auth, newname) {
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
                                    console.log(newname + "Was not uploaded to Google Drive")
                                } else {
                                    sql = "UPDATE capstone.`documents` SET InDrive = '1' WHERE (Document_Route = ?);"
                                    values = 'uploads/' + newname;
                                    connection.query(sql, values, function (err, result) {
                                        if (err) throw err;
                                        if (result) {
                                            console.log(newname + " Uploaded to Google Drive")
                                            var fileid = file.data.id;
                                            sql = "UPDATE capstone.`documents` SET DriveID = ? WHERE (Document_Route = ?)";
                                            values = [fileid, 'uploads/' + newname];
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

                        function addFolder(sql, values, folderid) {
                            if (folderid) {
                                connection.query(sql, values, function (err, result) {
                                    if (err) throw err;
                                    if (result) {
                                        console.log("Document linked to Folder");
                                    }
                                });
                            }
                        }

                        function addDoc(sql, values) {
                            connection.query(sql, values, function (err, result) {
                                if (err) throw err;
                                if (result) {
                                    console.log("Document linked to DB");
                                }
                            });
                        }
                    },
                    function (err) {
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
                var md5 = files.md5;
                var point = filename.lastIndexOf(".");
                var ext = filename.substr(point);
                var folderId = UPLOAD_PATH.data.id
                var fileMetadata = {
                    'name': files.name,
                    parents: [folderId]
                };
                var media;
                let uploadedimg = files;

                var checknamesql = "SELECT * FROM capstone.documents where md5 = ?; SELECT * FROM capstone.documents where Document_Name = ?;"
                var checknamevalue = [md5, filename]
                connection.query(checknamesql, checknamevalue, function (err, results) {
                    if (err) console.log(err);
                    if (results) {
                        if (results[0].length == 0) { // file content is unique
                            if (results[1].length > 0) { //file in system exists with same name
                                generatename(filename, md5);
                            } else { // file is completely unique
                                movefile(filename);
                            }
                        } else {
                            console.log("duplicate file")
                            resp.redirect('/ViewDocument')
                        }
                    }
                });

                function generatename(filename, md5) {
                    var namecontents = filename.split(".");
                    var fname = namecontents[0];
                    var fext = namecontents[1];
                    var fname = fname + md5.substr(0, 10) + "." + fext;
                    movefile(fname);
                }


                function movefile(newname) {
                    path = 'uploads/' + newname;
                    uploadedimg.mv('public/uploads/' + newname, function (err) {
                        if (err) return console.log(err);
                        else console.log("File uploaded");
                    })
                    var sql = "INSERT INTO capstone.`documents` (Document_Name, Document_Route, Document_Desc, Document_Ext, md5, upload_id) VALUES (? , ? , ?, ?, ?, ?);"
                    var values = [newname, path, desc, ext, md5, req.session.user[0].User_ID];

                    connection.query(sql, values, function (err, result) {
                        if (err) {
                            console.log(err)
                        };
                        if (result) {
                            console.log("Record Inserted");
                            media = {
                                mimeType: mime.lookup('public/uploads/' + newname),
                                body: fs.createReadStream('public/uploads/' + newname)
                            };
                            uploadfile(newname);
                            sql = "INSERT INTO capstone.`activity_evidences` (activityID, documentID, pendingID) VALUES (?, ?, ?); "
                            values = [req.body.activityID, result.insertId, PID];
                            addDoc(sql, values);
                            var sql2 = "INSERT INTO capstone.`folder_documents` (folder_id, document_id, folder_name) VALUES (?, ?, ?); "
                            var values2 = [req.body.FoldID, result.insertId, req.body.FoldName];
                            addFolder(sql2, values2, req.body.FoldID);
                            resp.redirect('/ViewDocument')
                        }
                    });
                }

                function uploadfile(newname) {
                    fs.readFile('./config/credentials.json', (err, content) => {
                        if (err) return console.log('Error loading client secret file:', err);
                        authorize(JSON.parse(content), uploadtodrive, newname);
                    });
                }

                function authorize(credentials, callback, newname) {
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
                        callback(oAuth2Client, newname);
                    });
                }

                function uploadtodrive(auth, newname) {
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
                            console.log(newname + "Was not uploaded to Google Drive")
                        } else {
                            sql = "UPDATE capstone.`documents` SET InDrive = '1' WHERE (Document_Route = ?);"
                            values = 'uploads/' + newname;
                            connection.query(sql, values, function (err, result) {
                                if (err) throw err;
                                if (result) {
                                    console.log(newname + " Uploaded to Google Drive")
                                    var fileid = file.data.id;
                                    sql = "UPDATE capstone.`documents` SET DriveID = ? WHERE (Document_Route = ?)";
                                    values = [fileid, 'uploads/' + newname];
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

                function addFolder(sql, values, folderid) {
                    if (folderid) {
                        console.log(values);
                        connection.query(sql, values, function (err, result) {
                            if (err) throw err;
                            if (result) {
                                console.log("Document linked to Folder");
                            }
                        });
                    }
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
            var PID = req.body.PID;
            var comment = req.body.comment;
            var status = 1;
            var values = [status, comment, PID]
            var sql = "UPDATE capstone.pending_activities set status = ?, comment = ? where pending_ID = ?;"
            connection.query(sql, values, function (err, results) {
                if (err) throw err;
                console.log(results);
                resp.redirect('/CheckingAccordionPage')
            });
        } else if (req.body.subtype == "2") {
            var PID = req.body.PID;
            var comment = req.body.comment;
            var status = 2;
            var values = [status, comment, PID]
            var sql = "UPDATE capstone.pending_activities set status = ?, comment = ? where pending_ID = ?;"
            connection.query(sql, values, function (err, results) {
                if (err) throw err;
                console.log(results);
                resp.redirect('/CheckingAccordionPage')
            });
        } else {
            var PID = req.body.PID;
            var comment = req.body.comment;
            var status = 3;
            var values = [status, comment, PID]
            var sql = "UPDATE capstone.pending_activities set status = ?, comment = ? where pending_ID = ?;"
            connection.query(sql, values, function (err, results) {
                if (err) throw err;
                console.log(results);
                resp.redirect('/CheckingAccordionGroupLeaderPage')
            });
        }
    },

    SendDocumentsJSON: function (req, resp) {
        sess = req.session;
        console.log(req.body);
        var AID = req.body.AID;
        var name = req.body.name;
        var code = req.body.code;
        var UID = req.body.UID;
        var description = req.body.description;
        //var MID = req.body.MID;
        var MNAME = req.body.MNAME;
        var target = req.body.target;
        var score = req.body.score;
        var today = new Date();
        var current = today.toISOString().split('T')[0];
        var CID = req.body.CID;
        var TID = req.body.TID;
        var FoldID = req.body.FoldID;
        var FoldName = req.body.FoldName;
        var values2 = [AID, name, TID, code, description, score, current, UID, CID]
        var sql2 = "INSERT INTO capstone.`pending_activities` (activity_ID, activity_Name, target,  code, description,  suggested_Score, dateupdated, user_ID, cycle_ID) VALUES (? , ?, ?, ?, ?, ?, ?, ?, ?);"
        connection.query(sql2, values2, function (err, results, fields) {
            if (err) throw err;
            if (results) {
                console.log("Pending activity inserted")
                inserttable(results.insertId);
                inserttable2(results.insertId);
                var today = new Date();
                today = new Date(today.getTime() - (offset * 60 * 1000))
                var current = today.toISOString().split('T')[0];
                var notifobject = {
                    "body": "User " + sess.user[0].User_First + " " + sess.user[0].User_Last + " has submitted to activity: " + name + " Under Measurement: " + MNAME, //message body, cannot be null
                    "sender": sess.user[0].User_ID, //ID of sender taken from req session
                    "receiver": "0", //ID of receiver, in this case the user that was created
                    "group": sess.user[0].Group, //Group ID taken from req session
                    "range": "3", //range of notification, refer to the JSONcontroller
                    "admin": "1", // 0 if admin does not need to be notified, else 1
                    "sysadmin": "1", // same as above
                    "triggerdate": current //leave to this to trigger notif instantly, otherwise provide a date in format YYYY-MM-DD
                }
                Notif.CreateNotif(notifobject);


            }
        });

        function inserttable(pending) {
            var pendingID = pending;
            pendingID = pendingID.toString();

            var Doc = req.body.table
            Doc = JSON.parse(Doc)
            if (Object.keys(Doc).length == 0) {
                console.log("Empty");

            } else {
                async.forEachOf(Doc, function (value, key, callback) {
                    var did = Doc[key]["Document ID"];
                    var sql = "INSERT INTO capstone.`activity_evidences` (activityID, documentID, pendingID) VALUES (?, ?, ?); ";
                    var values = [AID, did, pendingID];
                    connection.query(sql, values, function (err, result) {
                        if (err) {
                            console.log(err);
                            //callback(err);
                        }
                        if (result) {
                            console.log("Document linked to DB");
                            inserttable3(did);
                        }
                    });
                }, function (err) {
                    if (err) {
                        console.log("Failed");
                        //resp.send("Not OK")
                    } else {
                        console.log("Passed");

                    }
                })
            }
        }

        function inserttable2(pending) {
            var pendingID = pending;
            pendingID = pendingID.toString();

            var output = req.body.table2;
            output = JSON.parse(output)
            if (Object.keys(output).length == 0) {
                console.log("Empty");
                resp.send(pendingID);
            } else {
                async.forEachOf(output, function (value, key, callback) {
                    var oid = output[key]["ID"];
                    var sql = "INSERT INTO capstone.`pending_outputs` (activityID, outputID, pendingID) VALUES (?, ?, ?); ";
                    var values = [AID, oid, pendingID];
                    connection.query(sql, values, function (err, result) {
                        if (err) {
                            console.log(err);
                            callback(err);
                        }
                        if (result) {
                            console.log("Output linked to submission");
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

        function inserttable3(did) {
            sql = "INSERT INTO capstone.`folder_documents` (folder_id, document_id, folder_name) VALUES (?, ?, ?); "
            values = [FoldID, did, FoldName];
            connection.query(sql, values, function (err, result) {
                if (err) throw err;
                if (result) {
                    console.log("Document linked to Folder");
                }
            });
        }
    },

    UpdateDocumentsJSON: function (req, resp) {

        //      Done Step 0 = create isaversionof, md5, and version number in documents table
        //      Step 1 = receive ID of document to be updated and new document
        //      Step 2 = generate a hash of new document
        //      Step 3 = compare hash of new document in system
        //      IF failed then return a dupicate error = Case 0
        //      IF not failed check for same filename
        //      IF same filename then append v + "version number" to filename = Case 1 Type 1
        //      ELSE process document and return success message = Case 1 Type 2
        //      Step 4 = fix hardlinks of evidence to activity
        console.log("hello")
        console.log(req.files)
        console.log(req.body)
        var files = req.files.DocFile;
        var DID = req.body.DID;
        var AID = req.body.AID;
        var PID = req.body.PID
        var name = files.name;
        var filename = files.name;
        var path = 'uploads/' + files.name;
        var point = filename.lastIndexOf(".");
        var ext = filename.substr(point);
        var fname = filename.substr(0, point)
        var folderId = UPLOAD_PATH.data.id
        var fileMetadata = {
            'name': files.name,
            parents: [folderId]
        };
        var md5 = files.md5;
        var sql = "Select * from capstone.documents where documents.md5 = (?);"
        var values = [md5]
        var count = 0;
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            if (result.length < 1) {
                console.log("check1")
                checkname(result);
            } else if (result.length >= 1) {
                var rows = JSON.parse(JSON.stringify(result[0]))
                rows = rows.Document_Name
                var resjson = {
                    case: "0",
                    data: result,
                    message: "Document already exists in system as " + rows
                };
                resp.send(resjson)
                console.log("response case 0") //// Case 0 docoument already exists
            }
        })

        function checkname() {
            var sql2 = "SELECT * FROM capstone.documents where documents.Document_Name = (?) && documents.Document_ID = (?);"
            var values2 = [files.name, DID];
            connection.query(sql2, values2, function (err, result) {
                if (err) callback(err);
                if (result.length < 1) {
                    getdata() // Case 1 Type 2 different file differet filename
                } else if (result.length >= 1) {
                    var rows = JSON.parse(JSON.stringify(result[0]))
                    insertfile(files, 1, rows); // Case 1 Type 1 different file same filename
                }
            });

        }

        function getdata() {
            var sql2 = "SELECT * FROM capstone.documents where documents.Document_ID = (?);"
            var values2 = [DID];
            connection.query(sql2, values2, function (err, result) {
                if (err) throw err;
                if (result) {
                    var rows = JSON.parse(JSON.stringify(result[0]))
                    insertfile(files, 2, rows);
                }
            });
        }


        function insertfile(files, type, result) {
            if (type == 1) { // Case 1 Type 1 same filename
                var vno = parseInt(result.version) + 1;
                var newfilename = fname + "v" + vno + ext;
                var newfilepath = 'uploads/' + fname + "v" + vno + ext;
                let uploadedimg = req.files.DocFile;
                uploadedimg.mv('public/uploads/' + newfilename, function (err) {
                    if (err) return console.log("file not moved to server");
                    else console.log("File uploaded");
                })
                var sql = "INSERT INTO `capstone`.`documents` (`Document_Name`, `Document_Route`, `Document_Ext`, `md5`, `isaversionof`, `version`, `upload_id`) VALUES (? , ? , ?, ?, ?, ?, ?);"
                var values = [newfilename, newfilepath, ext, md5, DID, vno, req.session.user[0].User_ID];
                connection.query(sql, values, function (err, result) {
                    if (err) console.log(err);
                    if (result) {
                        console.log("Record Inserted");
                        media = {
                            mimeType: mime.lookup('public/uploads/' + newfilename),
                            body: fs.createReadStream('public/uploads/' + newfilename)
                        };
                        uploadfile();
                        sql = "Update capstone.activity_evidences set documentID = ? where activityID = ? && pendingID = ? && documentID = ? "
                        values = [result.insertId, AID, PID, DID];
                        addDoc(sql, values);
                        var resjson = {
                            case: "11",
                            data: result,
                            message: "Document updated"
                        };
                        resp.send(resjson)
                        console.log("response case 11")
                    }
                });

                function uploadfile() {
                    fs.readFile('./config/credentials.json', (err, content) => {
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
                    var fileMetadata = {
                        'name': newfilename,
                        parents: [folderId]
                    };
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
                            console.log(newfilename + "Was not uploaded to Google Drive")
                        } else {
                            sql = "UPDATE `capstone`.`documents` SET `InDrive` = '1' WHERE (`Document_Route` = ?);"
                            values = 'uploads/' + newfilename;
                            connection.query(sql, values, function (err, result) {
                                if (err) throw err;
                                if (result) {
                                    console.log(files.name + " Uploaded to Google Drive")
                                    var fileid = file.data.id;
                                    sql = "UPDATE `capstone`.`documents` SET `DriveID` = ? WHERE (`Document_Route` = ?)";
                                    values = [fileid, 'uploads/' + newfilename];
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

            } else if (type == 2) { // Case 1 Type 2 differet filename
                var vno = parseInt(result.version) + 1;
                let uploadedimg = req.files.DocFile;
                uploadedimg.mv('public/uploads/' + files.name, function (err) {
                    if (err) return console.log("file not moved to server");
                    else console.log("File uploaded");
                })
                var sql = "INSERT INTO `capstone`.`documents` (`Document_Name`, `Document_Route`, `Document_Ext`, `md5`, `isaversionof`, `version`, `upload_id`) VALUES (? , ? , ?, ?, ?, ?, ?);"
                var values = [name, path, ext, md5, DID, vno, req.session.user[0].User_ID];
                console.log("sql values" + values);
                connection.query(sql, values, function (err, result) {
                    if (err) console.log(err);
                    if (result) {
                        console.log("Record Inserted");
                        media = {
                            mimeType: mime.lookup('public/uploads/' + files.name),
                            body: fs.createReadStream('public/uploads/' + files.name)
                        };
                        uploadfile();
                        sql = "Update capstone.activity_evidences set documentID = ? where activityID = ? && pendingID = ? && documentID = ? "
                        values = [result.insertId, AID, PID, DID];
                        addDoc(sql, values);
                        var resjson = {
                            case: "12",
                            data: result,
                            message: "Document updated"
                        };
                        resp.send(resjson)
                        console.log("response case 12")
                    }
                });

                function uploadfile() {
                    fs.readFile('./config/credentials.json', (err, content) => {
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
        }

    },

    TestingJSON: function (req, resp) {
        console.log("hello")
        console.log(req.files)
        console.log(req.body)
        var vno = 2;
        var files = req.files.DocFile;
        var filename = files.name;
        var path = 'uploads/' + files.name;
        var point = filename.lastIndexOf(".");
        var ext = filename.substr(point);
        var fname = filename.substr(0, point)
        var newfilename = fname + vno + ext;
        console.log(newfilename);
        var DID = req.body.DID;
        var sql2 = "SELECT * FROM capstone.documents where documents.Document_Name = (?) && documents.Document_ID = (?);"
        var values2 = [files.name, DID];
        connection.query(sql2, values2, function (err, result) {
            if (err) callback(err);
            if (result) {
                //console.log(result)
            }
        });
    },


    CreateFolder: function (req, resp) {
        var FolderName = (req.body.foldname);
        var IsFolder = (req.body.isFolder);
        var route = (req.body.route);

        var md5 = (req.body.md5);
        var uploadID = (req.body.UID);
        console.log("Folder Name: " + FolderName);
        console.log("Is folder: " + IsFolder);
        console.log("md5: " + md5);
        console.log("route: " + route);
        var sql = "INSERT INTO `capstone`.`documents` (`Document_Name`, `Document_Route`, `md5` , `upload_id`, `isfolder`) VALUES (?, ?, ?, ?, ?)";
        var values = [FolderName, route, md5, uploadID, IsFolder];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Folder Created");
            resp.redirect('/ViewDocument');
        });


    },

    PickerUploadJSON: function (req, resp) {
        console.log("test picker called")
        console.log(req.body);
        var DOCS = JSON.parse(req.body.data)
        console.log(DOCS)
        console.log(DOCS.length);
        var max = DOCS.length;
        var userauth = req.body.userauth;
        console.log(userauth);

        var count = 0;
        async.forEachOf(DOCS, function (value, key, callback) {
            var name = DOCS[key].name;
            var filename = DOCS[key].name;
            var path = 'uploads/' + DOCS[key].name;
            var desc = "picker test";
            var point = filename.lastIndexOf(".");
            var ext = filename.substr(point);
            var folderId = UPLOAD_PATH.data.id;
            var fileMetadata = {
                'name': DOCS[key].name,
                'parents': [folderId]
            };
            var media;
            downloadfile();

            /*
            downloadfile
            authorize
            downloadtodrive
            movetoserver
            uploadfile
            authorize
            uploadtodrive
            */

            function movetoserver(file, callback) {

                var point = file.lastIndexOf(".");
                var ext = file.substr(point);

                fs.readFile('')

                var sql = "INSERT INTO `capstone`.`documents` (`Document_Name`, `Document_Route`, `Document_Ext`, `md5`, `upload_id`) VALUES (? , ? , ?, ?, ?, ?);"
                var values = [name, path, ext, md5, req.session.user[0].User_ID];

                connection.query(sql, values, function (err, result) {
                    if (err) callback(err);
                    if (result) {
                        console.log("Record Inserted");
                        media = {
                            mimeType: mime.lookup('public/uploads/' + files[key].name),
                            body: fs.createReadStream('public/uploads/' + files[key].name)
                        };
                        sql = "INSERT INTO `capstone`.`activity_evidences` (`activityID`, `documentID`, `pendingID`) VALUES (?, ?, ?); "
                        values = [req.body.activityID, result.insertId, PID];
                        addDoc(sql, values);
                        callback();
                    }
                });
            }

            function downloadfile() {
                console.log("downloadfile")
                // console.log(JSON.parse(fs.readFileSync('./config/credentials.json')));

                fs.readFile('./config/credentials.json', (err, content) => {
                    if (err) return console.log('Error loading client secret file:', err);
                    authorize(JSON.parse(content), downloadtodrive);
                    console.log(content)
                });

            }

            function authorize(credentials, callback) {
                console.log("authorize")
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

            function downloadtodrive(auth) {
                console.log("downloadtodrive")
                const drive = google.drive({
                    version: 'v3',
                    auth
                });
                var dest = fs.createWriteStream('public/uploads/' + DOCS[key].name);
                drive.files.get({
                    fileId: DOCS[key].name,
                    alt: 'media'
                }, function (err, result) {
                    if (err) {
                        throw err;
                    } // Binary file content here
                    else {
                        let uploadedimg = result;
                        uploadedimg.mv('public/uploads/' + files.name, function (err) {
                            if (err) return console.log(err);
                            else console.log("File uploaded");
                        })
                        movetoserver(DOCS[key].name, uploadfile);
                    }
                });



            }

            function uploadtodrive(auth) {
                console.log("uploadtodrive")
                var fileMetadata = {
                    'name': newfilename,
                    parents: [folderId]
                };
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
                        console.log(newfilename + "Was not uploaded to Google Drive")
                    } else {
                        sql = "UPDATE `capstone`.`documents` SET `InDrive` = '1' WHERE (`Document_Route` = ?);"
                        values = 'uploads/' + newfilename;
                        connection.query(sql, values, function (err, result) {
                            if (err) throw err;
                            if (result) {
                                console.log(files.name + " Uploaded to Google Drive")
                                var fileid = file.data.id;
                                sql = "UPDATE `capstone`.`documents` SET `DriveID` = ? WHERE (`Document_Route` = ?)";
                                values = [fileid, 'uploads/' + newfilename];
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




    },

}
