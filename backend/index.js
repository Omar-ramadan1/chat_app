const express = require("express");
var http = require("http");
//const cors = require("cors");
const app = express();
const port = process.env.PORT || 4000;
var server = http.createServer(app);
var io = require("socket.io")(server);
const imageRouter = require('./route/getimageRouter');
const UserRoute = require('./route/userRoute');
var bodyParser = require('body-parser');
const AuthRouter = require('./route/authRoute');


const mongoose = require('mongoose');

//middlewre
app.use(express.json());
var clients = {};
mongoose.connect('mongodb+srv://chat:chat@cluster0.g1kej.mongodb.net/myFirstDatabase?retryWrites=true&w=majority',

    {
        useNewUrlParser: true,
        useUnifiedTopology: true
    }
);
const connection = mongoose.connection;
connection.on('connected', () => { console.log("connect with cloud") });
connection.on('error', () => { console.log("error with database") });
const routes = require("./routes");
app.use([bodyParser.urlencoded({ extended: true }), express.json(), express.urlencoded({ extended: true })]);

app.use("/routes", routes);
app.use('/image', imageRouter);
app.use('/auth', AuthRouter);

app.use('/users', UserRoute);


// khaled omar

io.on("connection", (socket) => {
    console.log("connected");
    console.log(socket.id, "has join");
    socket.on("signin", (id) => {
        console.log(id, "sign in");
        clients[id] = socket;

    });
    socket.on("message", (msg) => {
        console.log(msg);
        let Receiver = msg.Receiver;
        // socket.emit("image",msg);
        console.log(clients[Receiver] == null);
        if (clients[Receiver])
            clients[Receiver].emit("message", msg);
    });

    socket.on("image", (msg) => {
        console.log(msg);
        console.log(msg);
        let Receiver = msg["Receiver"];
        //  socket.emit("image",msg);
        console.log(clients[Receiver] == null);
        if (clients[Receiver])
            clients[Receiver].emit("image", msg);
    });

    socket.on("video", (msg) => {
        console.log(msg);
        console.log(msg);
        let Receiver = msg["Receiver"];
        //  socket.emit("image",msg);
        console.log(clients[Receiver] == null);
        if (clients[Receiver])
            clients[Receiver].emit("video", msg);
    });

    socket.on("sharedmsg", (msg) => {
        console.log("lolololololololo");
        console.log(msg);
        let Receiver = msg["Receiver"];
        console.log(clients[Receiver] == null);
        if(clients[Receiver])
        clients[Receiver].emit("sharedmsg",msg);
     });


});
server.listen(port, "0.0.0.0", () => {
    console.log("server started");
})

