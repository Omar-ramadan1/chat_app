var fs = require('fs');
var path = require('path');
const Busboy = require('busboy');
module.exports = {
    getImageResponse: async (req, res) => {
        var readStream = fs.createReadStream(path.normalize(__dirname + '/../images/' + req.query.name));
        res.writeHead(200, { 'Content-Type': 'image/jpg' });
        readStream.on('open', function () {
            // This just pipes the read stream to the response object (which goes to the client)
            readStream.pipe(res);
          });
    
          readStream.on('error', function(err) {
            res.end(err);
          });
        
    },
    saveImageResponse: async (req, res) => {
      var busboy = Busboy({ headers: req.headers });
      var writeStream = fs.createWriteStream(path.normalize(__dirname + '/../images/' + "tagraba.jpg"));
      // let upload = cloudinary.uploader.upload_stream({ public_id: name, folder: "ProfilePic" }, (err, result) => {
      //   console.log(err, result);
      //   res.end(JSON.stringify(result));
      // })
      busboy.on('file', function(fieldname, file, filename, encoding, mimetype ) {

        file.pipe(writeStream);
        // file.pipe(upload);
      });
      req.pipe(busboy);
      req.on("data", function(data) {
    });
     },

}