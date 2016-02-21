require './lib/grader/worker'

# Create a new docker grader to play with
grader = Grader::Worker.new

# Run a simple command, then print the output
cmd = ["echo", "Hello World!!!"]

puts grader.exec_cmd cmd

# Run multiple commands (one creates a file), printing output of each
file  = 'test.txt'
snips = [
  ['ls', '-l'],
  ["touch", "#{file}"],
  ['pwd'], 
  ['ls', '-l']
]

grader.exec_cmds snips do |out|
  puts out if out
end

# Get the file created in the previous example
files = {:only => '/etc/hosts', :not => '132.txt'}

grader.get_files files do |id, location|
  puts "#{id}: #{location}"
end

# Run code, then get the file the output is in
code = "print('Hello from R!')"

puts grader.run_code code, "R --no-save --no-restore < #{Grader::Worker::CODE_FILE_PLACEHOLDER} > R.out"

grader.get_files({:the => 'R.out'}) do |id, location|
  puts "#{id}: #{location}"
end

# Run another simple command
puts grader.exec_cmd(['ls', '-l'])

# Done with the grader, get rid of it
grader.close
