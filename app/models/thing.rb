class Thing
    include DataMapper::Resource

    property :id, Serial
    property :name, Text
end
