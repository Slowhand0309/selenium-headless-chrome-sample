require 'selenium-webdriver'

Selenium::WebDriver::Chrome::Service.driver_path = '/usr/bin/chromedriver'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless')
options.add_argument('--disable-gpu')
options.add_argument('--no-sandbox')

d = Selenium::WebDriver.for :chrome, options: options

d.get('https://www.yahoo.co.jp/')
d.save_screenshot('yahoo.png')
sleep 3
