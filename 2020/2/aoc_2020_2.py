def is_valid_a(input_line):
  min_len, max_len, char, password = input_line

  return password.count(char) in range(int(min_len), int(max_len) + 1)


def is_valid_b(input_line):
  indexes = [int(index) - 1 for index in input_line[:2]]
  char, password = input_line[2:]

  return (password[indexes[0]] == char) ^ (password[indexes[1]] == char)


def run(input_lines, validator):
  return len([input_line for input_line in input_lines if validator(input_line)])


if __name__ == '__main__':
  with open('input') as input_file:
      input_lines = [line.strip('\n') for line in input_file.readlines()]
      split_lines = [input_line[0].split('-') + [input_line[1][:-1], input_line[2]] for input_line in [line.split(' ') for line in input_lines]]
      print(f'Part A: {run(split_lines, is_valid_a)}\nPart B: {run(split_lines, is_valid_b)}')
