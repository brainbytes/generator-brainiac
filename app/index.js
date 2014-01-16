'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');


var BrainiacGenerator = module.exports = function BrainiacGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(BrainiacGenerator, yeoman.generators.NamedBase);

BrainiacGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  // have Yeoman greet the user.
  console.log(this.yeoman);

  var prompts = [{
    name: 'projectName',
    message: 'What would you like to name your project?'
  }];

  this.prompt(prompts, function (props) {
    this.projectName = props.projectName;

    cb();
  }.bind(this));
};

BrainiacGenerator.prototype.app = function app() {
  this.mkdir('dist');
  this.mkdir('lib');
  this.mkdir('src');

  this.copy('_package.json', 'package.json');
  this.copy('_bower.json', 'bower.json');
};

BrainiacGenerator.prototype.projectfiles = function projectfiles() {
  this.copy('editorconfig', '.editorconfig');
  this.copy('coffeelint.json', '.coffeelint.json');
};
