var express = require('express');
var planCtrl = require('./controllers/planController');
var JSONCtrl = require('./controllers/JSONController');
var DocCtrl = require('./controllers/DocumentController');
var SessCtrl = require('./controllers/SessionController');
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
router.route('/addcycle').post(planCtrl.addcycle);
router.route('/Viewcycle').get(planCtrl.Viewcycle);
router.route('/editrecommendation').get(planCtrl.editrecommendation);
router.route('/alterrecommendation').post(planCtrl.alterrecommendation);
router.route('/assignplantogroup').get(planCtrl.assignplantogroup);
router.route('/alterplan').post(planCtrl.alterplan);
router.route('/AssignMemberToGroup').get(planCtrl.assignmembertogroup);
router.route('/ViewAllPlans').get(planCtrl.ViewAllPlans);
router.route('/ViewPlanDetails').get(planCtrl.ViewPlanDetails);

//--JSONCtrl--
router.route('/AssignGroupJSON').post(JSONCtrl.AssignGroupJSON);
router.route('/viewplantest').post(JSONCtrl.ViewPlanTest);
//--DocCtrl--
router.route('/UploadDocument').get(DocCtrl.UploadDocument);
router.route('/SendDocument').post(DocCtrl.SendDocument);
router.route('/ViewDocument').get(DocCtrl.ViewDocument);
//--SessCtrl
router.route('/DebugCreate').post(SessCtrl.Register);
router.route('/DebugCreate2').post(SessCtrl.Register2);
router.route('/SessLogin').post(SessCtrl.Login);
router.route('/Logout').get(SessCtrl.Logout);



module.exports = router;
