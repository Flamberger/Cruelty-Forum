module.exports = function(app, forumData) {

    // Handle our routes
    app.get('/',function(req,res){
        res.render('index.ejs', forumData)
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
        SELECT users.username, topics.title
        FROM users_topics
        JOIN users ON users_topics.idusers = users.idusers
        JOIN topics ON users_topics.idtopics = topics.idtopic
        `
        // execute sql query
        db.query(sqlquery, (err, result) => {
            if (err) {
                res.redirect('./'); 
            }
            // create object with both forumData and Books table as its elements
            let newData = Object.assign({}, forumData, {users:result});
            // mark out replicant Usernames without 
            let hold = newData.users;
            let i = 0;
            let k = 0;
            while(k < hold.length) {
                for (j = i+1; j<hold.length; j++) {
                    if (hold[i].username == hold[j].username) {
                        hold[j].username += '_21899879765487&98465543218465-';
                    } else {
                        i = j;
                        k = j;
                        break;
                    }
                }
                k++;
            }
            console.log(newData);
            res.render("users.ejs", newData)
        });
    });
    app.get('/topics', function(req, res) {
        let sqlquery = `
        SELECT users.username, topics.title
        FROM users_topics
        JOIN users ON users_topics.idusers = users.idusers
        JOIN topics ON users_topics.idtopics = topics.idtopic
        `
        // execute sql query
        db.query(sqlquery, (err, result) => {
            if (err) {
                res.redirect('./'); 
            }
            // create object with both forumData and Books table as its elements
            let newData = Object.assign({}, forumData, {users:result});
            // mark out replicant Usernames without 
            let hold = newData.users;
            let i = 0;
            let k = 0;
            while(k < hold.length) {
                for (j = i+1; j<hold.length; j++) {
                    if (hold[i].title == hold[j].title) {
                        hold[j].title += '_21899879765487&98465543218465-';
                    } else {
                        i = j;
                        k = j;
                        break;
                    }
                }
                k++;
            }
            console.log(newData);
            res.render("topics.ejs", newData)
        });
    });

    app.get('/addbooks', (req, res) => {res.render("book.ejs", forumData)});

    app.post('/bookadded', function (req,res) {
        // saving data in database
        let sqlquery = "INSERT INTO books (name, price) VALUES (?,?)";
        // execute sql query
        let newrecord = [req.body.name, req.body.price];
        db.query(sqlquery, newrecord, (err, result) => {
          if (err) {
            return console.error(err.message);
          }
          else {
            res.send(' This book is added to database, name: '
                      + req.body.name + ', price: £'+ req.body.price +'</br><p><a href="./">Click Here to go back to index</a></p>');
          }
        });
    });
}
