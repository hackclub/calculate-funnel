class Website
  HEROKU_APP = 'website-hackclub'

  def self.run_cmd(cmd)
    output = Heroku.run_cmd(cmd, HEROKU_APP)

    # strip the first two lines from output
    #
    # currently first two outputs look like this:
    #
    # > /app/vendor/bundle/ruby/2.2.0/gems/activesupport-4.1.1/lib/active_support/values/time_zone.rb:285: warning: circular argument reference - now
    # > W, [2017-05-18T13:25:58.141517 #4]  WARN -- sentry: ** [Raven] Unable to load raven/integrations/rack-timeout: cannot load such file -- rack/timeout/base
    #
    # which are useless. this strips those and lets us play with output from our command directly.
    output.lines.to_a[2..-1].join
  end

  def self.applications_in_month(month, year)
    output = self.run_cmd(
      "rails runner 'puts ClubApplication.where(\"extract(month from created_at) = ? AND extract(year from created_at) = ?\", #{month}, #{year}).to_json'"
    )

    JSON.parse(output, symbolize_names: true)
  end
end
