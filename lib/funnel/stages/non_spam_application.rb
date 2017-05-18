require_relative './stage'

class NonSpamApplication < Stage
  attr_accessor :applications, :spam_mapping

  def load
    ids = @parent.applications.map { |a| a[:id] }

    # Returns a hash formatted like: { id -> is_spam? }
    output = Website.run_cmd(
      "rails runner 'output = {}; [#{ids.join(', ')}].each { |id| "\
      "output[id] = ClubApplication.find(id).is_spam? "\
      "}; puts output.to_json'"
    )
    spam_mapping_raw = JSON.parse(output)

    # JSON doesn't allow integers as keys. Convert our string key integers into
    # actual integers we can key on.
    #
    # {"249" => true} -> {249 => true}
    @spam_mapping = Hash[spam_mapping_raw.map { |k, v| [k.to_i, v] } ]
  end

  def process
    @applications = @parent.applications.select do |app|
      is_spam = @spam_mapping[app[:id]]

      !is_spam
    end
  end

  def count
    @applications.count
  end
end
