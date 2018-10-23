require('envdir')()
const http = require('http');
const express = require('express')
const host = '0.0.0.0'
const port = 8080

const app = express()

app.get('/', (req, res) => {
  console.log('Received request for URL: ' + req.url);
  res.send(`Hello World Again!, ENV = ${process.env.DATABASE_URL}`);
})
app.listen(8080, '0.0.0.0');
console.log('listening on 0.0.0.0:8080')
