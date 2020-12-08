passports = $stdin
  .read
  .split(/\n\n/)
  .map { |passport_input|
    passport_input
      .split(/\s/)
      .reduce({}) { |passport, field_input|
        key, value = field_input.split(':')
        passport.merge(key => value)
      }
  }

REQUIRED_KEYS = %w[byr iyr eyr hgt hcl ecl pid]

puts "Valid passports:", passports.count { |passport|
  REQUIRED_KEYS & passport.keys == REQUIRED_KEYS
}

def really_valid?(passport)
  return false unless REQUIRED_KEYS & passport.keys == REQUIRED_KEYS

  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  return false unless passport.fetch('byr').to_i >= 1920 && passport.fetch('byr').to_i <= 2002

  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  return false unless passport.fetch('iyr').to_i >= 2010 && passport.fetch('iyr').to_i <= 2020

  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  return false unless passport.fetch('eyr').to_i >= 2020 && passport.fetch('eyr').to_i <= 2030

  # hgt (Height) - a number followed by either cm or in:
  # If cm, the number must be at least 150 and at most 193.
  # If in, the number must be at least 59 and at most 76.
  if m = passport.fetch('hgt').match(/^(\d+)cm$/)
    return false unless m[1].to_i >= 150 && m[1].to_i <= 193
  elsif m = passport.fetch('hgt').match(/^(\d+)in$/)
    return false unless m[1].to_i >= 59 && m[1].to_i <= 76
  else
    return false
  end

  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  return false unless passport.fetch('hcl') =~ /^#[0-9a-f]{6}$/

  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  return false unless %w[amb blu brn gry grn hzl oth].include?(passport.fetch('ecl'))

  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  return false unless passport.fetch('pid') =~ /^[0-9]{9}$/

  return true
end

puts "Really valid passports:", passports.count { |passport|
  really_valid?(passport)
}
