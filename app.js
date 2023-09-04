const express = require('express');
const app = express();
const PORT = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// eval vulnerability
app.post('/eval', (req, res) => {
    const userCode = req.body.code;
    eval(userCode);
    res.send('Code executed!');
});

// Open redirect vulnerability
app.get('/redirect', (req, res) => {
    const target = req.query.target;
    res.redirect(target);
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
