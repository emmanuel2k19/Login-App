console.log('Starting server...');
const express = require('express');
const bcrypt = require('bcrypt');
const { Pool } = require('pg');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// 🧠 PostgreSQL config (update with your actual values)
const pool = new Pool({
  user: 'Scooby2k19',        // e.g. 'postgres'
  host: 'localhost',
  database: 'Login',
  password: 'Oppsk2k19', // whatever password you chose during installation
  port: 5432
});

// 📥 Register Route
app.post('/api/register', async (req, res) => {
  console.log('Request recieved:' , req.body);
  const { username, password } = req.body;

  const hashedPassword = await bcrypt.hash(password, 10);

  try {
    const result = await pool.query(
      'INSERT INTO users (username, password) VALUES ($1, $2) RETURNING *',
      [username, hashedPassword]
    );
    res.status(201).json({ message: 'User registered successfully', user: result.rows[0] });
  } catch (err) {
    res.status(500).json({ error: 'Registration failed', details: err });
  }
});

// 🚀 Start the server
app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});