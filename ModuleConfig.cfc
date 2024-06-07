component {

    // Module Properties
    this.title = 'recaptcha3';
    this.author = 'Javier Quintero';
    this.description = 'Google Recaptcha Module V3';

    function configure() {
        settings = {
            apiUrl: 'https://www.google.com/recaptcha/api/siteverify',
            scriptUrl: 'https://www.google.com/recaptcha/api.js',
            secretKey: '',
            publicKey: '',
            score: 0.5
        };
    }

}
