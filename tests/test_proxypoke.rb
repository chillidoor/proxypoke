require "minitest/autorun"
require "webmock/minitest"

require "proxypoke"


class ProxyPokeTest < Minitest::Test
  def test_cant_connect_to_proxy
    stub_request(:get, "https://dummysite").to_raise(Errno::ECONNREFUSED)
    result = ProxyPoke.poke("https://dummysite", "localhost", "3128", 1)
    
    assert_equal result, ["Error", "could not connect to proxy localhost on port 3128"]
  end

  def test_read_timeout
    stub_request(:get, "https://dummysite").to_raise(Net::ReadTimeout)
    result = ProxyPoke.poke("https://dummysite", "localhost", "3128", 0.1)

    assert_equal result, ["Error", "connection timed out after 0.1 seconds"]
  end

  def test_successful_request
    stub_request(:get, "https://dummysite")
    result = ProxyPoke.poke("https://dummysite", "localhost", "3128", 1)

    assert_equal result, ["Success", "localhost:3128 is working"]
  end

  def test_search_string_not_found_in_response
    stub_request(:get, "https://dummysite").to_return(body: "dummy body")
    result = ProxyPoke.poke("https://dummysite", "localhost", "3128", 1, "string")

    assert_equal result, ["Error", "localhost:3128 is working but the search string was not found"]
  end

  def test_search_string_found_in_response
    stub_request(:get, "https://dummysite").to_return(body: "dummy body")
    result = ProxyPoke.poke("https://dummysite", "localhost", "3128", 1, "dummy body")

    assert_equal result, ["Success", "localhost:3128 is working and the search string was found"]
  end
end
