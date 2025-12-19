require "net/http"
require "json"

module Notes
  class SummarizeService
    OLLAMA_URL = "http://localhost:11434/api/generate".freeze
    MODEL_NAME = "mistral".freeze

    def initialize(content)
      @content = content
    end

    def call
      uri = URI(OLLAMA_URL)

      request = Net::HTTP::Post.new(uri)
      request["Content-Type"] = "application/json"

      request.body = {
        model: MODEL_NAME,
        prompt: summary_prompt,
        stream: false
      }.to_json

      response = Net::HTTP.start(
        uri.hostname,
        uri.port,
        open_timeout: 5,
        read_timeout: 30
      ) do |http|
        http.request(request)
      end

      parse_response(response)
    rescue StandardError => e
      Rails.logger.error("Ollama summarization failed: #{e.message}")
      fallback_summary
    end

    private

    def summary_prompt
      <<~PROMPT
        Summarize the following note clearly and concisely in 2-3 sentences:

        #{@content}
      PROMPT
    end

    def parse_response(response)
      return fallback_summary unless response.is_a?(Net::HTTPSuccess)

      body = JSON.parse(response.body)
      body["response"] || fallback_summary
    end

    def fallback_summary
      "Summary not available at the moment."
    end
  end
end
