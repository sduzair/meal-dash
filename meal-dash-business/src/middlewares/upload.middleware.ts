/* eslint-disable prettier/prettier */
const fs = require('fs');
const multer = require('multer');
   
const storage = multer.diskStorage({

    // file destination 
    destination: function (req, file, cb) {
        // check if folder exists 
        if (!fs.existsSync('./uploads/')) {
            fs.mkdir('./uploads/', (err) => {
                cb(null, './uploads/');
            })
        } else {
            cb(null, './uploads/');
        }
    },

    filename: function (req, file, cb) {
        req.body.imagePath =  Date.now() + '-' + file.originalname;
        cb(null, Date.now() + '-' + file.originalname);
    },

})

const fileFilter = (req, file, cb) => {
    // reject a file
    if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png' || file.mimetype === 'image.jpg') {
      cb(null, true);
    } else {
      cb(null, false);
    }
  };

const upload = multer({ storage: storage, limits: { fileSize: 5000000 }, fileFilter: fileFilter })

export default upload;