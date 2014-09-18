module.exports = function (grunt) {
	grunt.registerTask('prod', [
        'sails-linker:devJs',
        'sails-linker:devJsUp',
        'sails-linker:devStyles',
        'sails-linker:devTpl',
        'sails-linker:devJsJade',
        'sails-linker:devStylesJade',
        'sails-linker:devTplJade'
		/*'compileAssets',
		'concat',
		'uglify',
		'cssmin',
		'sails-linker:prodJs',
		'sails-linker:prodStyles',
		'sails-linker:devTpl',
		'sails-linker:prodJsJade',
		'sails-linker:prodStylesJade',
		'sails-linker:devTplJade'*/
	]);
};
