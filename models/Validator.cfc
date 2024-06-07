/**
 * Validates Google Recaptcha
 */
component accessors="true" singleton {

    /**
     * Validator Name
     */
    property name="name";

    /**
     * Recaptcha Service
     */
    property name="recaptchaService" inject="RecaptchaService@recaptcha3";

    /**
     * Constructor
     */
    Validator function init() {
        variables.name = 'Recaptcha3';
        return this;
    }

    /**
     * Will check if an incoming value validates
     *
     * @validationResult The result object of the validation
     * @target The target object to validate on
     * @field The field on the target object to validate on
     * @targetValue The target value to validate
     * @validationData The validation data the validator was created with
     */
    boolean function validate(
        required any validationResult,
        required any target,
        required string field,
        any targetValue,
        any validationData,
        struct rules
    ) {
        var result = recaptchaService.isValid(arguments.targetValue ?: '');

        if (!result) {
            var args = {
                message: 'You must prove you are not a robot!',
                field: arguments.field,
                validationType: getName(),
                validationData: arguments.validationData,
                rejectedValue: arguments.targetValue
            };
            validationResult.addError(validationResult.newError(argumentCollection = args));
            return false;
        }

        return true;
    }

}
