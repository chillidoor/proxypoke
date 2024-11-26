require "net/http"

module ProxyPoke
  def self.poke(url, proxy_host, proxy_port, read_timeout, search_string)
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
    rescue Net::ReadTimeout
      result, message = "Error", "connection timed out after #{client.read_timeout} seconds"
    rescue Errno::ECONNREFUSED
      result, message = "Error", "could not connect to proxy #{proxy_host} on port #{proxy_port}"
    else
      response_body = response.read_body

      if search_string == ""
        result, message = "Success", "#{proxy_host}:#{proxy_port} is working"
      elsif response_body.include? search_string
        result, message = "Success", "#{proxy_host}:#{proxy_port} is working and the search string was found"
      else
        result, message = "Error", "#{proxy_host}:#{proxy_port} is working but the search string was not found"
      end

    end

    return result, message
  end


end
