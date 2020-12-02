const fs = require('fs');
const expense = require('./check_expense_report');

var input = fs.readFileSync('./01/input.txt', 'utf8');
var expense_entries = input.split('\n').map(element => parseInt(element, 10));

console.log("double check:", expense.double_check(expense_entries));
console.log("triple check:", expense.triple_check(expense_entries));
