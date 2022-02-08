const express = require('express');
const router = express.Router();
const {signup, login,getUser}=require('../logic/authLogic');

router.post('/signup',signup);
router.post('/login',login);
router.get('/signup',getUser)



module.exports =router;