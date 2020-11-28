def matches_criteria(password, max_two=False):
  password_digits = [int(digit) for digit in str(password)]
  current_repeat = 1
  repeats = []

  for index in range(len(password_digits)):
    if index > 0:
      current = password_digits[index]
      last = password_digits[index - 1]

      if current < last:
        return False  

      if current == last:
        current_repeat += 1
      else:
        repeats.append(current_repeat)
        current_repeat = 1

  repeats.append(current_repeat)

  return (2 in repeats) if max_two else (max(repeats) >= 2)


def run_part_a(input_range):
  return len([password for password in input_range if matches_criteria(password)])


def run_part_b(input_range):
  return len([password for password in input_range if matches_criteria(password, True)])


if __name__ == '__main__':
  input_value = '347312-805915'
  input_value_parts = input_value.split('-')
  input_range = range(int(input_value_parts[0]), int(input_value_parts[1]) + 1)
  print(f'Part A: {run_part_a(input_range)}\nPart B: {run_part_b(input_range)}')
