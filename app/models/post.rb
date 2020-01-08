class Post
    include DataMapper::Resource

    property :id, Serial
    property :message, Text
    property :picture, Text
    property :created_time, DateTime
    property :link, Text
    property :fb_id, Text
    property :reactions, Integer
    property :comments, Integer

end
