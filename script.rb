# nethttp.rb
require 'uri'
require 'net/http'

host = 'http://localhost:5002/api/products/'
id_pool = (1..77).to_a
sum = 0

# 100.times {
#     threads = []
#     starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
#     10.times {
#         threads << Thread.new { 
#             while !success do
#                 id = id_pool.shuffle.take(1)
#                 uri = URI(host + id[0].to_s)
#                 res = Net::HTTP.get_response(uri)
#                 if res.is_a?(Net::HTTPSuccess) then
#                     puts res.body
#                     success = true
#                 else
#                   next
#                 end
#             end 
#         }
#     }
#     threads.each(&:join)
#     ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
#     elapsed = ending - starting
#     puts "%.3f" % elapsed
#     sum += elapsed
# }

# puts "%.2f" % sum

for i in 0..100 do
    threads = []
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    100.times {
        threads << Thread.new { 
            success = false
            while !success do
                id = id_pool.shuffle.take(1)
                uri = URI(host + id[0].to_s)
                res = Net::HTTP.get_response(uri)
                if res.is_a?(Net::HTTPSuccess) then
                    puts res.body
                    success = true
                else
                  next
                end
            end 
        }
    }
    threads.each(&:join)
	#threads.each { |thr| thr.join }
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting
    puts "%.3f" % elapsed
    sum += elapsed
    puts sum
end

# 
# starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
# while !success do
#     id = id_pool.shuffle.take(1)
#     uri = URI(host + id[0].to_s)
#     res = Net::HTTP.get_response(uri)
#     if res.is_a?(Net::HTTPSuccess) then
#         puts res.body
#         ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
#         success = true
#     else
#         next
#     end
# end
# 
# elapsed = ending - starting
# puts "%.3f" % elapsed