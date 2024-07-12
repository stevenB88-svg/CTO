// test/testApp.js

let chai, chaiHttp;
import('../app').then((expressAppModule) => {
    const app = expressAppModule.default; // Assuming 'default' is the exported instance of your Express app
    const path = require('path');
    const fs = require('fs');

    // Dynamically import chai and chai-http
    import('chai').then((chaiModule) => {
        chai = chaiModule.default || chaiModule;
        chaiHttp = require('chai-http');

        // Configure Chai
        chai.use(chaiHttp);
        const expect = chai.expect;

        describe('Express App', function() {
            describe('GET /', function() {
                it('Debería devolver el archivo index.html desde la carpeta public', function(done) {
                    chai.request(app)
                        .get('/')
                        .end(function(err, res) {
                            expect(res).to.have.status(200);
                            expect(res).to.be.html;

                            // Verificar que el archivo index.html existe
                            const indexPath = path.join(__dirname, '../public/index.html');
                            fs.access(indexPath, fs.constants.F_OK, (err) => {
                                expect(err).to.be.null;
                                done();
                            });
                        });
                });
            });
        });
    });
});
