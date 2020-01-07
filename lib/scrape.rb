"""
Taken from https://github.com/ritvikmath/ScrapingData/blob/master/Scraping%20Facebook%20Data.ipynb
and translated to ruby
"""

require 'net/http'
require 'json'

access_token = "EAAImr7nn3wQBAG1MgKnFZAoeX0F3SsMJ117cVH9Wb1C73b92hY4MrzHjbwqAZCOo69qEtWnoABUT5bv3NTggDZAJipETkpZAZAZCtmz6rjs3OOU1l2W11uKwOVZBir0Bw0fNn6U7HiAwAsvESBPFJ34RFAfGnTrei1xc0aMUEAcszDJmgO10ykYX356P4tSRLpDGCidyhseCepkEhMKgGXuk3FGM9oRZBALr106myd4klQZDZD"

"""
INPUTS:
    url: a request url
OUTPUTS:
    the data returned by calling that url
"""
def request_data_from_url(url)
    req = URI(url)
    success = false
    while success == false
        begin
            #open the url
            response = Net::HTTP.get_response(req)

            #200 is the success code for http
            if response.code == "200"
                success = true
            end
        rescue Exception => e
            #if we didn't get a success, then print the error and wait 5 seconds before trying again
            print(e)
            sleep(5)
            print "Error for URL #{url}: #{Time.now}"
            print "Retrying..."

        end
    end
    #return the contents of the response
    return response.body # Problemer med æ, ø og å
end

"""
INPUTS:
    page_id: the unique id for the facebook page you are trying to scrape
    access_token: authentication proving that you have a valid facebook account
OUTPUTS:
    a python dictionary of the data on your requested page
"""
def get_facebook_page_data
    website = "https://graph.facebook.com/v5.0/"
    page_id = "852892394871017"
    location = "#{page_id}/feed/"
    #the .limit(0).summary(true) is used to get a summarized count of all the ...
    #...comments and reactions instead of getting each individual one
    fields = "?fields=message,full_picture,created_time,name,link,id,reactions.limit(0).summary(true)" # Måske mindre, men måske også comments

    authentication = "&limit=100&access_token=" + access_token

    request_url = website + location + fields + authentication

    #converts facebook's response to a ruby hash to easier manipulate later
    data = JSON.parse(request_data_from_url(request_url))
    return data
end










print(get_facebook_page_data())
