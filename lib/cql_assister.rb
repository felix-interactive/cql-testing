require 'cql'

class CqlAssister
  attr_reader :client
  ## When initialized, set instance variable to establish connection with Cassandra and setup keyspace and tables through
  ## init file unless overided.
  def initialize(keyspace = "felix", replication_factor = 1, init_file = "init", options={})
    ## Given the options, connect to the Cassandra server
    @client = Cql::Client.connect(options)

    ## Check to see if keyspace exists, if it does, drop it and recreate!
    result = @client.execute("SELECT * FROM system.schema_keyspaces WHERE keyspace_name='#{keyspace}'", :all)
    unless result.empty?
      @client.execute("DROP KEYSPACE #{keyspace}")
    end

    ## Create keyspace
    @client.execute("CREATE KEYSPACE #{keyspace}
      WITH replication = {
        'class': 'SimpleStrategy',
        'replication_factor': #{replication_factor}
      }")
    ## Use it
    @client.use(keyspace)

    ## Initialize from file, init, unless overided.
    initialize_schema(init_file)

  end

  def execute(cqlCode)
    @client.execute(cqlCode, :one)
  end





private

  ## Read from file
  def read_each_line_file(filename)
    ## Open the file to read each line and output it
    ## Ends line when semicolon (;) appears then yield
      finaloutput = ""
      File.open(filename, "r").each_line do |line|
        ## If an error occurs from dropping it, rescue and put it out to terminal
        output = line.chomp
        if output[-1] != ';'
          finaloutput << output
        else
          finaloutput << output
          puts finaloutput
          yield finaloutput
          finaloutput = ""
        end
      end
  end

  def initialize_schema(init_file)
    ## Go through each line and execute
    puts "Preparing from #{init_file}"
    ## Open the file to read each line and output it
    read_each_line_file(init_file) do |line|
      results = @client.execute(line)
    end

  end




end
