def run_program(input_values, noun, verb):
    intcode = input_values.copy()
    intcode[1] = noun
    intcode[2] = verb

    index = 0

    while True:
      opcode = intcode[index]

      if opcode == 99:
        break

      a = intcode[intcode[index + 1]]
      b = intcode[intcode[index + 2]]

      if opcode == 1:
        intcode[intcode[index + 3]] = a + b
      elif opcode == 2:
        intcode[intcode[index + 3]] = a * b

      index += 4

    return intcode

def run_part_a(intcode):
    return run_program(intcode, 12, 2)[0]


def run_part_b(intcode):
    input_max = 99
    target = 19690720

    for noun in range(input_max):
      for verb in range(input_max):
        if run_program(intcode, noun, verb)[0] == target:
          return 100  * noun + verb



if __name__ == '__main__':
    with open('input') as input_file:
        input_values = [int(value) for value in input_file.read().split(',')]
        print(f'Part A: {run_part_a(input_values)}\nPart B: {run_part_b(input_values)}')
