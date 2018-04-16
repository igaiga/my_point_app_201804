require 'net/http'
require 'uri'
result =  Net::HTTP.post URI('http://localhost:3000/users/1/points/decrease.json'), '{"point": 1}', 'Content-Type'=>'application/json'
p result.body
