# ColdBox ReCAPTCHA Google v3.0 Module

This module contains helpers for using Google's ReCAPTCHA API.

reCAPTCHA is a free service that protects your site from spam and abuse. It uses advanced risk analysis techniques to tell humans and bots apart.

reCAPTCHA v3 returns a score for each request without user friction. The score is based on interactions with your site and enables you to take an appropriate action for your site. Register reCAPTCHA v3 keys here: https://g.co/recaptcha/v3.

## LICENSE

Apache License, Version 2.0.

## SYSTEM REQUIREMENTS

- Lucee 5+
- ColdFusion 11+
- ColdBox 5+

## INSTRUCTIONS
Just drop into your `modules` folder or use the CommandBox to install

`box install recaptcha3`

## USAGE

### Settings

Get an API key pair at http://www.google.com/recaptcha/admin and add the following settings to your `Coldbox.cfc` under a `recaptcha3` structure within the `moduleSettings` structure:

```js
moduleSettings = {
	// recaptcha settings
	recaptcha3 = {
    	secretKey 	= "Secret key",
    	publickey 	= "Site key",
	};
}
```

### Rendering Recaptcha

In any form you wish to add the reCaptcha widget which is a button with the invisible reCaptcha embedded.

Here is an example of usage:

```html
#renderview(
	view="widget",
	module="recaptcha",
	args={
		id = "button-id",
		label = "Your Label",
		class = "text-center",
		callbackFunction = "onSubmit",
		loadRecaptchaApi = "true"
	}
)#
```

The arguments the widget receives are the following arguments:
- `id` -> optional argument to set an id to the button so you can manipulate it via css/js
- `label` -> It can be any text you want and will be used as the label for your button.
- `class` -> The class that will be applied to the button element.
- `callbackFunction` -> The callback function to handle the token.
	```js
   function onSubmit(token) {
     document.getElementById("your-form-id").submit();
   }
	```

- `loadRecaptchaApi` -> a true/false flag (defaults to false) if you want to delegate the widget the task to load the javascript api, otherwise you will have to do it yourself in your layout like so:

```js
 < script src="https://www.google.com/recaptcha/api.js"></script>
 ```

### Validation

Validation can be done manually or using or custom validator that leverages the `cbValidation` module (https://forgebox.io/view/cbValidation).

### Custom Validator

In your handler for the post of the form, or in a model object you can then use the included Validator. Here is an example of using it in a model object:

```js
this.constraints = {
	"body" 	: { required : true },
	"recaptcha" : { validator: "Validator@recaptcha" }
}
```

In the above example, your handler would just need to set the recaptcha property on the model object to the `g-recaptcha-response` value that is part of the form payload.

### Manual Validation

There also is a `RecaptchaService@recaptcha` Wirebox mapping you can use to validate manually if you prefer to not use the `cbvalidation` integration. In your handler:

```js
var recaptchaOK = getInstance( "RecaptchaService@recaptcha" ).isValid( rc[ "g-recaptcha-response" ] );

if ( !recaptchaOK ){
    writeOutput( "Prove you have a soul!" );
}
```