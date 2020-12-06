import functools


def run_part_a(input_chunks):
  return sum([len(set(''.join(chunk))) for chunk in input_chunks])


def run_part_b(input_chunks):
  return sum([len(functools.reduce(lambda a, b: set(a).intersection(b), [line for line in chunk if len(line) > 0])) for chunk in input_chunks])


if __name__ == '__main__':
  with open('input') as input_file:
      input_chunks = [chunk.split('\n') for chunk in input_file.read().split('\n\n')]
      print(f'Part A: {run_part_a(input_chunks)}\nPart B: {run_part_b(input_chunks)}')
