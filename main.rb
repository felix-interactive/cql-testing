
Dir["lib/*.rb"].each {|file| require_relative file }	## Require mandatory library files from folder lib.

def output_results(cqlResults)
  cqlResults.each do |row|
    puts row
  end
end
@assister = CqlAssister.new

statement = @assister.execute("INSERT INTO application_by_teams (team_id, app_id, app_name) VALUES (blobAsUuid(now()), now(), 'my app')")
statement = @assister.execute("INSERT INTO application_by_teams (team_id, app_id, app_name) VALUES (blobAsUuid(now()), now(), 'my app')")
statement = @assister.execute("INSERT INTO application_by_teams (team_id, app_id, app_name) VALUES (blobAsUuid(now()), now(), 'my app')")
statement = @assister.execute("INSERT INTO application_by_teams (team_id, app_id, app_name) VALUES (blobAsUuid(now()), now(), 'my app')")
statement = @assister.execute("INSERT INTO application_by_teams (team_id, app_id, app_name) VALUES (blobAsUuid(now()), now(), 'my app')")
output_results(@assister.execute("SELECT * FROM application_by_teams GROUP BY team_id"))

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
