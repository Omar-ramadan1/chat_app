const express = require("express");
const router = express.Router();
const multer = require("multer");
const mongoose = require('mongoose');
const res = require("express/lib/response");
var id = mongoose.Types.ObjectId();

const storage = multer.diskStorage({
destination: (req,file,cb)=>{
    cb(null,"./uploads"); 
  },
 filename:(req,file,cb)=>{
    console.log(Date.now());
    console.log(id);
    // res.end();
    // cb(null, Date.now() +".jpg");/// timestop.jpg

},
});

const upload = multer({storage:storage});

router.route("/addimage").post(upload.single("img"), (req,res) => {
try{ 
    return  res.json({path: req.file.filename });     
}catch (e) {
    return res.json({error: e });
}
});
module.exports = router;