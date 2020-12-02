const expense = require('./check_expense_report');

test('simple list', () => {
  expect(expense.double_check([1, 2019])).toBe(2019);
});

test('simple list 2', () => {
  expect(expense.double_check([1000, 1020])).toBe(1020000);
});

test('bigger list', () => {
  expect(expense.double_check([1, 2, 2019])).toBe(2019);
});

test('bigger list', () => {
  expect(expense.double_check([2, 1, 2019])).toBe(2019);
});

test('main list', () => {
  expect(expense.double_check([1721, 979, 366, 299, 675, 1456])).toBe(514579);
});

test('triple check', () => {
  expect(expense.triple_check([1721, 979, 366, 299, 675, 1456])).toBe(241861950);
});
