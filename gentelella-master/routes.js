var express = require('express');
var planCtrl = require('./controllers/planController');
var JSONCtrl = require('./controllers/JSONController');
var DocCtrl = require('./controllers/DocumentController');
var SessCtrl = require('./controllers/SessionController');
var CheckCtrl = require('./controllers/CheckingController');
var router = express.Router();
//--PlanCtrl--
router.route('/Viewusers').get(planCtrl.Viewusers);
router.route('/Createusers').get(planCtrl.Createusers);
router.route('/Viewtasks').get(planCtrl.Viewtasks);
router.route('/CreateTask').get(planCtrl.CreateTask);
router.route('/SubmitTask').post(planCtrl.SubmitTask);
router.route('/AssignTask').get(planCtrl.AssignTask);
router.route('/ViewGroups').get(planCtrl.ViewGroups);
router.route('/CreateGroup').get(planCtrl.CreateGroup);
router.route('/Comparativeanalysis').get(planCtrl.Comparativeanalysis);
router.route('/Comparativeanalysis2').get(planCtrl.Comparativeanalysis2);
router.route('/add-group').post(planCtrl.addgroup);
router.route('/adduser').post(planCtrl.adduser);
router.route('/edituser').get(planCtrl.edituser);
router.route('/alteruser').post(planCtrl.alteruser);
router.route('/Recommendations').get(planCtrl.Recommendations);
router.route('/SendPlan').post(planCtrl.SendPlan);
router.route('/PlanPage').get(planCtrl.Planning);
router.route('/RecommendationNonAjax').get(planCtrl.RecommendationNonAjax);
router.route('/addrecommendation').post(planCtrl.addrecommendation);
router.route('/addrecommendationtoaccreditation').post(planCtrl.addrecommendationtoaccreditation);
router.route('/addcycle').post(planCtrl.addcycle);
router.route('/Viewcycle').get(planCtrl.Viewcycle);
router.route('/editrecommendation').get(planCtrl.editrecommendation);
router.route('/alterrecommendation').post(planCtrl.alterrecommendation);
router.route('/assignplantomembers').get(planCtrl.assignplantomembers);
router.route('/alterplan').post(planCtrl.alterplan);
router.route('/AssignMemberToGroup').get(planCtrl.assignmembertogroup);
router.route('/ViewAllPlans').get(planCtrl.ViewAllPlans);
router.route('/ViewPlanDetails').get(planCtrl.ViewPlanDetails);
router.route('/edittask').get(planCtrl.edittask);
router.route('/altertask').post(planCtrl.altertask);
router.route('/AssignRecommendationToGroup').get(planCtrl.AssignRecommendationToGroup);
router.route('/makeLeader').post(planCtrl.makeLeader);
router.route('/makeMember').post(planCtrl.makeMember);
router.route('/CreateAccreditation').get(planCtrl.CreateAccreditation);
router.route('/ViewAccreditation').get(planCtrl.ViewAccreditation);
router.route('/ViewRecommendationsofAccreditation').get(planCtrl.ViewRecommendationsofAccreditation);
router.route('/AddAccreditation').post(planCtrl.AddAccreditation);
router.route('/EditAccreditation').get(planCtrl.EditAccreditation);
router.route('/AlterAccreditation').post(planCtrl.AlterAccreditation);
router.route('/CreateGrades').get(planCtrl.CreateGrades);
router.route('/AssignCycleandDeadline').post(planCtrl.AssignCycleandDeadline);

//--JSONCtrl--
router.route('/AssignGroupJSON').post(JSONCtrl.AssignGroupJSON);
router.route('/AssignTaskJSON').post(JSONCtrl.AssignTaskJSON);
router.route('/AddGradesJSON').post(JSONCtrl.AddGradesJSON);

//--DocCtrl--
router.route('/UploadDocument').get(DocCtrl.UploadDocument);
router.route('/SendDocument').post(DocCtrl.SendDocument);
router.route('/ViewDocument').get(DocCtrl.ViewDocument);
router.route('/SubmitReport').post(DocCtrl.SubmitReport);

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


module.exports = router;
