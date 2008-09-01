require 'rubygems'
require 'couchrest'

couch = CouchRest.new("http://localhost:5984")
db = couch.database('wide-finder')
db.delete! rescue nil
db = couch.create_db('wide-finder')

logfile = File.dirname(__FILE__) + '/wf100k.log'

File.open(logfile, 'r') do |file|
  lines = []
  chunk = 0
  while line = file.gets
    lines << line
    if lines.length > rand(100)
      db.save({
        :chunk => chunk, 
        :lines => lines
      })
      chunk += 1
      $stdout.putc 'c'
      $stdout.flush
      lines = []
    end
  end
end

puts
puts "run `couchview push views/ wide-finder` to put the views in the db"
puts "then run `ruby wide_find.rb` to see the results"
