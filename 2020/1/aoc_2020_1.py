import itertools
import functools


def get_mult(input_lines, numbers):
  return [functools.reduce(lambda a, b: a * b, x) for x in itertools.combinations(input_lines, numbers) if sum(x) == 2020][0]


def run_part_a(input_lines):
  return get_mult(input_lines, 2)


def run_part_b(input_lines):
  return get_mult(input_lines, 3)


if __name__ == '__main__':
  with open('input') as input_file:
      input_lines = [int(line.strip('\n')) for line in input_file.readlines()]
      print(f'Part A: {run_part_a(input_lines)}\nPart B: {run_part_b(input_lines)}')
