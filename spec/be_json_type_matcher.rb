RSpec::Matchers.define :be_json_type do |expected|
  match do |response|
    match_json_structure_helper(expected, response)
  end

  def match_json_structure_helper(expected, response)
    expected.each do |key, value|
      if value.is_a?(Hash)
        return false unless is_hash_and_have_key?(response, key)
        return false unless match_json_structure_helper(value, response[key])
      elsif value.eql?([])
        return false unless response[key].eql?([])
      elsif value.is_a?(Array)
        return false unless match_json_structure_helper(value.first, response[key].first)
      else
        return false unless is_hash_and_have_key?(response, key) &&
                            (response[key].eql?(value) || response[key].is_a?(value))
      end
    end
  end

  def is_hash_and_have_key?(response, key)
    response.is_a?(Hash) && response.key?(key)
  end
end
