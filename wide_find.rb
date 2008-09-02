require 'rubygems'
require 'couchrest'

couch = CouchRest.new("http://localhost:5984")
db = couch.database('wide-finder')

def printTop(results, num = 10)
  num = results['rows'].length
  results['rows'].sort_by{|r| r['value']}[(num-10)..(num-1)].reverse.each do |row|
    puts "#{row['value'].to_s.ljust(20)} #{row['key']}"
  end
end

puts "Top 10 URIs by Hits"
results = db.view('wf/uri-hits-reduce', :group => true)
printTop(results)

puts
puts "Top 10 URIs by Bytes"
results = db.view('wf/uri-bytes-reduce', :group => true)
printTop(results)

puts
puts "Top 10 404s by Hits"
results = db.view('wf/404-hits-reduce', :group => true)
printTop(results)

puts
puts "Top 10 404s by Bytes"
results = db.view('wf/404-bytes-reduce', :group => true)
printTop(results)


# report('URIs by hit', @u_hits)
# report('URIs by bytes', @u_bytes, true)
# report('404s', @s404s)
# report('client addresses', @clients)
# report('referrers', @refs)