
const express = require('express');
const app = express();
const path = require ('path')
// app.use(express.json())

const PORT = 3000

app.use(express.static(path.join(__dirname, 'public')));

// Ruta principal, sirve un HTML que muestra imágenes
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT);
// app.listen(PORT, () => {
//     console.log('Sever run on port ${PORT}');
// });
