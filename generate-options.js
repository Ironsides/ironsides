var filename = process.argv[2]

var match = /purchase-agreement-(\w+)-(\w+)\./.exec(filename)

var trigger = match[1]
var consideration = match[2]

var templateOptions = { }

templateOptions.singleTrigger = ( trigger === 'true' )

if (consideration === 'cash') {
  templateOptions.allCash = true }
else if (consideration === 'ip') {
  templateOptions.allIP = true }
else if (consideration === 'mixed') {
  templateOptions.cashAndIP = true }

process.stdout.write(JSON.stringify(templateOptions))
