# Services

## What is a service (object)?
A service object [..] is a Ruby module which encapsulates the logic for completing an action.<sup>1</sup>

## When you should use them?
Mostly you would use them in controllers, however you could also call them in other models, services, whatever.  

**Remember**:  
Controllers should only "know" what to do (for example: generate a pdf), not how it will be done.
That's where the service comes in.

## How to implement them?

Normally, you would create a new file named `very_cool_**service**.rb` inside `app/services/`.
Often, the only publicly exposed method is a method called `perform` (actually it doesn't matter how you name it, 
because the service is just a normal Ruby class). This method will return some value (may it be just true or 
false, a hash of calculated values, whatever), which you can use at the place where you call the service.

This is an example for a service, which is used to scan a file for viruses:

```ruby
class ScanService
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def perform
    scan_response.class != ClamAV::VirusResponse
  end

private

  def client
    @client ||= Rails.env.development? ? ClamavClient.local : ClamavClient.tcp
  end

  def scan_response
    file.open do |tempfile|
      client.execute ClamAV::Commands::InstreamCommand.new tempfile
    end
  end

  def client_offline
    return false if client.execute(ClamAV::Commands::PingCommand.new)
  rescue Errno::ENOENT => e
    raise_error_and_return e
    true
  end

  def raise_error_and_return(exception)
    Rails.env.development? ? raise(exception) : Raven.capture_exception(exception)
  end
end
```

## How you can use them (in your controller)?
It's as easy as instantiating a new object of the service class with passing the required parameters
and calling the perform method.

Check out this example controller action using a service, which returns a created PDF file:

```ruby
class ReportsController < ApplicationController
# ...

def download_report
  start_at, end_at = report_params.values_at(:start_at, :end_at)
  summary_pdf = SummaryPdfService.new(start_at, end_at).perform
  send_data summary_pdf, filename: "summary.pdf", type: "application/pdf"
end

# ...
```

## Additional tips

- try to keep the perform method as clean as possible, so that a reader can easily spot what the service is doing internally
- don't use a service for different tasks, they should do one thing
- write good tests for your service (as for any other code, too); you can mock the results of the service in other tests if you want
- if you have multiple service, think about grouping them in a namespace
- in general: stick to naming conventions and how you structure and call your services

## Resources
1) https://www.rubyguides.com/2019/09/rails-patterns-presenter-service/
2) https://medium.com/selleo/essential-rubyonrails-patterns-part-1-service-objects-1af9f9573ca1
