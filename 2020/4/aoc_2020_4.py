import re


def get_dict(input_line):
  data = {}

  for item in input_line:
    if item:
      parts = item.split(':')
      data[parts[0]] = parts[1]

  return data


def validate_number(string, digits, end, min, max):
  digits = '{' + str(digits) + '}' if digits else '+'
  regex = f'(\d{digits}){end}$'
  match = re.match(regex, string)

  if match:
    val = int(match.group(1))
    return val >= min and val <= max

  return False


def run_part_a(input_lines):
  return [len(passport.keys()) == 8 or len(passport.keys()) == 7 and 'cid' not in passport.keys() for passport in input_lines].count(True)


def run_part_b(input_lines):
  return [(
    (len(passport.keys()) == 8 or len(passport.keys()) == 7 and 'cid' not in passport.keys()) and
    validate_number(passport['byr'], 4, '', 1920, 2002) and
    validate_number(passport['iyr'], 4, '', 2010, 2020) and
    validate_number(passport['eyr'], 4, '', 2020, 2030) and
    (validate_number(passport['hgt'], None, 'cm', 150, 193) or validate_number(passport['hgt'], None, 'in', 59, 76)) and
    re.match('#[a-f0-9]{6}', passport['hcl']) and
    passport['ecl'] in ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'] and
    validate_number(passport['pid'], 9, '', 0, 999999999)
  ) for passport in input_lines].count(True)


if __name__ == '__main__':
  with open('input') as input_file:
      input_lines = [get_dict(chunk.replace('\n', ' ').split(' ')) for chunk in input_file.read().split('\n\n')]    
      print(f'Part A: {run_part_a(input_lines)}\nPart B: {run_part_b(input_lines)}')
