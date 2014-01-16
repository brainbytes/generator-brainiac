module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON('package.json')
		
		coffee:
			compile:
				files:
					'temp/site.js': [
						'src/config/**/*.coffee'
						'src/app.coffee'
						'src/extensions/**/*.coffee'
						'src/schemas/**/*.coffee'
						'src/forms/**/*.coffee'
						'src/modules/**/*.coffee'
						'src/domains/**/*.coffee'
					]

		concat: {}

		haml:
			compile:
				options:
					language: 'coffee'
					target: 'js'
					precompile: true
					includePath: true
					pathRelativeTo: '../src/'
				files:
					'temp/templates.js': [
						'src/**/*.hamlc'
					]

		compass:
			dist:
				options:
					sassDir: 'src/style'
					cssDir: 'temp'

		copy:
			dev: 
				files: [
						cwd: './'
						src: 'temp/final.js'
						dest: 'dist/js/final.min.js'
					,
						cwd: './'
						src: 'temp/final.css'
						dest: 'dist/css/final.min.css'
				]

		clean: ['temp/']

		gitpull:
				dev: {}

		net:
			server:
				host: '<%= buildServerUrl %>'
				port: <%= buildServerPort %>
			client:
				host: '<%= buildServerUrl %>'
				port: <%= buildServerPort %>
				tasks: ['development']
		
		watch:
			scripts:
				files: ['src/**/*.coffee', 'src/**/*.scss', 'src/**/*.hamlc', 'lib/**/*.*']
				tasks: ['development-clean']

	grunt.loadNpmTasks 'grunt-contrib-compass'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-haml'
	grunt.loadNpmTasks 'grunt-net'
	grunt.loadNpmTasks 'grunt-git'

	development = ['coffee', 'compass', 'haml', 'copy'] # find some solution for concat?
	development_clean = development.concat ['clean']
	production = ['coffee', 'compass', 'haml', 'clean'] #include Closure Compiler later

	grunt.registerTask 'default', development_clean.concat ['watch']
	grunt.registerTask 'development', development
	grunt.registerTask 'development-clean', development_clean
	grunt.registerTask 'production', production
	grunt.registerTask 'server', ['net:server']
	grunt.registerTask 'pull-dev', ['gitpull'].concat development_clean
	grunt.registerTask 'push', ['net:client']