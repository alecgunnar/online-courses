class Docker
  DOCKER_IMAGE_NAME     = 'wmucs/oc'
  CODE_FILE_PLACEHOLDER = '!code_file!'

  @@name

  # Call up docker to create a new container
  # for us to work with.
  def initialize
    chars  = ('a'..'z').to_a
    @@name = (0..9).map { chars[rand 26] }.join
    `docker run --name #{@@name} -d -t #{DOCKER_IMAGE_NAME} bash`
  end

  # Destroy the container
  def close
    `docker rm -f #{@@name}`
  end

  # Some commands have redirection or other operations
  # involved which can get stripped. Use this function
  # to prevent that.
  def wrap_cmd (cmd)
    "bash -c '#{cmd}'"
  end

  # Execute a command in the container
  def exec_cmd (cmd)
    `docker exec #{@@name} #{cmd}`
  end

  # Execute multiple commands
  def exec_cmds (cmds, &block)
    cmds.each do |cmd|
      yield exec_cmd cmd
    end
  end

  # Get files from the container
  def get_files (files, &block)
    path = "/tmp/#{@@name[0..15]}"
    
    Dir.mkdir path unless Dir.exists? path

    files.each do |id, name|
      yield id, (system("docker cp #{@@name}:#{name} #{path} &> /dev/null") ? "#{path}/#{name}" : false)
    end
  end

  # Run some code! You must supply the code itself,
  # and the command necessary to run it.
  def run_code (code, cmd)
    file_name   = "#{@@name}.code"
    local_file  = "/tmp/#{@@name}.code"

    IO::write local_file, code

    `docker cp #{local_file} #{@@name}:#{file_name}`

    exec_cmd wrap_cmd(cmd.gsub(CODE_FILE_PLACEHOLDER, file_name))
  end
end
