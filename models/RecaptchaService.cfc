/**
 * This CFC allows you to connect to the reCaptcha service for rendering and validation
 */
component singleton accessors="true"{

	// DI
	property name="config" inject="coldbox:modulesettings:recaptcha";

	/**
	* Google Secret Key
	*/
	property name="secretKey" 	default="";

	/**
	* Google Public Key
	*/
	property name="publicKey" 	default="";

	/**
	 * Constructor
	 *
	 * @secretKey The google secret key
	 * @publicKey The google public key
	 */
	RecaptchaService function init( secretKey="", publicKey="" ){

		variables.secretKey = arguments.secretKey;
		variables.publicKey = arguments.publicKey;

		return this;
	}

	/**
	 * Execute after DI completes
	 */
	function onDIComplete(){
		variables.secretKey = variables.config.secretKey;
		variables.publicKey = variables.config.publicKey;
	}

	/**
	 * Validate the captcha
	 *
	 * @response The Response from the form
	 * @remoteIP The remote IP
	 */
	boolean function isValid( string response, string remoteIP=getRemoteIp() ){
		var result = httpSend( response, remoteIp );

		var check = deserializeJSON( result.filecontent );

		return check.success;
	}

	/**
	 * Send the HTTP request
	 *
	 * @response The Response from the form
	 * @remoteIP The remote IP
	 */
	struct function httpSend( required string response, string remoteIP ){

		var httpService = new http(
			method  = "post",
			url 	= config.apiUrl,
			timeout = 10
		);

	    httpService.addParam( type="header",    name="Content-Type", value="application/x-www-form-urlencoded");
	    httpService.addParam( type="formfield", name="response", 	 value="#arguments.response#");
	    httpService.addParam( type="formfield", name="remoteip",  	 value="#arguments.remoteIp#");
	    httpService.addParam( type="formfield", name="secret",		 value="#getSecretKey()#");

		return httpService.send().getPrefix();
	}

	/*********************************** PRIVATE ***********************************/

	/**
	* Get Real IP, by looking at clustered, proxy headers and locally.
	*/
	private function getRemoteIp(){
		var headers = GetHttpRequestData().headers;

		// Very balanced headers
		if( structKeyExists( headers, 'x-cluster-client-ip' ) ){
			return headers[ 'x-cluster-client-ip' ];
		}
		if( structKeyExists( headers, 'X-Forwarded-For' ) ){
			return headers[ 'X-Forwarded-For' ];
		}

		return len( cgi.remote_addr ) ? cgi.remote_addr : '127.0.0.1';
	}

}