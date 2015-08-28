var fs = require('fs')
var path = require('path')
var possible = require('possible-objects')
var Mustache = require('mustache')

var base = process.argv[2]

var templateFile = ( base + '.commonform' )
var template

var schemaFile = ( base + '.schema' )
var schema

if (!fs.existsSync(templateFile)) {
  console.error('Missing ' + templateFile)
  process.exit(1) }

template = fs.readFileSync(templateFile).toString()

if (!fs.existsSync(schemaFile)) {
  schema = { } }
else {
  schema = JSON.parse(fs.readFileSync(schemaFile)) }

if (!fs.existsSync(path.join(__dirname, 'variants'))) {
  fs.mkdirSync(path.join(__dirname, 'variants')) }

possible(schema)
  .forEach(function(variant, index) {
    fs.writeFileSync(
      path.join(__dirname, 'variants', ( base + '.' + index + '.variant' )),
      Mustache.render(template, variant)
        .replace(/\n+/g, '\n')) })
