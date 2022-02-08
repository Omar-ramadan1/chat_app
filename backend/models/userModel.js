const mongoose = require('mongoose');
const users = mongoose.Schema({
    nickname:String,
    bio:String,
})

module.exports = mongoose.model('USERS',users);