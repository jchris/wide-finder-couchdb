require 'rubygems'
require 'couchrest'

couch = CouchRest.new("http://localhost:5984")
db = couch.database('wide-finder')
db.delete! rescue nil
db = couch.create_db('wide-finder')

# usage: ruby import_log.rb logfile.log

puts "Each . corresponds to about 12 lines of logfile, or 1 new doc in CouchDB. The # of lines per doc is randomized to more closely mirror realistic usage."

lines = []
chunk = 0
while line = gets
  lines << line
  if lines.length > rand(100)
    db.save({
      :chunk => chunk, 
      :lines => lines
    })
    chunk += 1
    $stdout.putc '.'
    $stdout.flush
    lines = []
  end
end

puts
puts "run `couchview push views/ wide-finder` to put the views in the db"
puts "then run `ruby wide_find.rb` to see the results"
