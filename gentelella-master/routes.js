var express = require('express');
var planCtrl = require('./controllers/planController');
var JSONCtrl = require('./controllers/JSONController');
var DocCtrl = require('./controllers/DocumentController');
var SessCtrl = require('./controllers/SessionController');
var CheckCtrl = require('./controllers/CheckingController');
var NotifCtrl = require('./controllers/NotifController');
var AdminCtrl = require('./controllers/AdminController')
var router = express.Router();

//--PlanCtrl--
//USERS ROUTES
router.route('/Viewusers').get(planCtrl.Viewusers);
router.route('/Createusers').get(planCtrl.Createusers);
router.route('/adduser').post(planCtrl.adduser);
router.route('/edituser').get(planCtrl.edituser);
router.route('/alteruser').post(planCtrl.alteruser);
router.route('/EditUserbyUser').get(planCtrl.EditUserAccount);
router.route('/alteruserbyuser').post(planCtrl.alteruserbyuser);
router.route('/ViewUserAccount').get(planCtrl.ViewUserAccount);
router.route('/ViewSubmissionDetails').get(planCtrl.ViewSubmissionDetails);


//GROUPS ROUTES
router.route('/ViewGroups').get(planCtrl.ViewGroups);
router.route('/CreateGroup').get(planCtrl.CreateGroup);
router.route('/add-group').post(planCtrl.addgroup);
router.route('/makeLeader').post(planCtrl.makeLeader);
router.route('/makeMember').post(planCtrl.makeMember);
router.route('/AssignMemberToGroup').get(planCtrl.assignmembertogroup);
router.route('/EditMemberToGroup').get(planCtrl.editmembertogroup);

//SOURCES ROUTES
router.route('/CreateSources').get(planCtrl.CreateSources);
router.route('/ViewSources').get(planCtrl.ViewSources);
router.route('/ViewMetricofSource').get(planCtrl.ViewMetricofSource);
router.route('/AddSource').post(planCtrl.AddSource);
router.route('/EditSource').get(planCtrl.EditSource);
router.route('/AlterSource').post(planCtrl.AlterSource);


//GOALS ROUTES
router.route('/QualityMetric').get(planCtrl.QualityMetric);
router.route('/addmetric').post(planCtrl.addmetric);
router.route('/addmetrictosource').post(planCtrl.addmetrictosource);
router.route('/editmetric').get(planCtrl.editmetric);
router.route('/altermetric').post(planCtrl.altermetric);
//router.route('/addduration').post(planCtrl.addduration);


//MEASUREMENT ROUTES
//router.route('/MeasurementPage').get(planCtrl.Measurement);
router.route('/SendMeasurement').post(planCtrl.SendMeasurement);
router.route('/alterplan').post(planCtrl.alterplan);
router.route('/ViewMeasurementDetails').get(planCtrl.ViewMeasurementDetails);
router.route('/QualityMetrics').get(planCtrl.QualityMetric);
router.route('/EditMeasurement').get(planCtrl.EditMeasurement);
router.route('/UpdateMeasurement').post(planCtrl.UpdateMeasurement);
router.route('/AuditMeasurement').post(planCtrl.AuditMeasurement); 
router.route('/ViewActivitiesUnderMeasurement').post(planCtrl.ViewActivitiesUnderMeasurement);
router.route('/BackToMeasurement').get(planCtrl.BackToMeasurement); 
router.route('/AnnualReport').post(planCtrl.AnnualReport); 

//ACTIVITY ROUTES
router.route('/AssignActivityToMember').get(planCtrl.Assignactivitytomember);
router.route('/AlterActivities').get(planCtrl.EditActivities);
router.route('/AlterActivities').post(planCtrl.AlterActivities);
router.route('/CategorizeActivities').post(planCtrl.CategorizeActivities);
router.route('/AssignActivityToGroupMember').get(planCtrl.AssignActivityToGroupMember);


//CYCLE ROUTES
router.route('/addcycle').post(planCtrl.addcycle);
router.route('/Viewcycle').get(planCtrl.Viewcycle);
router.route('/AssignCycleandDeadline').post(planCtrl.AssignCycleandDeadline);
router.route('/planPhase').post(planCtrl.planPhase);
router.route('/doPhase').post(planCtrl.doPhase);
router.route('/checkPhase').post(planCtrl.checkPhase);
router.route('/actPhase').post(planCtrl.actPhase);
router.route('/endPhase').post(planCtrl.endPhase);



router.route('/ActivityDetails').get(planCtrl.ActivityDetails);
router.route('/ActivityPendingDetails').get(planCtrl.ActivityPendingDetails);

