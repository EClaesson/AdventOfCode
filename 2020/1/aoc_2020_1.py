def run_part_a(input_lines):
  for x in input_lines:
    for y in input_lines:
      if x + y == 2020:
        return x * y


def run_part_b(input_lines):
  for x in input_lines:
    for y in input_lines:
      for z in input_lines:
        if x + y + z == 2020:
          return x * y * z


if __name__ == '__main__':
  with open('input') as input_file:
      input_lines = [int(line.strip('\n')) for line in input_file.readlines()]
      print(f'Part A: {run_part_a(input_lines)}\nPart B: {run_part_b(input_lines)}')
