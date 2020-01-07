"""
Taken from https://github.com/ritvikmath/ScrapingData/blob/master/Scraping%20Facebook%20Data.ipynb
and translated to ruby
"""

require 'net/http'
require 'json'

=begin
INPUTS:
    url: a request url
OUTPUTS:
    the data returned by calling that url
=end
def request_data_from_url(url)
    req = URI(url)
    success = false
    while success == false
        begin
            # open the url
            response = Net::HTTP.get_response(req)

            # 200 is the success code for http
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

=begin
INPUTS:
    page_id: the unique id for the facebook page you are trying to scrape
    access_token: authentication proving that you have a valid facebook account
OUTPUTS:
    a python dictionary of the data on your requested page
=end
def get_facebook_page_data
    website = "https://graph.facebook.com/v5.0/"
    page_id = "852892394871017"
    location = "#{page_id}/feed/"

    access_token = "EAAImr7nn3wQBAIcBGozrZA981MYcT4k7pHk6qZAs8JRDZAZBw6cmdjiBPJS2UuoMkNYptM02oZBUYxssEZBXPOevynqc5BTib48md9H0XnX3tKZAFCd1VYZC1LfPU52j4ZAdR7geWGPvuIrLt3pssue3ouOCZBNazmqYMPe6UppLFSAoA8Gt4l1rl4QgMVAJQD0Km6VPVP52rV3wZDZD"

    #the .limit(0).summary(true) is used to get a summarized count of all the ...
    #...comments and reactions instead of getting each individual one
    fields = "?fields=message,full_picture,created_time,name,link,id,reactions.limit(0).summary(true)" # Måske mindre, men måske også comments

    authentication = "&limit=100&access_token=" + access_token

    request_url = website + location + fields + authentication

    #converts facebook's response to a ruby hash to easier manipulate later
    data = JSON.parse(request_data_from_url(request_url))
    return data["data"]
end

=begin
INPUTS:
    json data from get_facebook_page_data
OUTPUTS:
    json data with the fields (not necessarily in this order):
    name, message, created_time, like, love, wow, haha, sad, angry, picture, link, popularity

    where popularity is given as like + love + wow + haha - sad - angry. It is used for ordering the data
=end