//--JSONCtrl--
router.route('/AssignGroupJSON').post(JSONCtrl.AssignGroupJSON);
router.route('/EditGroupMemberJSON').post(JSONCtrl.EditGroupMemberJSON);
router.route('/AssignTaskJSON').post(JSONCtrl.AssignTaskJSON);
router.route('/AddGradesJSON').post(JSONCtrl.AddGradesJSON);
router.route('/AddActivitiesJSON').post(JSONCtrl.AddActivitiesJSON);
router.route('/AssignActivityJSON').post(JSONCtrl.AssignActivityJSON);
router.route('/AssignActivityToMemberJSON').post(JSONCtrl.AssignActivityToMemberJSON);
router.route('/AddOutputsJSON').post(JSONCtrl.AddOutputsJSON);
router.route('/AssignActivitiesToMeasurementJSON').post(JSONCtrl.AssignActivitiesToMeasurementJSON);
router.route('/AddMeasurementsJSON').post(JSONCtrl.AddMeasurementsJSON);
router.route('/AssignProgressJSON').post(JSONCtrl.AssignProgressJSON);
router.route('/AddCyclesJSON').post(JSONCtrl.AddCyclesJSON);
router.route('/CreateSourcesJSON').post(JSONCtrl.CreateSourcesJSON);
router.route('/TestNotif').post(JSONCtrl.TestNotif);
router.route('/AddfilestofoldersJSON').post(JSONCtrl.AddfilestofoldersJSON);

//==NotifCtrl==
router.route('/CreateNotif').post(NotifCtrl.CreateNotif);
router.route('/GetNotif').get(NotifCtrl.GetNotif);
router.route('/SetRead').post(NotifCtrl.SetRead);



//--DocCtrl--
router.route('/SendDocument').post(DocCtrl.SendDocument);
router.route('/SubmitReport').post(DocCtrl.SubmitReport);
router.route('/SendDocuments').post(DocCtrl.SendDocuments);
router.route('/PreCheck').post(DocCtrl.PreCheck);
router.route('/SendDocumentsJSON').post(DocCtrl.SendDocumentsJSON);
router.route('/TestingJSON').post(DocCtrl.TestingJSON);
router.route('/UpdateDocumentsJSON').post(DocCtrl.UpdateDocumentsJSON);
router.route('/CreateFolder').post(DocCtrl.CreateFolder);
router.route('/PickerUploadJSON').post(DocCtrl.PickerUploadJSON);
router.route('/ViewDocument').get(planCtrl.ViewDocument);
router.route('/UploadDocument').get(planCtrl.UploadDocument);
router.route('/AddFilesToFolder').get(planCtrl.AddFileToFolder);

//--SessCtrl
router.route('/RegisterAdminPage').post(SessCtrl.RegisterAdminPage);
router.route('/DebugCreate').post(SessCtrl.Register);
router.route('/DebugCreate2').post(SessCtrl.Register2);
router.route('/SessLogin').post(SessCtrl.Login);
router.route('/Logout').get(SessCtrl.Logout);
router.route('/Maintenance').get(SessCtrl.Maintenance);


//--CheckCtrl
router.route('/CheckingPage').get(CheckCtrl.CheckingPage);
router.route('/CheckDetails').get(CheckCtrl.CheckDetails);
router.route('/PreChecking').get(CheckCtrl.PreChecking);
router.route('/PreCheckingDetails').get(CheckCtrl.PreCheckingDetails);
router.route('/PreCheckingDetailsInsert').post(CheckCtrl.PreCheckingDetailsInsert);
router.route('/CheckingDetailsInsert').post(CheckCtrl.CheckingDetailsInsert);

//--AdminCtrl
router.route('/SystemMaintenance').get(AdminCtrl.SystemMaintenance);
router.route('/GenerateBackup').post(AdminCtrl.GenerateBackup);
router.route('/ShutSystem').post(AdminCtrl.ShutSystem);

//OTHERS
router.route('/TestPage').get(planCtrl.TestPage);
router.route('/ViewUsersSubmission').get(planCtrl.ViewUsersSubmission);
router.route('/ViewUsersSubmissionDetails').get(planCtrl.ViewUsersSubmissionDetails);
router.route('/ViewFolder').get(planCtrl.ViewFolder);
router.route('/ViewPersonalFolder').get(planCtrl.ViewPersonalFolder);

router.route('/CreateGrades').get(planCtrl.CreateGrades);
router.route('/assignplantomembers').get(planCtrl.assignplantomembers);
router.route('/AssignRecommendationToGroup').get(planCtrl.AssignRecommendationToGroup);
router.route('/Comparativeanalysis').get(planCtrl.Comparativeanalysis);
router.route('/Comparativeanalysis2').get(planCtrl.Comparativeanalysis2);
router.route('/ActionPlan').get(planCtrl.ActionPlan);
router.route('/home').get(planCtrl.Dashboards);


router.route('/CheckingAccordionPage').get(CheckCtrl.CheckingAccordionPage);
router.route('/CheckingAccordionGroupLeaderPage').get(CheckCtrl.CheckingAccordionGroupLeaderPage);

router.route('/ViewActivityEvidences').get(CheckCtrl.ViewActivityEvidences);
router.route('/ProgressPage').get(CheckCtrl.ProgressPage);
router.route('/ProgressDetailsPage').get(CheckCtrl.ProgressDetailsPage);




module.exports = router;
