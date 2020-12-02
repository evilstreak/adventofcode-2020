const check_expense_report = (entries) => {
//  var entry = entries.find(a =>
//    entries.find(b =>
//      (a + b == 2020)
//    )
//  );
//
//  return entry * (2020 - entry);

  var check;

  var entry = entries.find(a =>
    entries.find(b => {
      if (a + b == 2020) {
        check = a * b;
        return true;
      }
    })
  );

  return check;
};

const triple_check = (entries) => {
  var check;

  var entry = entries.find(a =>
    entries.find(b =>
      entries.find(c => {
        if (a + b + c == 2020) {
          check = a * b * c;
          return true;
        }
      })
    )
  );

  return check;
};

exports.double_check = check_expense_report;
exports.triple_check = triple_check;
