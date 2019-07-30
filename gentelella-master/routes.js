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


//METRICS ROUTES
router.route('/QualityMetric').get(planCtrl.QualityMetric);
router.route('/addmetric').post(planCtrl.addmetric);
router.route('/addmetrictosource').post(planCtrl.addmetrictosource);
router.route('/editmetric').get(planCtrl.editmetric);
router.route('/altermetric').post(planCtrl.altermetric);


//MEASUREMENT ROUTES
router.route('/MeasurementPage').get(planCtrl.Measurement);
router.route('/SendMeasurement').post(planCtrl.SendMeasurement);
router.route('/alterplan').post(planCtrl.alterplan);
router.route('/ViewMeasurementDetails').get(planCtrl.ViewMeasurementDetails);

//CYCLE ROUTES
router.route('/addcycle').post(planCtrl.addcycle);
router.route('/Viewcycle').get(planCtrl.Viewcycle);


router.route('/AssignCycleandDeadline').post(planCtrl.AssignCycleandDeadline);






//OTHERS
router.route('/TestPage').get(planCtrl.Recommendations);
router.route('/Viewtasks').get(planCtrl.Viewtasks);
router.route('/CreateTask').get(planCtrl.CreateTask);
router.route('/SubmitTask').post(planCtrl.SubmitTask);
router.route('/AssignTask').get(planCtrl.AssignTask);
router.route('/CreateGrades').get(planCtrl.CreateGrades);
router.route('/assignplantomembers').get(planCtrl.assignplantomembers);
router.route('/AssignRecommendationToGroup').get(planCtrl.AssignRecommendationToGroup);
router.route('/Comparativeanalysis').get(planCtrl.Comparativeanalysis);
router.route('/Comparativeanalysis2').get(planCtrl.Comparativeanalysis2);
router.route('/edittask').get(planCtrl.edittask);
router.route('/altertask').post(planCtrl.altertask);
router.route('/ViewAllPlans').get(planCtrl.ViewAllPlans);


//--JSONCtrl--
router.route('/AssignGroupJSON').post(JSONCtrl.AssignGroupJSON);
router.route('/AssignTaskJSON').post(JSONCtrl.AssignTaskJSON);
router.route('/AddGradesJSON').post(JSONCtrl.AddGradesJSON);


//--DocCtrl--
router.route('/UploadDocument').get(DocCtrl.UploadDocument);
router.route('/SendDocument').post(DocCtrl.SendDocument);
router.route('/ViewDocument').get(DocCtrl.ViewDocument);
router.route('/SubmitReport').post(DocCtrl.SubmitReport);
router.route('/FinalReport').get(DocCtrl.FinalReport);


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


module.exports = router;
