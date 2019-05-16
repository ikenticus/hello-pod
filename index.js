const express = require('express')
const fs = require('fs')
const app = express()
const port = 3000

app.get('/', (req, res) => res.send('Hello Pod!'))

app.get('/status', (req, res) => res.send(JSON.parse(fs.readFileSync('package.json').toString())))

app.listen(port, () => console.log(`Listening on port ${port}!`))
