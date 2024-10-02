require "net/http"

module ProxyPoke
  def self.poke(url, proxy_host, proxy_port)
    uri = URI(url)

    client = Net::HTTP.new(
      address = uri.host,
      port = uri.port,
      p_addr = proxy_host,
      p_port = proxy_port,
    )

    client.use_ssl = uri.scheme == "https" ? true : false
    client.read_timeout = 3
    
    begin
      response = client.get(url)
    rescue Net::ReadTimeout
      puts "Error: connection timed out after #{client.read_timeout} seconds"
      exit(false)
    rescue Errno::ECONNREFUSED
      puts "Error: could not connect to proxy #{proxy_host} on port #{proxy_port}"
      exit(false)
    end

    puts "Success: #{proxy_host}:#{proxy_port} is working"
    exit(true)
  end


end
