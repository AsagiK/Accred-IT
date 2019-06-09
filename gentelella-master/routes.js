var express = require('express');
var planCtrl = require('./controllers/planController');
var JSONCtrl = require('./controllers/JSONController');
var router = express.Router();

router.route('/Viewusers').get(planCtrl.Viewusers);
router.route('/Createusers').get(planCtrl.Createusers);
router.route('/Viewtasks').get(planCtrl.Viewtasks);
router.route('/CreateTask').get(planCtrl.CreateTask);
router.route('/CreateTaskGroup').get(planCtrl.CreateTaskGroup);
router.route('/AssignTask').get(planCtrl.AssignTask);
router.route('/ViewGroups').get(planCtrl.ViewGroups);
router.route('/CreateGroup').get(planCtrl.CreateGroup);
router.route('/Comparativeanalysis').get(planCtrl.Comparativeanalysis);
router.route('/Comparativeanalysis2').get(planCtrl.Comparativeanalysis2);
router.route('/add-group').post(planCtrl.addgroup);
router.route('/adduser').post(planCtrl.adduser);
router.route('/edituser').get(planCtrl.edituser);
router.route('/alteruser').post(planCtrl.alteruser);
router.route('/UploadDocument').get(planCtrl.UploadDocument);

router.route('/AssignTaskJSON').post(JSONCtrl.AssignTaskJSON);

module.exports = router;
