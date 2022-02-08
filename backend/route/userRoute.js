const express =require('express');
const router = express.Router();
const {getUser, insertUser,deleteUser} = require('../logic/userLogic');

router.get('/', getUser);
router.post('/',insertUser);
router.delete('/:id',deleteUser);


module.exports = router;