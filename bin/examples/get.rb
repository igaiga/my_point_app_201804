require "net/http"
require "uri"
require "json"
uri = URI.parse("http://localhost:3000/users/1/points.json")
string = Net::HTTP.get(uri)
hash = JSON.parse(string)
p hash
#p hash["points"]
