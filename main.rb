
Dir["lib/*.rb"].each {|file| require_relative file }	## Require mandatory library files from folder lib.

@assister = CqlAssister.new


=begin
## localhost:9160
client = Cql::Client.connect
client.use('felix')
client.execute("INSERT INTO users (id, email) VALUES ('4', 'foo')", :any)
results = client.execute("SELECT * FROM users", :one)
results.each do |row|
  puts row
end
client.close
=end
