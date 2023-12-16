module.exports = function(app, forumData) {

    // Handle our routes
    app.get('/',function(req,res){
        if (req.session && req.session.userid) {
            res.render('index2.ejs', forumData)
        } else {
            res.render('index.ejs', forumData)
        }
    });

    app.get('/about',function(req,res){
        res.render('about.ejs', forumData);
    });

    app.get('/search',function(req,res){
        res.render("search.ejs", forumData);
    });

    app.get('/search-result', function (req, res) {
        //searching in the database
        let sqlquery = `
        SELECT topics.title, users.username, header, body
        FROM posts
        JOIN users ON idcreator = users.idusers
        JOIN topics ON posts.idtopic = topics.idtopic
        WHERE body LIKE '%${req.query.keyword}%'`
        // execute sql query
        db.query(sqlquery, (err, result) => {
            if (err) {
                console.log(sqlquery);
                res.redirect('./'); 
            }
            // create object with both forumData and Books table as its elements
            let newData = Object.assign({}, forumData, {posts:result});
            console.log(newData);
            res.render("searchresults.ejs", newData)
        })
    });

    app.get('/login', function (req,res) {
        res.render('login.ejs', forumData);                                                                     
    }); 
    app.post('/user',(req,res) => {
        let sqlquery = `
        SELECT username, password 
        FROM users
        WHERE username = ? 
        AND password = ?`
        let login = [req.body.username, req.body.password]
        db.query(sqlquery, login, (err, result) => {
            if (err) {
                res.redirect('./'); 
            }
            if(req.body.username == result[0].username && req.body.password == result[0].password){
                session=req.session;
                session.userid=req.body.username;
                res.send(`Hey there, welcome ${req.body.username} <a href=\'/logout'>click to logout</a>`);
            }
            else{
                res.send('Invalid username or password');
            }
        });
    })
    app.get('/logout',(req,res) => {
        req.session.destroy();
        res.redirect('/');
    });
    app.get('/register', function (req,res) {
        res.render('register.ejs', forumData);                                                                     
    });  

    app.post('/registered', function (req,res) {
        // saving data in database
        res.send(' Hello '+ req.body.first + ' '+ req.body.last +' you are now registered!  We will send an email to you at ' + req.body.email);                                                                              
    }); 

    app.get('/posts', function(req, res) {
        let sqlquery = `
        SELECT users.username, topics.title, posts.header, posts.body 
        FROM posts
        JOIN users ON posts.idcreator = users.idusers
        JOIN topics ON posts.idtopic = topics.idtopic
        `
        // execute sql query
        db.query(sqlquery, (err, result) => {
            if (err) {
                res.redirect('./'); 
            }
            // create object with both forumData and Books table as its elements
            let newData = Object.assign({}, forumData, {posts:result});
            console.log(newData);
            res.render("posts.ejs", newData)
        });
    });
    app.get('/users', function(req, res) {
        let sqlquery = `
        SELECT username
        FROM users`
        // execute sql query
        db.query(sqlquery, (err, result) => {
            if (err) {
                res.redirect('./'); 
            }
            // create object with both forumData and Books table as its elements
            let newData = Object.assign({}, forumData, {users:result});
            console.log(newData);
            res.render("users.ejs", newData)
        });
    });
    app.get('/profile/:username', function(req,res) {
        let sqlquery = `
        SELECT users.username, topics.title
        FROM users_topics
        JOIN users ON users_topics.idusers = users.idusers
        JOIN topics ON users_topics.idtopics = topics.idtopic
        WHERE username = ?`
        db.query(sqlquery, req.params.username, (err, result) => {
            if (err) {
                res.redirect('./'); 
            }
            // create object with both forumData and Books table as its elements
            let newData = Object.assign({}, forumData, {user: req.params.username}, {topics:result});
            console.log(newData);
            res.render("profile.ejs", newData)
        })
    })
    app.get('/topics', function(req, res) {
        let sqlquery = `
        SELECT title, description
        FROM topics
        `
        // execute sql query
        db.query(sqlquery, (err, result) => {
            if (err) {
                res.redirect('./'); 
            }
            // create object with both forumData and Books table as its elements
            let newData = Object.assign({}, forumData, {topics:result});
            console.log(newData);
            res.render("topics.ejs", newData)
        });
    });
    app.get('/topic/:topic', function(req, res) {
        let sqlquery = `
        SELECT users.username, topics.title
        FROM users_topics
        JOIN users ON users_topics.idusers = users.idusers
        JOIN topics ON users_topics.idtopics = topics.idtopic
        WHERE title = ?
        `
        let sqlquery2 = `
        SELECT topics.title, header, body
        FROM posts
        JOIN topics ON posts.idtopic = topics.idtopic
        WHERE title = ?
        `
        // execute sql query
        db.query(sqlquery, req.params.topic, (err, result) => {
            if (err) {
                res.redirect('./'); 
            }
            db.query(sqlquery2, req.params.topic, (err, result2) => {
                if (err) {
                    res.redirect('./'); 
                }

            let newData = Object.assign({}, forumData, {title: req.params.topic}, {users:result}, {posts:result2});
            console.log(newData);
            res.render("topicProfile.ejs", newData)
            });
        });
    });
    
    app.get('/addposts', (req, res) => {
        let sqlquery = `
        SELECT topics.title
        FROM users_topics
        JOIN users ON users_topics.idusers = users.idusers
        JOIN topics ON users_topics.idtopics = topics.idtopic
        WHERE username = ?`
        if (req.session && req.session.userid) {
            db.query(sqlquery, req.session.userid, (err, result) => {
                if (err) {
                    res.redirect('./'); 
                }
                let newData = Object.assign({}, forumData, {topics:result});
                res.render("addposts.ejs", newData)
            });
        } else {
            res.redirect('/login');
        }
    })

    app.post('/postadded', function (req,res) {
        // retrieve ids
        let sqluserid = `
        SELECT idusers
        FROM users
        WHERE username = ?`
        let iduser;
        let sqltopicid = `
        SELECT idtopic
        FROM topics
        WHERE title = ?`
        let idtopic;
        db.query(sqluserid, req.session.userid, (err, result) => {
            if (err) {
                return console.error(err.message);
            }
            iduser = result[0].idusers;
            db.query(sqltopicid, req.body.topicOptions, (err, result) => {
                if (err) {
                    return console.error(err.message);
                }
                idtopic = result[0].idtopic;
                let sqlquery = "INSERT INTO posts (idtopic, idcreator, header, body) VALUES (?,?,?,?)";
                // execute sql query
                let newrecord = [idtopic, iduser, req.body.header, req.body.body];
                db.query(sqlquery, newrecord, (err, result) => {
                  if (err) {
                    return console.error(err.message);
                  }
                  else {
                    res.send('your post has been added to database, titled: '
                              + req.body.header + ', body: ' + req.body.body 
                              + '</br><p><a href="./">Click Here to go back to index</a></p>');
                  }
                });
            });
        });
    });
}
