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
  const type = req.body.tenant;
  var type1 = '';
  if(type === "true") type1 = 'Tenant';
  else type1 = 'Landlord';

  const sql = 'INSERT INTO users (name, email, password, type) VALUES (?, ?, ?, ?)';
  connection.query(sql, [name, email, password, type1], (err, result) => {
    
    if (err) {
      res.json({
        success: false,
        message: 'Error inserting user into database',
      });
    } else {
      res.json({
        success: true,
        message: 'User successfully registered',
        type: type1,
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

        connection.query('SELECT type from users WHERE email = ?', [email],(err, result) => {
          console.log(result[0]['type']);
          if(err) throw err;
          if(result.length>0 && result[0]['type'] == 'Tenant') {
            res.json({
            success: true,
            message: 'User successfully logged in',
            type: 'Tenant',
            });
          }

          else if(result.length>0 && result[0]['type'] == 'Landlord') {
            res.json({
            success: true,
            message: 'User successfully logged in',
            type: 'Landlord',
            });
          }
        })
      }
      
      else {
        res.json({
          success: false,
          message: 'Incorrect username/password',
        });
      }
    });
  });
			

  app.post('/search', (req, res) => {										// Authorize username and password for login
	
    const loc = req.body.location;
    const rent = parseInt(req.body.rent);
    const amList = JSON.parse(req.body.amenitiesList);

    const sql = `SELECT * FROM propertyDetails WHERE location LIKE '%${loc}%' AND rent <= ${rent}`;
    console.log(amList);
  // AND (select amenities.amenity from property INNER JOIN amenities ON property.id = amenities.id) IN amList
      connection.query(sql, [loc, rent], (err, results) => {
        if (err) throw err;
        
        if(results.length > 0) {
          res.json({
            success: true,
            message: 'Data fetched',
            results
          });
        }
        
        else {
          res.json({
            success: false,
            message: 'error or empty database',
          });
        }
      });
    });


    app.post('/list', (req, res) => {
      const loc = req.body.location;
      const rent = req.body.rent;
      const size = req.body.size;
      const amList = req.body.amenitiesList;
      const uname = req.body.uname;
      
      console.log(rent);
      console.log(amList);
      const sql = 'INSERT INTO propertyDetails (location, rent, size, amenities, username) VALUES (?, ?, ?, ?, ?)';
      connection.query(sql, [loc, rent, size, amList, uname], (err, result) => {
        console.log(result);
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


    app.post('/propList', (req, res) => {										// Authorize username and password for login
	
      const uname = req.body.uname;
  
      const sql = `SELECT * FROM propertyDetails WHERE username =  '${uname}'`;

        connection.query(sql, (err, results) => {
          if (err) throw err;
          
          if(results.length > 0) {
            res.json({
              success: true,
              message: 'Data fetched',
              results
            });
          }
          
          else {
            res.json({
              success: false,
              message: 'error or empty database',
            });
          }
        });
      });

      app.post('/track', (req, res) => {										// Authorize username and password for login
	
        const uname = req.body.landlordUsername;
    
        const sql = `SELECT * FROM rentalRequests WHERE landlordUsername =  '${uname}'`;
  
          connection.query(sql, (err, results) => {
            if (err) throw err;
            
            if(results.length > 0) {
              res.json({
                success: true,
                message: 'Data fetched',
                results
              });
            }
            
            else {
              res.json({
                success: false,
                message: 'error or empty database',
              });
            }
          });
        });


      app.post('/apply', (req, res) => {
        const tname = req.body.tenantUsername;
        const propID = req.body.propertyID;
        const lname = req.body.landlordUsername;
        
        console.log(propID);
        const sql = 'INSERT INTO rentalRequests (tenantUsername, propertyID, landlordUsername) VALUES (?, ?, ?)';
        connection.query(sql, [tname, propID, lname], (err, result) => {
          console.log(result);
          if (err) {
            res.json({
              success: false,
              message: 'Error inserting user into database',
            });
          } else {
            res.json({
              success: true,
              message: 'Applied to property',
            });
          }
        });
      });

      app.post('/properties', (req, res) => {
    
        const searchLocation = req.body.location;
        const searchRent = parseInt(req.body.rent);
        const searchRadius = req.body.radius;
        const searchLatitude = parseFloat(req.body.latitude);
        const searchLongitude = parseFloat(req.body.longitude);
        const city = req.body.city;
    
        console.log(searchLocation);
        console.log(searchRadius);
        console.log(searchRent);
        console.log(searchLatitude);
        console.log(searchLongitude);
      
        // SQL query to search for properties
        const sql = `
          SELECT propertyID, city, location, rent, size, amenities, latitude, longitude,
                 ( 6371 * acos( cos( radians(?) ) * cos( radians( latitude ) )
                   * cos( radians( longitude ) - radians(?) ) + sin( radians(?) )
                   * sin( radians( latitude ) ) ) ) AS distance
          FROM propertyDetails
          WHERE city LIKE '%${city}%'
          AND rent <= ?
          HAVING distance <= ?
          ORDER BY distance ASC;
        `;
        
        connection.query(sql, [searchLatitude, searchLongitude, searchLatitude, searchRent, searchRadius], (error, results) => {
          if (error) {
            res.status(500).json({ error: error.message });
          } else {
            console.log(results);
            
            res.json({ 
              results: results,
            });
          }
        });
      
      });


app.listen(3000, () => {
  console.log('Server listening on port 3000');
});
