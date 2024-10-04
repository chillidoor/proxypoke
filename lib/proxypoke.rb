require "net/http"

module ProxyPoke
  def self.poke(url, proxy_host, proxy_port, read_timeout)
    uri = URI(url)

    client = Net::HTTP.new(
      address = uri.host,
      port = uri.port,
      p_addr = proxy_host,
      p_port = proxy_port,
    )

    client.use_ssl = uri.scheme == "https" ? true : false
    client.read_timeout = read_timeout
    
    begin
      response = client.get(url)
      result, message = "Success", "#{proxy_host}:#{proxy_port} is working"
    rescue Net::ReadTimeout
      result, message = "Error", "connection timed out after #{client.read_timeout} seconds"
    rescue Errno::ECONNREFUSED
      result, message = "Error", "could not connect to proxy #{proxy_host} on port #{proxy_port}"
    end

    return result, message
  end


end
