"""
Taken from https://github.com/ritvikmath/ScrapingData/blob/master/Scraping%20Facebook%20Data.ipynb
and translated to ruby
"""

require 'net/http'
require 'json'
require 'date'

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

    # To get new long-lasting access-token, go to https://developers.facebook.com/tools/explorer?method=GET&path=&version=v5.0
    # Check info of access token and extend it
    access_token = "EAAImr7nn3wQBAKdfoRwAdhpZCW2TXaZCaOX2pTHWXspeqS7cYZA9ls6p3wpxXmlAKwt0ZCV7ybinEtNIzTCFKTbMT2Dkj291RGXezozDjfnc5r6Q4bErFsUIpGlUDIroOzScoKrkxJ4D4mEBZAeGynZBk8lEjVj87gpjYD8r7BJwZDZD"

    #the .limit(0).summary(true) is used to get a summarized count of all the ...
    #...comments and reactions instead of getting each individual one
    fields = "?fields=message,full_picture,created_time,permalink_url,id,reactions.limit(0).summary(true),comments.limit(0).summary(true)" # Måske mindre, men måske også comments

    authentication = "&limit=100&access_token=" + access_token

    request_url = website + location + fields + authentication

    #converts facebook's response to a ruby hash to easier manipulate later
    data = JSON.parse(request_data_from_url(request_url))
    return data
end

=begin
INPUTS:
    post: information about a single post on the facebook page
    access_token: authentication proving that you have a valid facebook account
OUTPUTS:
    a list with the requested fields for this post
=end
def process_post(post)

    post_id = post["id"]

    post_message = post.keys.include?("message") ? post["message"] : ""

    post_picture = post.keys.include?("full_picture") ? post["full_picture"] : ""

    post_link = post["permalink_url"]

    #for datetime info, we need a few extra steps
    #first convert the given datetime into the format we want
    post_published = DateTime.strptime(post["created_time"],"%Y-%m-%dT%H:%M:%S+0000")
    #then account for the time difference between the returned time and my time zone
    post_published = post_published + (1.0 / 24.0) # + 1 hour

    num_reactions = post.include?("reactions") ? post["reactions"]["summary"]["total_count"] : 0
    num_comments = post.include?("comments") ? post["comments"]["summary"]["total_count"] : 0

    #return a list of all the fields we asked for
    hash = { :message => post_message, :picture => post_picture, :created_time => post_published, :link => post_link, :fb_id => post_id, :reactions => num_reactions, :comments => num_comments }
    return hash
end


def update_post_in_database(post_hash)
    # try and find post in database using fb_id
    post = Post.first(:fb_id => post_hash[:fb_id])
    # If you find it, update it, if it needs to be updated
    if !post.nil?
        post.update(post_hash)
    # Otherwise make a new database entry
    else
        Post.create(post_hash)
    end
end

# Function to make the whole database
def update_database()
    has_next_page = true
    num_processed = 0
    scrape_starttime = DateTime.now

    print "Scraping Matematik Memes Facebook Page: #{scrape_starttime}\n"

    #get first batch of posts
    posts = get_facebook_page_data()

    #while there is another page of posts to process
    while has_next_page do

        #if num_processed == 200
        #    break
        #end

        #for each individual post in our retrieved posts ...
        for post in posts['data']

            #...get post info and write to our spreadsheet
            update_post_in_database(process_post(post))

            num_processed += 1
        end

        #if there is a next page of posts to get, then get next page to process
        if posts.keys.include?("paging")
            posts = JSON.parse(request_data_from_url(posts["paging"]["next"]))
        #otherwise, we are done!
        else
            has_next_page = false
        end
    end

    print("Completed!\n#{num_processed} posts Processed in #{DateTime.now - scrape_starttime}")
end


# Get a lasting access token (https://developers.facebook.com/docs/facebook-login/access-tokens/#apptokens)
