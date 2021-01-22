
class Application

    @@items = [
        Item.new("Figs", 3.42),
        Item.new("Pears", 0.99)]

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_array = req.path.split("/items/")
            item_name = item_array[item_array.length - 1]
            count = 0

            @@items.each do |item|
                if item.name == item_name
                    resp.write "#{item.price}"
                    count += 1
                end
            end
            if count == 0
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end


end