require "minitest/autorun"
require "webmock/minitest"

require "proxypoke"


class ProxyPokeTest < Minitest::Test
  def test_cant_connect_to_proxy
    stub_request(:get, "https://www.google.com").to_raise(Errno::ECONNREFUSED)
    result = ProxyPoke.poke("https://www.google.com", "localhost", "3128", 1)
    
    assert_equal result, ["Error", "could not connect to proxy localhost on port 3128"]
  end

  def test_read_timeout
    stub_request(:get, "https://www.google.com").to_raise(Net::ReadTimeout)
    result = ProxyPoke.poke("https://www.google.com", "localhost", "3128", 0.1)

    assert_equal result, ["Error", "connection timed out after 0.1 seconds"]
  end

  def test_successful_request
    stub_request(:get, "https://www.google.com")
    result = ProxyPoke.poke("https://www.google.com", "localhost", "3128", 1)

    assert_equal result, ["Success", "localhost:3128 is working"]
  end
end
