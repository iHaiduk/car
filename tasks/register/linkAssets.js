module.exports = function (grunt) {
	grunt.registerTask('linkAssets', [
		'sails-linker:devJs',
        'sails-linker:devJsUp',
        'sails-linker:devStyles',
        'sails-linker:promoStyles',
        'sails-linker:promoJs',
		'sails-linker:devTpl',
		'sails-linker:devJsJade',
		'sails-linker:devStylesJade',
		'sails-linker:devTplJade'
	]);
};
