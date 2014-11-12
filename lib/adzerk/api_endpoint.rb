module Adzerk
  class ApiEndpoint

    include Adzerk::Util

    attr_reader :client, :endpoint, :object_name

    def initialize(args= {})
      @client = args[:client]
      @endpoint = args[:endpoint]
      @object_name = args[:object_name] || @endpoint
    end

    def create(opts={})
      data = { object_name => camelize_data(opts).to_json }
      response = @client.post_request(endpoint, data)
      parse_response(response)
    end

    def get(id)
      response = @client.get_request("#{endpoint}/#{id}")
      parse_response(response)
    end

    def list
      response = @client.get_request(endpoint)
      parse_response(response)
    end

    def update(opts={})
      id = opts[:id].to_s
      data = { object_name => camelize_data(opts).to_json }
      response = @client.put_request("#{endpoint}/#{id}", data)
      parse_response(response)
    end

    def delete(id)
      url = "#{endpoint}/#{id}/delete"
      @client.get_request(url)
    end
  end
end
