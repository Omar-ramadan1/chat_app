
const USERS = require('../models/userModel')
module.exports = {
    getUser: async (req, res, next) => {
        const user = await USERS.find();
        res.json({
            result: user.map(res => {
                return {
                    id: res.id,
                    nickname: res.nickname,
                    bio: res.bio

                }
            })
        })
    },
    insertUser: async (req, res) => {
        const user = await new USERS({
            nickname: req.body.nickname,
            bio: req.body.bio
        }).save()
        
        res.json({
            "message": "isnerted successfullllllllllllllllly",
            "body": {
                id: user.id,
                nickname: user.nickname,
                bio: user.bio
            }
        });

    },
    deleteUser: async (req, res) => {
        const id = req.params.id;
        const del = await Users.findByIdAndRemove(id);
        res.json({ "delete": del });
    }

}