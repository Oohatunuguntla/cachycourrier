var express = require('express');
var router = express.Router();
const authMiddleware = require('../middlewares/auth');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/home', authMiddleware.loginRequired, function(req, res, next) {
  
  const data = {};

  data.title = 'Home';
  data.user = req.user;

  res.render('home', data);
  
});

module.exports = router;
