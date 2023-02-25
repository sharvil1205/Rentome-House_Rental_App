const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const cors = require("cors");

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'password',
  database: 'house_rental_app',
});

connection.connect((err) => {
  if (err) throw err;
  console.log('Connected to MySQL database!');
});

app.post('/signup', (req, res) => {
  const name = req.body.name;
  const email = req.body.email;
  const password = req.body.password;
  const sql = 'INSERT INTO users (name, email, password) VALUES (?, ?, ?)';
  connection.query(sql, [name, email, password], (err, result) => {
    if (err) {
      res.json({
        success: false,
        message: 'Error inserting user into database',
      });
    } else {
      res.json({
        success: true,
        message: 'User successfully registered',
      });
    }
  });
});


app.post('/login', (req, res) => {										// Authorize username and password for login
	
	const email = req.body.email;
	const password = req.body.password;
	const sql = 'SELECT * FROM users WHERE email = ? AND password = ?';

		connection.query(sql, [email, password], (err, results) => {
			if (err) throw err;
      
      if(results.length > 0) {
        res.json({
          success: true,
          message: 'User successfully logged in',
        });
      }
      
      else {
        res.json({
          success: false,
          message: 'Incorrect username/password',
        });
      }
    });
  });
			


app.listen(3000, () => {
  console.log('Server listening on port 3000');
});
