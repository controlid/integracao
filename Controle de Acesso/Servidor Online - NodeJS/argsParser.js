var yargs = require("yargs")
.parserConfiguration({
  "duplicate-arguments-array": true,
})

// Terminal arguments setup
const args = yargs
  .option('ip', {
    describe: 'Device IP address',
    demandOption: true,
    type: 'string',
    default: '192.168.0.129'
  })
  .option('test', {
    describe: 'Test number to be executed',
    demandOption: true,
    type: 'number',
    default: 1
  })
  .option('userId', {
    describe: 'Unique identifier of the user',
    demandOption: true,
    type: 'number',
    default: 1000
  })
  .option('userName', {
    describe: 'Text containing the name of a user',
    demandOption: true,
    type: 'string',
    default: 'Remote'
  })
  .option('qrCodeId', {
    describe: 'Unique identifier of an identification QR code',
    demandOption: true,
    type: 'number',
    default: 10
  })
  .option('qrCodeValueAlphaNumeric', {
    describe: 'Content represented in the QR code',
    demandOption: true,
    type: 'string',
    default: 'Test'
  })
  .option('qrCodeValueNumeric', {
    describe: 'Content represented in the QR code',
    demandOption: true,
    type: 'number',
    default: 123456
  })
  .option('cardId', {
    describe: 'Unique identifier of an identification card',
    demandOption: true,
    type: 'number',
    default: 10
  })
  .option('cardNumber', {
    describe: 'Card number printed on the card (in the format 123,45678) without commas',
    demandOption: true,
    type: 'number',
    default: 12345678
  })
  .option('pinId', {
    describe: 'Unique identifier of an identification PIN',
    demandOption: true,
    type: 'number',
    default: 1001
  })
  .option('pinValue', {
    describe: 'This field indicates the value of the PIN',
    demandOption: true,
    type: 'string',
    default: '1234'
  })
  .option('bioId', {
    describe: 'Unique identifier of a biometric template',
    demandOption: true,
    type: 'number',
    default: 1001
  })
  .option('password', {
    describe: 'String that represents the user password',
    demandOption: true,
    type: 'string',
    default: '1234'
  })
  .argv;

  module.exports = args;