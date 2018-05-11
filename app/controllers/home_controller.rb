class HomeController < ActionController::Base
  def index
    queries = params[:q].chars.each_slice(3).to_a
    results = queries.flat_map do |q|
      http = Curl.get("https://api.duckduckgo.com/?q=#{q.join}&format=json")
      res = JSON.parse(http.body_str)
      res["RelatedTopics"]
    end

    render results: results.shuffle
  end
end
