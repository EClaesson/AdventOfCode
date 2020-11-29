PARAMETER_COUNTS = {
  1: 3,
  2: 3,
  3: 1,
  4: 1,
  5: 2,
  6: 2,
  7: 3,
  8: 3,
  99: 0,
}


def get_value(intcode, parameter_mode, parameter_value):
  return parameter_value if parameter_mode == 1 else intcode[parameter_value]


def get_op(intcode, index):
  op = str(intcode[index])
  opcode = int(op[-2:])
  parameter_modes = [int(mode) for mode in op[:-2]]
  parameter_modes.reverse()
  parameter_count = PARAMETER_COUNTS[opcode]
  increment = parameter_count + 1
  parameter_values = intcode[(index + 1):(index + parameter_count + 1)]

  while len(parameter_modes) < parameter_count:
    parameter_modes.append(0)

  parameters = [get_value(intcode, parameter_modes[parameter_index], parameter_value) for parameter_index, parameter_value in enumerate(parameter_values)]

  last_raw = parameter_values[-1] if len(parameter_values) > 0 else None

  return (opcode, parameters, last_raw, increment)


def run_program(input_values):
  intcode = input_values.copy()
  index = 0

  while True:
    opcode, parameters, last_raw, increment = get_op(intcode, index)
    do_increment = True

    if opcode == 1:
      intcode[last_raw] = parameters[0] + parameters[1]
    elif opcode == 2:
      intcode[last_raw] = parameters[0] * parameters[1]
    elif opcode == 3:
      intcode[last_raw] = int(input('> '))
    elif opcode == 4:
      print(f'={intcode[last_raw]}')
    elif opcode == 5:
      if parameters[0] != 0:
        index = parameters[1]
        do_increment = False
    elif opcode == 6:
      if parameters[0] == 0:
        index = parameters[1]
        do_increment = False
    elif opcode == 7:
      intcode[last_raw] = 1 if parameters[0] < parameters[1] else 0
    elif opcode == 8:
      intcode[last_raw] = 1 if parameters[0] == parameters[1] else 0
    elif opcode == 99:
      break

    if do_increment:
      index += increment


def run_part_a(intcode):
  run_program(intcode)


def run_part_b(intcode):
  run_program(intcode)


if __name__ == '__main__':
    with open('input') as input_file:
        input_values = [int(value) for value in input_file.read().split(',')]
        print('Part A:')
        run_part_a(input_values)
        print()
        print('Part B:')
        run_part_b(input_values)
