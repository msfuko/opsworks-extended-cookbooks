require "net/http"
require "uri"

#get instance-id
uri = URI.parse("http://169.254.169.254/latest/meta-data/instance-id")
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
instance_id = response.body


execute "ec2tag" do
   command "/opt/aws/bin/ec2tag #{instance_id} -t owner=Hideto -t cc=AMT"
   action :run
   ignore_failure true
end

