class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req| #We use Faraday.get(url) to make a request to the API endpoint.
        req.params['client_id'] = 'SBTKDLCAHKK0DIVCYECTEIFBLC1IW2UCUDUBI124PPUI3FAD'
 #We know we need to set some params from our tests in Postman,
        req.params['client_secret'] = '000O2IAVU4DCEUERHPUBZERQRQZJVLQR552AQO00Z3RXDOCB'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search' #To keep it simple, we're just going to render the search template again with the result.
  end
end
