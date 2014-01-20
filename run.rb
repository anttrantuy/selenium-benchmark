require_relative 'lib/page-objects/tables'
#require_relative '../lib/page-objects/large_dom'
require_relative 'lib/table_generator'

ENV['iterations'] ||= '100'
# override the number of iterations at runtime with '`iterations=20 ruby css_vs_xpath.rb`

ENV['browser'] ||= 'firefox'
# override browser at runtime with `browser='browser_name' ruby css_vs_xpath.rb`

driver = Selenium::WebDriver.for ENV['browser'].to_sym
# Set up and start the-internet before running the test
# `cd the-internet`
# `bundle install`
# `ruby server.rb`

ENV['base_url'] = 'http://localhost:4567'

$stdout = File.new("benchmarks/#{ENV['browser']}.log", 'w')
$stdout.sync = true

tables = Tables.new(driver)
tables.visit
tables.benchmark!

#large_dom = LargeDOM.new(@driver)
#large_dom.visit
#large_Dom.benchmark!

# The benchmarking approach was borrowed from
# http://rubylearning.com/blog/2013/06/19/how-do-i-benchmark-ruby-code/

driver.quit
gen = TableGenerator.new
gen.run
