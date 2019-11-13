var express = require('express');
var planCtrl = require('./controllers/planController');
var JSONCtrl = require('./controllers/JSONController');
var DocCtrl = require('./controllers/DocumentController');
var SessCtrl = require('./controllers/SessionController');
var CheckCtrl = require('./controllers/CheckingController');
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


//GROUPS ROUTES
router.route('/ViewGroups').get(planCtrl.ViewGroups);
router.route('/CreateGroup').get(planCtrl.CreateGroup);
router.route('/add-group').post(planCtrl.addgroup);
router.route('/makeLeader').post(planCtrl.makeLeader);
router.route('/makeMember').post(planCtrl.makeMember);
router.route('/AssignMemberToGroup').get(planCtrl.assignmembertogroup);

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

//ACTIVITY ROUTES
router.route('/AssignActivityToMember').get(planCtrl.Assignactivitytomember);


//CYCLE ROUTES
router.route('/addcycle').post(planCtrl.addcycle);
router.route('/Viewcycle').get(planCtrl.Viewcycle);
router.route('/AssignCycleandDeadline').post(planCtrl.AssignCycleandDeadline);
router.route('/planPhase').post(planCtrl.planPhase);
router.route('/doPhase').post(planCtrl.doPhase);
router.route('/checkPhase').post(planCtrl.checkPhase);
router.route('/actPhase').post(planCtrl.actPhase);
router.route('/endPhase').post(planCtrl.endPhase);


router.route('/ViewDocument').get(planCtrl.ViewDocument);
router.route('/UploadDocument').get(planCtrl.UploadDocument);
router.route('/ActivityDetails').get(planCtrl.ActivityDetails);
router.route('/ActivityPendingDetails').get(planCtrl.ActivityPendingDetails);

//--JSONCtrl--
router.route('/AssignGroupJSON').post(JSONCtrl.AssignGroupJSON);
router.route('/AssignTaskJSON').post(JSONCtrl.AssignTaskJSON);
router.route('/AddGradesJSON').post(JSONCtrl.AddGradesJSON);
router.route('/AddActivitiesJSON').post(JSONCtrl.AddActivitiesJSON);
router.route('/AssignActivityJSON').post(JSONCtrl.AssignActivityJSON);
router.route('/AddOutputsJSON').post(JSONCtrl.AddOutputsJSON);
router.route('/AssignActivitiesToMeasurementJSON').post(JSONCtrl.AssignActivitiesToMeasurementJSON);
router.route('/AddMeasurementsJSON').post(JSONCtrl.AddMeasurementsJSON);
router.route('/AssignProgressJSON').post(JSONCtrl.AssignProgressJSON);



//--DocCtrl--
router.route('/SendDocument').post(DocCtrl.SendDocument);
router.route('/SubmitReport').post(DocCtrl.SubmitReport);
router.route('/SendDocuments').post(DocCtrl.SendDocuments);
router.route('/PreCheck').post(DocCtrl.PreCheck);
router.route('/SendDocumentsJSON').post(DocCtrl.SendDocumentsJSON);
router.route('/TestingJSON').post(DocCtrl.TestingJSON);
router.route('/UpdateDocumentsJSON').post(DocCtrl.UpdateDocumentsJSON);

//--SessCtrl
router.route('/DebugCreate').post(SessCtrl.Register);
router.route('/DebugCreate2').post(SessCtrl.Register2);
router.route('/SessLogin').post(SessCtrl.Login);
router.route('/Logout').get(SessCtrl.Logout);


//--CheckCtrl
router.route('/CheckingPage').get(CheckCtrl.CheckingPage);
router.route('/CheckDetails').get(CheckCtrl.CheckDetails);
router.route('/PreChecking').get(CheckCtrl.PreChecking);
router.route('/PreCheckingDetails').get(CheckCtrl.PreCheckingDetails);
router.route('/PreCheckingDetailsInsert').post(CheckCtrl.PreCheckingDetailsInsert);
router.route('/CheckingDetailsInsert').post(CheckCtrl.CheckingDetailsInsert);


//OTHERS
router.route('/TestPage').get(planCtrl.Recommendations);
router.route('/ViewUsersSubmission').get(planCtrl.ViewUsersSubmission);
router.route('/ViewUsersSubmissionDetails').get(planCtrl.ViewUsersSubmissionDetails);

router.route('/CreateGrades').get(planCtrl.CreateGrades);
router.route('/assignplantomembers').get(planCtrl.assignplantomembers);
router.route('/AssignRecommendationToGroup').get(planCtrl.AssignRecommendationToGroup);
router.route('/Comparativeanalysis').get(planCtrl.Comparativeanalysis);
router.route('/Comparativeanalysis2').get(planCtrl.Comparativeanalysis2);
router.route('/ActionPlan').get(planCtrl.ActionPlan);
router.route('/home').get(planCtrl.Dashboards);


router.route('/CheckingAccordionPage').get(CheckCtrl.CheckingAccordionPage);
router.route('/ViewActivityEvidences').get(CheckCtrl.ViewActivityEvidences);
router.route('/ProgressPage').get(CheckCtrl.ProgressPage);
router.route('/ProgressDetailsPage').get(CheckCtrl.ProgressDetailsPage);


module.exports = router;
